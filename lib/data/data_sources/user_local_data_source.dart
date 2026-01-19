import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../../core/utils/logger.dart';
import '../models/user_model.dart';
import 'package:get_storage/get_storage.dart';

/// Local data source for user data
abstract class UserLocalDataSource {
  Future<UserModel?> getCachedUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearCache();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final GetStorage storage;
  
  UserLocalDataSourceImpl({required this.storage});
  
  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userJson = storage.read<Map<String, dynamic>>(AppConstants.userKey);
      if (userJson == null) return null;
      return UserModel.fromJson(userJson);
    } catch (e) {
      AppLogger.e('Error reading cached user: $e');
      throw CacheException('Failed to read cached user data');
    }
  }
  
  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await storage.write(AppConstants.userKey, user.toJson());
    } catch (e) {
      AppLogger.e('Error caching user: $e');
      throw CacheException('Failed to cache user data');
    }
  }
  
  @override
  Future<void> clearCache() async {
    try {
      await storage.remove(AppConstants.userKey);
    } catch (e) {
      AppLogger.e('Error clearing cache: $e');
      throw CacheException('Failed to clear cache');
    }
  }
}

