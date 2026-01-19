# Complete Directory Tree

```
spotify_replica/
├── lib/
│   ├── core/                                    # Core functionality
│   │   ├── config/
│   │   │   ├── app_config.dart                 # App configuration
│   │   │   └── env_config.dart                 # Environment config
│   │   ├── constants/
│   │   │   ├── app_constants.dart              # General constants
│   │   │   └── api_endpoints.dart              # API endpoints
│   │   ├── theme/
│   │   │   └── app_theme.dart                  # Theme configuration
│   │   ├── utils/
│   │   │   ├── logger.dart                     # Logging utility
│   │   │   ├── validators.dart                 # Input validation
│   │   │   ├── date_formatter.dart             # Date formatting
│   │   │   └── extensions.dart                 # Extension methods
│   │   ├── errors/
│   │   │   ├── failures.dart                   # Failure classes
│   │   │   └── exceptions.dart                 # Exception classes
│   │   ├── network/
│   │   │   └── api_client.dart                 # HTTP client
│   │   └── widgets/
│   │       ├── loading_widget.dart             # Loading widget
│   │       ├── error_widget.dart               # Error widget
│   │       └── empty_widget.dart               # Empty state widget
│   │
│   ├── data/                                    # Data layer
│   │   ├── models/
│   │   │   ├── base_model.dart                 # Base model
│   │   │   └── user_model.dart                 # User model
│   │   ├── data_sources/
│   │   │   ├── user_remote_data_source.dart    # Remote data source
│   │   │   └── user_local_data_source.dart     # Local data source
│   │   ├── repositories/
│   │   │   └── user_repository_impl.dart       # Repository impl
│   │   └── services/
│   │       └── auth_service.dart                # Auth service
│   │
│   ├── domain/                                  # Domain layer
│   │   ├── entities/
│   │   │   └── user_entity.dart                # User entity
│   │   ├── repositories/
│   │   │   └── user_repository.dart            # Repository interface
│   │   └── usecases/
│   │       ├── get_user_profile_usecase.dart   # Get user use case
│   │       └── update_user_profile_usecase.dart # Update user use case
│   │
│   ├── presentation/                            # Presentation layer
│   │   ├── controllers/
│   │   │   ├── auth_controller.dart            # Auth controller
│   │   │   └── user_controller.dart            # User controller
│   │   ├── bindings/
│   │   │   ├── auth_binding.dart               # Auth binding
│   │   │   └── user_binding.dart               # User binding
│   │   ├── routes/
│   │   │   ├── app_routes.dart                 # Route constants
│   │   │   └── app_pages.dart                 # Route config
│   │   └── views/
│   │       ├── splash/
│   │       │   └── splash_view.dart            # Splash screen
│   │       ├── auth/
│   │       │   ├── login_view.dart             # Login screen
│   │       │   └── register_view.dart          # Register screen
│   │       ├── home/
│   │       │   └── home_view.dart              # Home screen
│   │       └── profile/
│   │           └── profile_view.dart          # Profile screen
│   │
│   └── main.dart                                # App entry point
│
├── test/                                        # Tests
│   └── widget_test.dart
│
├── .env.dev                                     # Dev environment (create from template)
├── .env.staging                                 # Staging environment (create from template)
├── .env.prod                                    # Production environment (create from template)
├── env.template                                 # Environment template
├── pubspec.yaml                                 # Dependencies
├── ARCHITECTURE.md                              # Architecture documentation
├── PROJECT_STRUCTURE.md                         # This file
└── README.md                                    # Project README
```

## Folder Explanations

### `/lib/core`
**Purpose**: Shared functionality used across the entire application.

- **`config/`**: Environment-based configuration management
- **`constants/`**: Application-wide constants (API endpoints, storage keys, etc.)
- **`theme/`**: Centralized theming (light/dark mode)
- **`utils/`**: Reusable utility functions (logging, validation, formatting)
- **`errors/`**: Error handling classes (exceptions and failures)
- **`network/`**: HTTP client setup and configuration
- **`widgets/`**: Common reusable widgets (loading, error, empty states)

### `/lib/data`
**Purpose**: Handles all data operations from external sources.

- **`models/`**: Data Transfer Objects (DTOs) with JSON serialization
- **`data_sources/`**: 
  - Remote: API calls via HTTP client
  - Local: Caching and local storage operations
- **`repositories/`**: Implementation of domain repository interfaces
- **`services/`**: Business services (authentication, etc.)

### `/lib/domain`
**Purpose**: Pure business logic, independent of frameworks.

- **`entities/`**: Business objects (pure Dart classes, no dependencies)
- **`repositories/`**: Repository interfaces (contracts, not implementations)
- **`usecases/`**: Single-purpose business logic operations

### `/lib/presentation`
**Purpose**: UI layer using GetX.

- **`controllers/`**: GetX controllers for state management
- **`bindings/`**: Dependency injection setup for each feature
- **`routes/`**: Navigation configuration
- **`views/`**: UI screens organized by feature
- **`widgets/`**: Feature-specific reusable widgets

## File Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Model | `{entity}_model.dart` | `user_model.dart` |
| Entity | `{entity}_entity.dart` | `user_entity.dart` |
| Controller | `{feature}_controller.dart` | `auth_controller.dart` |
| Binding | `{feature}_binding.dart` | `auth_binding.dart` |
| View | `{feature}_view.dart` | `login_view.dart` |
| Use Case | `{action}_{entity}_usecase.dart` | `get_user_profile_usecase.dart` |
| Data Source | `{entity}_{source}_data_source.dart` | `user_remote_data_source.dart` |
| Repository | `{entity}_repository.dart` (interface)<br>`{entity}_repository_impl.dart` (impl) | `user_repository.dart`<br>`user_repository_impl.dart` |

## Best Practices

1. **Separation of Concerns**: Each layer has a clear responsibility
2. **Dependency Rule**: Dependencies point inward (presentation → domain ← data)
3. **Single Responsibility**: Each class/function has one clear purpose
4. **Reusability**: Core utilities and widgets are shared
5. **Testability**: Domain layer is easily testable (no dependencies)
6. **Scalability**: Easy to add new features following the same pattern

