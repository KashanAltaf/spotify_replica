import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_replica/core/theme/app_colors.dart';
import 'package:spotify_replica/core/utils/app_assets.dart';
import '../../routes/app_routes.dart';
import '../../../core/constants/app_constants.dart';

/// Splash screen view
class SplashView extends StatefulWidget {
  const SplashView({super.key});
  
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }
  
  Future<void> _navigateToNext() async {
    await Future.delayed(AppConstants.longAnimation);
    Get.offAllNamed(Routes.landing);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBgPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.iconLogo,
              height: 150,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}

