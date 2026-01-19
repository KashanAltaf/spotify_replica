/// Environment configuration enum
enum Environment {
  dev,
  staging,
  prod,
}

/// Environment configuration helper
class EnvConfig {
  static Environment get currentEnvironment {
    const env = String.fromEnvironment('ENV', defaultValue: 'dev');
    switch (env) {
      case 'staging':
        return Environment.staging;
      case 'prod':
        return Environment.prod;
      default:
        return Environment.dev;
    }
  }
  
  static String get envFileName {
    switch (currentEnvironment) {
      case Environment.staging:
        return '.env.staging';
      case Environment.prod:
        return '.env.prod';
      default:
        return '.env.dev';
    }
  }
}

