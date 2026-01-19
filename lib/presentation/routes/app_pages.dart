import 'package:get/get.dart';
import '../bindings/auth_binding.dart';
import '../bindings/user_binding.dart';
import '../views/splash/splash_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/home/home_view.dart';
import '../views/profile/profile_view.dart';
import 'app_routes.dart';

/// Application routes configuration
class AppPages {
  static const initial = Routes.splash;
  
  static final routes = [
    // Splash
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
    ),
    
    // Auth
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    
    // Home
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      bindings: [
        UserBinding(),
      ],
    ),
    
    // Profile
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: UserBinding(),
    ),
  ];
}

