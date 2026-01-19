import '../../core/constants/api_endpoints.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/logger.dart';
import 'package:get_storage/get_storage.dart';

/// Authentication service
class AuthService {
  final ApiClient apiClient;
  final GetStorage storage;
  
  AuthService({
    required this.apiClient,
    required this.storage,
  });
  
  /// Login user
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      
      final data = response.dataAsMap;
      if (data == null) {
        throw AuthException('Invalid response format');
      }
      final token = data['token'] as String?;
      
      if (token != null) {
        await storage.write(AppConstants.tokenKey, token);
        AppLogger.i('User logged in successfully');
      }
      
      return data;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw AuthException('Login failed');
    }
  }
  
  /// Register user
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.register,
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );
      
      final data = response.dataAsMap;
      if (data == null) {
        throw AuthException('Invalid response format');
      }
      final token = data['token'] as String?;
      
      if (token != null) {
        await storage.write(AppConstants.tokenKey, token);
        AppLogger.i('User registered successfully');
      }
      
      return data;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw AuthException('Registration failed');
    }
  }
  
  /// Logout user
  Future<void> logout() async {
    try {
      await apiClient.post(ApiEndpoints.logout);
      await storage.remove(AppConstants.tokenKey);
      AppLogger.i('User logged out successfully');
    } catch (e) {
      AppLogger.w('Logout error: $e');
      // Clear local storage even if API call fails
      await storage.remove(AppConstants.tokenKey);
    }
  }
  
  /// Check if user is authenticated
  bool get isAuthenticated {
    final token = storage.read<String>(AppConstants.tokenKey);
    return token != null && token.isNotEmpty;
  }
  
  /// Get auth token
  String? get token => storage.read<String>(AppConstants.tokenKey);
}

