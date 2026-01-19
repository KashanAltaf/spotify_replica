/// API endpoint constants
class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // User endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';
  
  // Example endpoints (replace with your actual endpoints)
  static const String tracks = '/tracks';
  static const String albums = '/albums';
  static const String artists = '/artists';
  static const String playlists = '/playlists';
  
  // Private constructor to prevent instantiation
  ApiEndpoints._();
}

