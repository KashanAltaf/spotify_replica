# Spotify Replica

A Flutter application built with GetX following Clean Architecture principles.

## 🏗️ Architecture

This project follows **Clean Architecture** with **GetX** as the primary solution for:
- State Management
- Navigation
- Dependency Injection

### Architecture Layers

1. **Core Layer**: Shared functionality (config, constants, theme, utils, errors, network, widgets)
2. **Domain Layer**: Business logic (entities, repositories interfaces, use cases)
3. **Data Layer**: External data handling (models, data sources, repository implementations, services)
4. **Presentation Layer**: UI (controllers, bindings, routes, views, widgets)

## 📁 Project Structure

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for the complete directory tree and folder explanations.

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed architecture documentation.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (stable channel)
- Dart SDK (null-safety enabled)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd spotify_replica
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   - Copy `env.template` to create `.env.dev`, `.env.staging`, and `.env.prod`
   - Update the values in each file with your API configuration

4. **Run the app**
   ```bash
   # Development
   flutter run --dart-define=ENV=dev
   
   # Staging
   flutter run --dart-define=ENV=staging
   
   # Production
   flutter run --dart-define=ENV=prod
   ```

## 📦 Dependencies

### Core Dependencies
- **get**: ^4.6.6 - State management, navigation, and dependency injection
- **http**: ^1.2.0 - HTTP client for REST API
- **get_storage**: ^2.1.1 - Local storage
- **flutter_dotenv**: ^5.1.0 - Environment configuration
- **logger**: ^2.0.2+1 - Logging utility
- **intl**: ^0.19.0 - Date formatting

## 🎯 Features

- ✅ Clean Architecture implementation
- ✅ GetX state management
- ✅ GetX navigation
- ✅ GetX dependency injection
- ✅ Environment-based configuration (dev/staging/prod)
- ✅ REST API integration
- ✅ Local storage/caching
- ✅ Error handling
- ✅ Loading states
- ✅ Reusable widgets
- ✅ Theme support (light/dark)

## 📝 Naming Conventions

- **Models**: `{entity}_model.dart`
- **Entities**: `{entity}_entity.dart`
- **Controllers**: `{feature}_controller.dart`
- **Bindings**: `{feature}_binding.dart`
- **Views**: `{feature}_view.dart`
- **Use Cases**: `{action}_{entity}_usecase.dart`

## 🔧 Configuration

### Environment Setup

Create environment files from the template:
- `.env.dev` - Development environment
- `.env.staging` - Staging environment
- `.env.prod` - Production environment

Each file should contain:
```env
ENVIRONMENT=dev
APP_NAME=Spotify Replica
API_BASE_URL=https://api.example.com
API_KEY=your_api_key_here
CONNECT_TIMEOUT=30000
RECEIVE_TIMEOUT=30000
```

## 📚 Documentation

- [ARCHITECTURE.md](ARCHITECTURE.md) - Detailed architecture documentation
- [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) - Complete directory structure

## 🤝 Contributing

1. Follow the existing architecture patterns
2. Maintain clean code principles
3. Write meaningful commit messages
4. Test your changes

## 📄 License

[Your License Here]

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
