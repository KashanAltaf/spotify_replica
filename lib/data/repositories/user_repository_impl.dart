import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../data_sources/user_remote_data_source.dart';
import '../data_sources/user_local_data_source.dart';

/// User repository implementation
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<UserEntity> getUserProfile() async {
    try {
      // Try to get from cache first
      try {
        final cachedUser = await localDataSource.getCachedUser();
        if (cachedUser != null) {
          AppLogger.d('User profile loaded from cache');
          return cachedUser;
        }
      } catch (e) {
        AppLogger.w('Cache miss: $e');
      }
      
      // Fetch from remote
      final user = await remoteDataSource.getUserProfile();
      
      // Cache the result
      await localDataSource.cacheUser(user);
      
      return user;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      AppLogger.e('Unexpected error in getUserProfile: $e');
      throw UnknownFailure('An unexpected error occurred');
    }
  }
  
  @override
  Future<UserEntity> updateUserProfile(UserEntity user) async {
    try {
      final updatedUser = await remoteDataSource.updateUserProfile(
        UserModel.fromEntity(user),
      );
      
      // Update cache
      await localDataSource.cacheUser(updatedUser);
      
      return updatedUser;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      AppLogger.e('Unexpected error in updateUserProfile: $e');
      throw UnknownFailure('An unexpected error occurred');
    }
  }
}

