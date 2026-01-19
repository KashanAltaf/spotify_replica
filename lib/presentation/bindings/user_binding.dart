import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../data/data_sources/user_local_data_source.dart';
import '../../data/data_sources/user_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/update_user_profile_usecase.dart';
import '../controllers/user_controller.dart';

/// User binding
class UserBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize data sources
    final apiClient = Get.find<ApiClient>();
    final storage = Get.find();
    
    final remoteDataSource = Get.put(
      UserRemoteDataSourceImpl(apiClient: apiClient),
    );
    final localDataSource = Get.put(
      UserLocalDataSourceImpl(storage: storage),
    );
    
    // Initialize repository
    final repository = Get.put(
      UserRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
      ),
    );
    
    // Initialize use cases
    final getUserProfileUseCase = Get.put(
      GetUserProfileUseCase(repository),
    );
    final updateUserProfileUseCase = Get.put(
      UpdateUserProfileUseCase(repository),
    );
    
    // Initialize controller
    Get.lazyPut<UserController>(
      () => UserController(
        getUserProfileUseCase: getUserProfileUseCase,
        updateUserProfileUseCase: updateUserProfileUseCase,
      ),
    );
  }
}

