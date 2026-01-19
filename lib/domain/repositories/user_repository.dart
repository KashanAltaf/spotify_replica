import '../entities/user_entity.dart';

/// User repository interface (domain layer)
abstract class UserRepository {
  Future<UserEntity> getUserProfile();
  Future<UserEntity> updateUserProfile(UserEntity user);
}

