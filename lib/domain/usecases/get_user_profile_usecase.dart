import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for getting user profile
class GetUserProfileUseCase {
  final UserRepository repository;
  
  GetUserProfileUseCase(this.repository);
  
  Future<UserEntity> call() async {
    return await repository.getUserProfile();
  }
}

