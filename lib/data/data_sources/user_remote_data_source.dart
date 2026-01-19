import '../../core/constants/api_endpoints.dart';
import '../../core/network/api_client.dart';
import '../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Remote data source for user data
abstract class UserRemoteDataSource {
  Future<UserModel> getUserProfile();
  Future<UserModel> updateUserProfile(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;
  
  UserRemoteDataSourceImpl({required this.apiClient});
  
  @override
  Future<UserModel> getUserProfile() async {
    try {
      final response = await apiClient.get(ApiEndpoints.userProfile);
      final data = response.dataAsMap;
      if (data == null) {
        throw ServerException('Invalid response format');
      }
      return UserModel.fromJson(data);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to fetch user profile');
    }
  }
  
  @override
  Future<UserModel> updateUserProfile(UserModel user) async {
    try {
      final response = await apiClient.put(
        ApiEndpoints.updateProfile,
        data: user.toJson(),
      );
      final data = response.dataAsMap;
      if (data == null) {
        throw ServerException('Invalid response format');
      }
      return UserModel.fromJson(data);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to update user profile');
    }
  }
}

