# Quick Start Guide

Get up and running with the Flutter GetX Clean Architecture project in minutes.

## 🚀 Setup Steps

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Create Environment Files

Copy the template and create environment files:

```bash
# Windows
copy env.template .env.dev
copy env.template .env.staging
copy env.template .env.prod

# Linux/Mac
cp env.template .env.dev
cp env.template .env.staging
cp env.template .env.prod
```

### 3. Configure Environment Variables

Edit each `.env.*` file with your API configuration:

```env
ENVIRONMENT=dev
APP_NAME=Spotify Replica Dev
API_BASE_URL=https://your-api-url.com
API_KEY=your_api_key
CONNECT_TIMEOUT=30000
RECEIVE_TIMEOUT=30000
```

### 4. Run the App

```bash
# Development
flutter run --dart-define=ENV=dev

# Staging
flutter run --dart-define=ENV=staging

# Production
flutter run --dart-define=ENV=prod
```

## 📝 Adding a New Feature

Follow these steps to add a new feature (e.g., "Playlist"):

### Step 1: Create Domain Entity

```dart
// lib/domain/entities/playlist_entity.dart
class PlaylistEntity {
  final String id;
  final String name;
  final String? description;
  
  const PlaylistEntity({
    required this.id,
    required this.name,
    this.description,
  });
}
```

### Step 2: Create Repository Interface

```dart
// lib/domain/repositories/playlist_repository.dart
abstract class PlaylistRepository {
  Future<List<PlaylistEntity>> getPlaylists();
  Future<PlaylistEntity> getPlaylistById(String id);
}
```

### Step 3: Create Use Cases

```dart
// lib/domain/usecases/get_playlists_usecase.dart
class GetPlaylistsUseCase {
  final PlaylistRepository repository;
  GetPlaylistsUseCase(this.repository);
  
  Future<List<PlaylistEntity>> call() => repository.getPlaylists();
}
```

### Step 4: Create Data Model

```dart
// lib/data/models/playlist_model.dart
class PlaylistModel extends PlaylistEntity {
  const PlaylistModel({
    required super.id,
    required super.name,
    super.description,
  });
  
  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
```

### Step 5: Create Data Sources

```dart
// lib/data/data_sources/playlist_remote_data_source.dart
abstract class PlaylistRemoteDataSource {
  Future<List<PlaylistModel>> getPlaylists();
}

class PlaylistRemoteDataSourceImpl implements PlaylistRemoteDataSource {
  final ApiClient apiClient;
  
  PlaylistRemoteDataSourceImpl({required this.apiClient});
  
  @override
  Future<List<PlaylistModel>> getPlaylists() async {
    final response = await apiClient.get(ApiEndpoints.playlists);
    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => PlaylistModel.fromJson(json)).toList();
  }
}
```

### Step 6: Create Repository Implementation

```dart
// lib/data/repositories/playlist_repository_impl.dart
class PlaylistRepositoryImpl implements PlaylistRepository {
  final PlaylistRemoteDataSource remoteDataSource;
  
  PlaylistRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<List<PlaylistEntity>> getPlaylists() async {
    try {
      final models = await remoteDataSource.getPlaylists();
      return models;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw UnknownFailure('An unexpected error occurred');
    }
  }
  
  @override
  Future<PlaylistEntity> getPlaylistById(String id) async {
    // Implementation
  }
}
```

### Step 7: Create Controller

```dart
// lib/presentation/controllers/playlist_controller.dart
class PlaylistController extends GetxController {
  final GetPlaylistsUseCase getPlaylistsUseCase;
  
  PlaylistController({required this.getPlaylistsUseCase});
  
  final _playlists = <PlaylistEntity>[].obs;
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  
  List<PlaylistEntity> get playlists => _playlists;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  
  @override
  void onInit() {
    super.onInit();
    loadPlaylists();
  }
  
  Future<void> loadPlaylists() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      _playlists.value = await getPlaylistsUseCase();
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
```

### Step 8: Create Binding

```dart
// lib/presentation/bindings/playlist_binding.dart
class PlaylistBinding extends Bindings {
  @override
  void dependencies() {
    final apiClient = Get.find<ApiClient>();
    
    final remoteDataSource = Get.put(
      PlaylistRemoteDataSourceImpl(apiClient: apiClient),
    );
    
    final repository = Get.put(
      PlaylistRepositoryImpl(remoteDataSource: remoteDataSource),
    );
    
    final getPlaylistsUseCase = Get.put(
      GetPlaylistsUseCase(repository),
    );
    
    Get.lazyPut<PlaylistController>(
      () => PlaylistController(getPlaylistsUseCase: getPlaylistsUseCase),
    );
  }
}
```

### Step 9: Create View

```dart
// lib/presentation/views/playlist/playlist_view.dart
class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlaylistController>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Playlists')),
      body: Obx(() {
        if (controller.isLoading) {
          return const LoadingWidget();
        }
        
        if (controller.errorMessage.isNotEmpty) {
          return ErrorDisplayWidget(
            message: controller.errorMessage,
            onRetry: () => controller.loadPlaylists(),
          );
        }
        
        if (controller.playlists.isEmpty) {
          return const EmptyWidget(message: 'No playlists found');
        }
        
        return ListView.builder(
          itemCount: controller.playlists.length,
          itemBuilder: (context, index) {
            final playlist = controller.playlists[index];
            return ListTile(
              title: Text(playlist.name),
              subtitle: playlist.description != null
                  ? Text(playlist.description!)
                  : null,
            );
          },
        );
      }),
    );
  }
}
```

### Step 10: Add Route

```dart
// lib/presentation/routes/app_routes.dart
abstract class Routes {
  // ... existing routes
  static const playlists = '/playlists';
}

// lib/presentation/routes/app_pages.dart
static final routes = [
  // ... existing routes
  GetPage(
    name: Routes.playlists,
    page: () => const PlaylistView(),
    binding: PlaylistBinding(),
  ),
];
```

## 🎯 Key Points

1. **Always follow the layer order**: Domain → Data → Presentation
2. **Domain layer has no dependencies** on Flutter or external packages
3. **Use GetX bindings** for dependency injection
4. **Controllers manage state** using `.obs` observables
5. **Views use `Obx()`** for reactive updates
6. **Handle loading, error, and empty states** in views

## 📚 Documentation

- [ARCHITECTURE.md](ARCHITECTURE.md) - Detailed architecture explanation
- [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) - Complete directory structure
- [GETX_GUIDE.md](GETX_GUIDE.md) - GetX best practices and patterns

## 🐛 Troubleshooting

### Issue: Environment variables not loading

**Solution**: Make sure you're running with the correct environment flag:
```bash
flutter run --dart-define=ENV=dev
```

### Issue: Get.find() throws error

**Solution**: Make sure the dependency is initialized in a binding or with `Get.put()` before using `Get.find()`.

### Issue: Controller not updating UI

**Solution**: Make sure you're using `Obx()` or `GetBuilder()` in your view, and the controller variables are `.obs`.

## ✅ Checklist for New Features

- [ ] Domain entity created
- [ ] Repository interface created
- [ ] Use case(s) created
- [ ] Data model created
- [ ] Data source(s) created
- [ ] Repository implementation created
- [ ] Controller created
- [ ] Binding created
- [ ] View created
- [ ] Route added
- [ ] Error handling implemented
- [ ] Loading states handled
- [ ] Empty states handled

