# GetX Best Practices Guide

This guide covers GetX-specific best practices used in this project.

## 📋 Table of Contents

1. [Controllers](#controllers)
2. [Bindings](#bindings)
3. [Navigation](#navigation)
4. [State Management](#state-management)
5. [Dependency Injection](#dependency-injection)
6. [Reactive Programming](#reactive-programming)

## 🎮 Controllers

### Basic Structure

```dart
class MyController extends GetxController {
  // Observable variables
  final _isLoading = false.obs;
  final _data = Rxn<MyModel>();
  final _errorMessage = ''.obs;
  
  // Getters
  bool get isLoading => _isLoading.value;
  MyModel? get data => _data.value;
  String get errorMessage => _errorMessage.value;
  
  @override
  void onInit() {
    super.onInit();
    // Initialization logic
  }
  
  @override
  void onReady() {
    super.onReady();
    // Called after widget is rendered
  }
  
  @override
  void onClose() {
    // Cleanup logic
    super.onClose();
  }
}
```

### Best Practices

✅ **DO:**
- Use private variables with `.obs` for observables
- Expose public getters for accessing values
- Use `onInit()` for initialization
- Use `onReady()` for post-render logic
- Use `onClose()` for cleanup

❌ **DON'T:**
- Don't make observable variables public
- Don't forget to call `super.onInit()`, `super.onReady()`, `super.onClose()`
- Don't perform heavy operations in `onInit()`

### Example: Loading State

```dart
Future<void> fetchData() async {
  try {
    _isLoading.value = true;
    _errorMessage.value = '';
    
    final result = await repository.getData();
    _data.value = result;
  } catch (e) {
    _errorMessage.value = e.toString();
  } finally {
    _isLoading.value = false;
  }
}
```

## 🔗 Bindings

### Basic Structure

```dart
class MyBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize dependencies in order
    final apiClient = Get.put(ApiClient());
    final repository = Get.put(
      MyRepository(apiClient: apiClient),
    );
    
    // Lazy initialization for controllers
    Get.lazyPut<MyController>(
      () => MyController(repository: repository),
    );
  }
}
```

### Best Practices

✅ **DO:**
- Initialize dependencies in the correct order
- Use `Get.put()` for singletons that are always needed
- Use `Get.lazyPut()` for controllers (loaded when first accessed)
- Register bindings in `AppPages.routes`

❌ **DON'T:**
- Don't initialize controllers with `Get.put()` in bindings (use `lazyPut`)
- Don't forget to handle dependency order

### Dependency Order Example

```dart
void dependencies() {
  // 1. Core dependencies first
  final storage = Get.find<GetStorage>(); // Already initialized in main.dart
  final apiClient = Get.put(ApiClient());
  
  // 2. Data sources
  final remoteDataSource = Get.put(
    MyRemoteDataSource(apiClient: apiClient),
  );
  final localDataSource = Get.put(
    MyLocalDataSource(storage: storage),
  );
  
  // 3. Repositories
  final repository = Get.put(
    MyRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    ),
  );
  
  // 4. Use cases
  final useCase = Get.put(MyUseCase(repository));
  
  // 5. Controllers (lazy)
  Get.lazyPut<MyController>(
    () => MyController(useCase: useCase),
  );
}
```

## 🧭 Navigation

### Route Definition

```dart
// app_routes.dart
abstract class Routes {
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';
}
```

### Route Configuration

```dart
// app_pages.dart
class AppPages {
  static const initial = Routes.home;
  
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
```

### Navigation Methods

```dart
// Navigate to a new route
Get.toNamed(Routes.profile);

// Navigate and remove current route
Get.offNamed(Routes.profile);

// Navigate and remove all previous routes
Get.offAllNamed(Routes.home);

// Navigate with arguments
Get.toNamed(Routes.profile, arguments: {'userId': 123});

// Navigate with parameters
Get.toNamed('/profile/123');

// Go back
Get.back();

// Go back with result
Get.back(result: 'some data');
```

### Receiving Arguments/Parameters

```dart
// In the destination view
final arguments = Get.arguments; // Map or any type
final parameters = Get.parameters; // Route parameters

// Example with route: /profile/:userId
final userId = Get.parameters['userId'];
```

## 📊 State Management

### Using Obx (Reactive)

```dart
// In view
Obx(() => Text(controller.data?.name ?? 'No data'));

// Automatically rebuilds when any observable changes
```

### Using GetBuilder (Manual)

```dart
// In controller
void updateData() {
  // Update data
  update(); // Triggers rebuild
}

// In view
GetBuilder<MyController>(
  builder: (controller) => Text(controller.data?.name ?? 'No data'),
);
```

### When to Use What

- **Obx**: Use for simple reactive updates (recommended)
- **GetBuilder**: Use when you need more control or performance optimization

### Observable Types

```dart
// Simple observable
final count = 0.obs;
final name = ''.obs;
final isActive = false.obs;

// Nullable observable
final user = Rxn<User>();
final data = Rx<MyModel?>(null);

// List observable
final items = <String>[].obs;
final users = RxList<User>();

// Map observable
final data = <String, dynamic>{}.obs;
```

## 💉 Dependency Injection

### Get.put() - Singleton

```dart
// Creates and keeps the instance
final controller = Get.put(MyController());

// Access later
final controller = Get.find<MyController>();
```

### Get.lazyPut() - Lazy Singleton

```dart
// Creates instance when first accessed
Get.lazyPut(() => MyController());

// Access (creates if not exists)
final controller = Get.find<MyController>();
```

### Get.putAsync() - Async Singleton

```dart
// For async initialization
Get.putAsync<MyService>(
  () async => await MyService.init(),
);
```

### Get.create() - Factory

```dart
// Creates new instance every time
Get.create(() => MyController());
```

### Removing Dependencies

```dart
// Remove specific dependency
Get.delete<MyController>();

// Remove all dependencies
Get.reset();
```

## ⚡ Reactive Programming

### Working with Rx Variables

```dart
// Update value
count.value = 10;
count(10); // Shorthand

// Listen to changes
ever(count, (value) => print('Count changed: $value'));

// Listen once
once(count, (value) => print('Count is: $value'));

// Debounce (wait for pause)
debounce(searchText, (value) => performSearch(value), time: Duration(seconds: 1));

// Interval (periodic updates)
interval(count, (value) => print('Count: $value'), time: Duration(seconds: 1));

// Worker (auto-dispose)
Worker worker = ever(count, (value) => print(value));
worker.dispose(); // Clean up
```

### Computed Values

```dart
final count = 0.obs;
final doubleCount = count * 2; // Automatically updates

// Or use getter
int get doubleCount => count.value * 2;
```

## 🎯 Common Patterns

### Loading State Pattern

```dart
class MyController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  
  Future<void> loadData() async {
    _isLoading.value = true;
    try {
      // Load data
    } finally {
      _isLoading.value = false;
    }
  }
}
```

### Error Handling Pattern

```dart
class MyController extends GetxController {
  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;
  
  void clearError() => _errorMessage.value = '';
  
  Future<void> performAction() async {
    try {
      _errorMessage.value = '';
      // Action
    } catch (e) {
      _errorMessage.value = e.toString();
    }
  }
}
```

### Data Fetching Pattern

```dart
class MyController extends GetxController {
  final _data = Rxn<MyModel>();
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  
  MyModel? get data => _data.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  
  @override
  void onInit() {
    super.onInit();
    loadData();
  }
  
  Future<void> loadData() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      _data.value = await repository.getData();
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
```

## 📚 Additional Resources

- [GetX Official Documentation](https://pub.dev/packages/get)
- [GetX GitHub](https://github.com/jonataslaw/getx)
- [GetX Examples](https://github.com/jonataslaw/getx/tree/master/example)

