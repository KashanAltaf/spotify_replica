# Flutter GetX Clean Architecture

This document explains the folder structure and architecture of the Flutter application using GetX for state management, navigation, and dependency injection.

## 📁 Project Structure

```
lib/
├── core/                          # Core functionality shared across the app
│   ├── config/                    # Configuration files
│   │   ├── app_config.dart        # App configuration from environment
│   │   └── env_config.dart        # Environment configuration helper
│   ├── constants/                 # Application constants
│   │   ├── app_constants.dart     # General constants
│   │   └── api_endpoints.dart     # API endpoint constants
│   ├── theme/                     # Theme configuration
│   │   └── app_theme.dart         # Light/dark theme setup
│   ├── utils/                     # Utility functions
│   │   ├── logger.dart            # Logging utility
│   │   ├── validators.dart        # Input validation
│   │   ├── date_formatter.dart    # Date formatting utilities
│   │   └── extensions.dart        # Extension methods
│   ├── errors/                    # Error handling
│   │   ├── failures.dart          # Failure classes (domain layer)
│   │   └── exceptions.dart        # Exception classes (data layer)
│   ├── network/                   # Network layer
│   │   └── api_client.dart        # HTTP client wrapper
│   └── widgets/                   # Reusable widgets
│       ├── loading_widget.dart    # Loading indicator
│       ├── error_widget.dart      # Error display widget
│       └── empty_widget.dart      # Empty state widget
│
├── data/                          # Data layer (external data sources)
│   ├── models/                    # Data models (JSON serialization)
│   │   ├── base_model.dart        # Base model interface
│   │   └── user_model.dart        # User model example
│   ├── data_sources/              # Data sources (remote & local)
│   │   ├── user_remote_data_source.dart    # API data source
│   │   └── user_local_data_source.dart     # Local storage data source
│   ├── repositories/              # Repository implementations
│   │   └── user_repository_impl.dart       # User repository implementation
│   └── services/                  # Business services
│       └── auth_service.dart      # Authentication service
│
├── domain/                        # Domain layer (business logic)
│   ├── entities/                  # Domain entities (pure Dart classes)
│   │   └── user_entity.dart       # User entity
│   ├── repositories/              # Repository interfaces
│   │   └── user_repository.dart   # User repository interface
│   └── usecases/                 # Use cases (business logic)
│       ├── get_user_profile_usecase.dart
│       └── update_user_profile_usecase.dart
│
├── presentation/                  # Presentation layer (UI)
│   ├── controllers/              # GetX controllers
│   │   ├── auth_controller.dart  # Authentication controller
│   │   └── user_controller.dart  # User controller
│   ├── bindings/                 # GetX bindings (dependency injection)
│   │   ├── auth_binding.dart     # Auth dependencies
│   │   └── user_binding.dart     # User dependencies
│   ├── routes/                   # Navigation routes
│   │   ├── app_routes.dart       # Route name constants
│   │   └── app_pages.dart        # Route configuration
│   ├── views/                    # UI screens
│   │   ├── splash/
│   │   │   └── splash_view.dart
│   │   ├── auth/
│   │   │   ├── login_view.dart
│   │   │   └── register_view.dart
│   │   ├── home/
│   │   │   └── home_view.dart
│   │   └── profile/
│   │       └── profile_view.dart
│   └── widgets/                  # Feature-specific widgets
│       └── (feature widgets go here)
│
└── main.dart                     # Application entry point
```

## 🏗️ Architecture Layers

### 1. **Core Layer**
Contains shared functionality used across the entire application:
- **Config**: Environment-based configuration
- **Constants**: App-wide constants and API endpoints
- **Theme**: Centralized theming
- **Utils**: Reusable utilities (logging, validation, formatting)
- **Errors**: Error handling classes
- **Network**: HTTP client setup
- **Widgets**: Common reusable widgets

### 2. **Domain Layer** (Business Logic)
Pure Dart code with no dependencies on Flutter or external packages:
- **Entities**: Business objects (pure Dart classes)
- **Repositories**: Repository interfaces (contracts)
- **Use Cases**: Single-purpose business logic operations

### 3. **Data Layer** (External Data)
Handles data from external sources:
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Remote (API) and local (storage) data sources
- **Repositories**: Implementation of domain repository interfaces
- **Services**: Business services (e.g., authentication)

### 4. **Presentation Layer** (UI)
GetX-based UI layer:
- **Controllers**: State management using GetX controllers
- **Bindings**: Dependency injection setup
- **Routes**: Navigation configuration
- **Views**: UI screens
- **Widgets**: Feature-specific widgets

## 📝 Naming Conventions

### Files
- **Models**: `{entity}_model.dart` (e.g., `user_model.dart`)
- **Entities**: `{entity}_entity.dart` (e.g., `user_entity.dart`)
- **Controllers**: `{feature}_controller.dart` (e.g., `auth_controller.dart`)
- **Bindings**: `{feature}_binding.dart` (e.g., `auth_binding.dart`)
- **Views**: `{feature}_view.dart` (e.g., `login_view.dart`)
- **Use Cases**: `{action}_{entity}_usecase.dart` (e.g., `get_user_profile_usecase.dart`)
- **Data Sources**: `{entity}_{source}_data_source.dart` (e.g., `user_remote_data_source.dart`)
- **Repositories**: `{entity}_repository.dart` (interface) / `{entity}_repository_impl.dart` (implementation)

### Classes
- **Models**: `{Entity}Model` (e.g., `UserModel`)
- **Entities**: `{Entity}Entity` (e.g., `UserEntity`)
- **Controllers**: `{Feature}Controller` (e.g., `AuthController`)
- **Bindings**: `{Feature}Binding` (e.g., `AuthBinding`)
- **Views**: `{Feature}View` (e.g., `LoginView`)
- **Use Cases**: `{Action}{Entity}UseCase` (e.g., `GetUserProfileUseCase`)
- **Data Sources**: `{Entity}{Source}DataSource` (e.g., `UserRemoteDataSource`)
- **Repositories**: `{Entity}Repository` (interface) / `{Entity}RepositoryImpl` (implementation)

## 🔄 Data Flow

1. **User Action** → View triggers controller method
2. **Controller** → Calls use case
3. **Use Case** → Calls repository interface
4. **Repository Implementation** → Calls data source(s)
5. **Data Source** → Fetches from API/storage
6. **Response** → Flows back through layers (Model → Entity)
7. **Controller** → Updates observable state
8. **View** → Rebuilds via `Obx()` or `GetBuilder()`

## 🎯 GetX Best Practices

### Controllers
- Extend `GetxController`
- Use `.obs` for reactive variables
- Use `Get.find<Controller>()` to access in views
- Override `onInit()`, `onReady()`, `onClose()` for lifecycle

### Bindings
- Extend `Bindings`
- Implement `dependencies()` method
- Use `Get.put()` for singleton dependencies
- Use `Get.lazyPut()` for lazy initialization
- Register in `AppPages.routes`

### Navigation
- Use `Get.toNamed(Routes.routeName)` for navigation
- Use `Get.offNamed()` to replace current route
- Use `Get.offAllNamed()` to clear stack
- Define routes in `app_routes.dart`
- Configure in `app_pages.dart`

### State Management
- Use `Obx()` for reactive widgets
- Use `GetBuilder()` for manual updates
- Use `.obs` for observable variables
- Use `Rx<Type>` for typed observables

## 🔧 Environment Configuration

### Setup
1. Create `.env.dev`, `.env.staging`, `.env.prod` files in project root
2. Build with: `flutter run --dart-define=ENV=dev`
3. Access via: `AppConfig.apiBaseUrl`

### Environment Files
- `.env.dev` - Development environment
- `.env.staging` - Staging environment
- `.env.prod` - Production environment

## 📦 Dependencies

### Core Dependencies
- `get: ^4.6.6` - GetX (state management, navigation, DI)
- `http: ^1.2.0` - HTTP client
- `get_storage: ^2.1.1` - Local storage
- `flutter_dotenv: ^5.1.0` - Environment variables
- `logger: ^2.0.2+1` - Logging
- `intl: ^0.19.0` - Date formatting

## 🚀 Getting Started

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Initialize GetStorage:**
   Already handled in `main.dart`

3. **Set up environment:**
   - Copy `.env.dev` and update with your API URLs
   - Run: `flutter run --dart-define=ENV=dev`

4. **Run the app:**
   ```bash
   flutter run
   ```

## 📚 Additional Resources

- [GetX Documentation](https://pub.dev/packages/get)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Best Practices](https://flutter.dev/docs/development/ui/best-practices)

