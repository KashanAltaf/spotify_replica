import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spotify_replica/core/theme/app_colors.dart';
import 'package:spotify_replica/core/theme/app_theme.dart';
import 'package:spotify_replica/core/utils/app_assets.dart';
import 'package:spotify_replica/core/widgets/button_widget.dart';
import 'package:spotify_replica/presentation/routes/app_routes.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xff666666),
                    Colors.black,
                  ],
                stops: [
                  .10,
                  .67,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.iconLogo,
                    color: AppColors.colorWhite,
                    height: 97,
                    width: 97,
                  ),
                  SizedBox(height: 100,),
                  Text(
                    'Millions of songs',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorWhite
                    ),
                  ),
                  Text(
                    'Free on Spotify',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorWhite
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(
                title: 'Sign Up',
                radius: 40,
                onPress: (){
                  Get.offNamed(Routes.register);
                },
              textColor: AppColors.colorBlack,
            ),
            SizedBox(height: 16),
            ButtonWidget(
                title: 'Log In',
                radius: 40,
                buttonColor: Colors.transparent,
                borderColor: AppColors.grayBgSecondary,
                onPress: (){
                  Get.offNamed(Routes.login);
                }
            ),
          ],
        ),
      ),
    );
  }
}
