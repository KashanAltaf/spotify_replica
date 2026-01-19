import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_replica/core/theme/app_colors.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/button_widget.dart';
import '../../routes/app_routes.dart';
import '../../../core/utils/validators.dart';

/// Register view
class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  
  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    // final nameController = TextEditingController();
    // final emailController = TextEditingController();
    // final passwordController = TextEditingController();
    // final confirmPasswordController = TextEditingController();
    //

    return Scaffold(
      backgroundColor: AppColors.colorBlack,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.colorWhite,
          ),
        ),
        backgroundColor: AppColors.colorBlack,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: Get.height * 0.2, left: 16, right: 16),
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
              SizedBox(height: 50,),
              Text(
                'Sign up to start\nlistening',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: AppColors.colorWhite
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.1),
              ButtonWidget(
                  title: 'Continue with email',
                  isIcon: true,
                  path: AppAssets.iconEmail,
                  textColor: AppColors.colorBlack,
                  radius: 40,
                  onPress: (){
                    Get.toNamed(Routes.createAccount);
                  }
              ),
              SizedBox(height: 16,),
              ButtonWidget(
                  title: 'Continue with Google',
                  isIcon: true,
                  path: AppAssets.iconGoogle,
                  textColor: AppColors.colorWhite,
                  borderColor: AppColors.grayBgSecondary,
                  buttonColor: Colors.transparent,
                  radius: 40,
                  onPress: (){
                    //Get.offNamed();
                  }
              ),
              SizedBox(height: 16,),
              ButtonWidget(
                  title: 'Continue with Facebook',
                  isIcon: true,
                  path: AppAssets.iconFacebook,
                  textColor: AppColors.colorWhite,
                  borderColor: AppColors.grayBgSecondary,
                  buttonColor: Colors.transparent,
                  radius: 40,
                  onPress: (){
                    //Get.offNamed();
                  }
              ),
              SizedBox(height: 60,),
              Text(
                'Already have an account?',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.colorWhite
                ),
              ),
              TextButton(
                onPressed: (){
                  Get.offNamed(Routes.login);
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorWhite
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

