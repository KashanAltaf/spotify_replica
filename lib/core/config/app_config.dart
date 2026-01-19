import 'package:flutter_dotenv/flutter_dotenv.dart';

/// App configuration based on environment
class AppConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'dev';
  
  static bool get isDevelopment => environment == 'dev';
  static bool get isStaging => environment == 'staging';
  static bool get isProduction => environment == 'prod';
  
  static String get appName => dotenv.env['APP_NAME'] ?? 'Spotify Replica';
  static int get connectTimeout => int.tryParse(dotenv.env['CONNECT_TIMEOUT'] ?? '30000') ?? 30000;
  static int get receiveTimeout => int.tryParse(dotenv.env['RECEIVE_TIMEOUT'] ?? '30000') ?? 30000;
}

