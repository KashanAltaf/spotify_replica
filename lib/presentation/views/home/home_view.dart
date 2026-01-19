import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../routes/app_routes.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/error_widget.dart' as error_widget;
import '../../../data/services/auth_service.dart';

/// Home view
class HomeView extends StatelessWidget {
  const HomeView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final authService = Get.find<AuthService>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Get.toNamed(Routes.profile);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
              Get.offAllNamed(Routes.login);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading) {
          return const LoadingWidget();
        }
        
        if (userController.errorMessage.isNotEmpty) {
          return error_widget.ErrorDisplayWidget(
            message: userController.errorMessage,
            onRetry: () => userController.loadUserProfile(),
          );
        }
        
        final user = userController.user;
        if (user == null) {
          return const Center(child: Text('No user data'));
        }
        
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, ${user.name}!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      }),
    );
  }
}

