import 'package:get/get.dart';
import '../views/splash/splash_view.dart';
import '../views/auth/landing_page.dart';
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
    
    // Landing
    GetPage(
      name: Routes.landing,
      page: () => const LandingPage(),
    ),
    
    // Auth
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterView(),
    ),
    
    // Home
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
    ),
    
    // Profile
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
    ),
  ];
}

