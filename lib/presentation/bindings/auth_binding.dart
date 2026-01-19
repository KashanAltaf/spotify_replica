import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../data/services/auth_service.dart';
import '../controllers/auth_controller.dart';

/// Authentication binding
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize dependencies
    final apiClient = Get.put(ApiClient());
    final authService = Get.put(
      AuthService(
        apiClient: apiClient,
        storage: Get.find(),
      ),
    );
    
    // Initialize controller
    Get.lazyPut<AuthController>(
      () => AuthController(authService: authService),
    );
  }
}

