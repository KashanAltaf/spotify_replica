import 'package:flutter_dotenv/flutter_dotenv.dart';

/// App configuration based on environment
class AppConfig {
  /// Safely get environment variable with fallback
  static String _getEnv(String key, String defaultValue) {
    try {
      // Try to access dotenv.env - will throw NotInitializedError if not loaded
      return dotenv.env[key] ?? defaultValue;
    } catch (e) {
      // If dotenv is not initialized or any error occurs, return default value
      return defaultValue;
    }
  }
  
  static String get apiBaseUrl => _getEnv('API_BASE_URL', 'https://api.example.com');
  static String get apiKey => _getEnv('API_KEY', '');
  static String get environment => _getEnv('ENVIRONMENT', 'dev');
  
  static bool get isDevelopment => environment == 'dev';
  static bool get isStaging => environment == 'staging';
  static bool get isProduction => environment == 'prod';
  
  static String get appName => _getEnv('APP_NAME', 'Spotify Replica');
  static int get connectTimeout {
    final value = _getEnv('CONNECT_TIMEOUT', '30000');
    return int.tryParse(value) ?? 30000;
  }
  
  static int get receiveTimeout {
    final value = _getEnv('RECEIVE_TIMEOUT', '30000');
    return int.tryParse(value) ?? 30000;
  }
}

