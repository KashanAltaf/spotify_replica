import 'package:get/get.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/logger.dart';
import '../../data/services/auth_service.dart';

/// Authentication controller
class AuthController extends GetxController {
  final AuthService authService;
  
  AuthController({required this.authService});
  
  // Observable state
  final _isLoading = false.obs;
  final _isAuthenticated = false.obs;
  final _errorMessage = ''.obs;
  
  bool get isLoading => _isLoading.value;
  bool get isAuthenticated => _isAuthenticated.value;
  String get errorMessage => _errorMessage.value;
  
  @override
  void onInit() {
    super.onInit();
    _isAuthenticated.value = authService.isAuthenticated;
  }
  
  /// Login
  Future<bool> login(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      await authService.login(email, password);
      _isAuthenticated.value = true;
      
      AppLogger.i('Login successful');
      return true;
    } on AuthFailure catch (e) {
      _errorMessage.value = e.message;
      AppLogger.e('Login failed: ${e.message}');
      return false;
    } catch (e) {
      _errorMessage.value = 'An unexpected error occurred';
      AppLogger.e('Unexpected login error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
  
  /// Register
  Future<bool> register(String email, String password, String name) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      await authService.register(email, password, name);
      _isAuthenticated.value = true;
      
      AppLogger.i('Registration successful');
      return true;
    } on AuthFailure catch (e) {
      _errorMessage.value = e.message;
      AppLogger.e('Registration failed: ${e.message}');
      return false;
    } catch (e) {
      _errorMessage.value = 'An unexpected error occurred';
      AppLogger.e('Unexpected registration error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
  
  /// Logout
  Future<void> logout() async {
    try {
      _isLoading.value = true;
      await authService.logout();
      _isAuthenticated.value = false;
      AppLogger.i('Logout successful');
    } catch (e) {
      AppLogger.e('Logout error: $e');
    } finally {
      _isLoading.value = false;
    }
  }
  
  /// Clear error message
  void clearError() {
    _errorMessage.value = '';
  }
}

