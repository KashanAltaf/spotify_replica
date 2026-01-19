import 'package:get/get.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/update_user_profile_usecase.dart';

/// User controller
class UserController extends GetxController {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  
  UserController({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
  });
  
  // Observable state
  final _isLoading = false.obs;
  final _user = Rxn<UserEntity>();
  final _errorMessage = ''.obs;
  
  bool get isLoading => _isLoading.value;
  UserEntity? get user => _user.value;
  String get errorMessage => _errorMessage.value;
  
  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }
  
  /// Load user profile
  Future<void> loadUserProfile() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final user = await getUserProfileUseCase();
      _user.value = user;
      
      AppLogger.i('User profile loaded');
    } on ServerFailure catch (e) {
      _errorMessage.value = e.message;
      AppLogger.e('Failed to load user profile: ${e.message}');
    } on NetworkFailure catch (e) {
      _errorMessage.value = e.message;
      AppLogger.e('Network error: ${e.message}');
    } catch (e) {
      _errorMessage.value = 'An unexpected error occurred';
      AppLogger.e('Unexpected error: $e');
    } finally {
      _isLoading.value = false;
    }
  }
  
  /// Update user profile
  Future<bool> updateProfile(UserEntity user) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final updatedUser = await updateUserProfileUseCase(user);
      _user.value = updatedUser;
      
      AppLogger.i('User profile updated');
      return true;
    } on ServerFailure catch (e) {
      _errorMessage.value = e.message;
      AppLogger.e('Failed to update profile: ${e.message}');
      return false;
    } on NetworkFailure catch (e) {
      _errorMessage.value = e.message;
      AppLogger.e('Network error: ${e.message}');
      return false;
    } catch (e) {
      _errorMessage.value = 'An unexpected error occurred';
      AppLogger.e('Unexpected error: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }
  
  /// Clear error message
  void clearError() {
    _errorMessage.value = '';
  }
}

