import 'package:get/get.dart';
import 'package:spotify_replica/presentation/views/auth/create_account_view.dart';
import '../views/auth/create_account_view2.dart';
import '../views/auth/create_account_view3.dart';
import '../views/auth/create_account_view4.dart';
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

    //Create Account Step 1
    GetPage(
      name: Routes.createAccount,
      page: () => const CreateAccountView(),
    ),

    //Create Account Step 2
    GetPage(
      name: Routes.createAccount2,
      page: () => const CreateAccountView2(),
    ),

    GetPage(
      name: Routes.createAccount3,
      page: () => const CreateAccountView3(),
    ),

    GetPage(
      name: Routes.createAccount4,
      page: () => const CreateAccountView4(),
    ),
  ];
}

