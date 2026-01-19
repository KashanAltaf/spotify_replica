import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/env_config.dart';
import 'core/theme/app_theme.dart';
import 'presentation/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage
  await GetStorage.init();
  
  // Load environment variables
  try {
    await dotenv.load(fileName: EnvConfig.envFileName);
    debugPrint('✓ Environment variables loaded from ${EnvConfig.envFileName}');
  } catch (e) {
    // If env file doesn't exist, continue with defaults
    debugPrint('⚠ Warning: Could not load .env file (${EnvConfig.envFileName}): $e');
    debugPrint('⚠ Using default configuration values');
  }
  
  // Initialize GetStorage instance
  Get.put(GetStorage());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spotify Replica',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.getThemeMode(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
