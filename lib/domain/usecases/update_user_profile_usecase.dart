import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for updating user profile
class UpdateUserProfileUseCase {
  final UserRepository repository;
  
  UpdateUserProfileUseCase(this.repository);
  
  Future<UserEntity> call(UserEntity user) async {
    return await repository.updateUserProfile(user);
  }
}

