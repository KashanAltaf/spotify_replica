import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spotify_replica/core/theme/app_colors.dart';
import 'package:spotify_replica/core/widgets/button_widget.dart';
import 'package:spotify_replica/core/widgets/custom_text_form_field.dart';
import 'package:spotify_replica/presentation/controllers/create_account_controller.dart';

import '../../routes/app_routes.dart';

class CreateAccountView4 extends StatefulWidget {
  const CreateAccountView4({super.key});

  @override
  State<CreateAccountView4> createState() => _CreateAccountView4State();
}

class _CreateAccountView4State extends State<CreateAccountView4> {

  final formKey = GlobalKey<FormState>();
  final controller = Get.put(CreateAccountController());


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.colorBlack,
          centerTitle: true,
          title: Text('Create Account'),
          titleTextStyle: TextStyle(
            color: AppColors.colorWhite,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.colorWhite,
            ),
          ),
        ),
        backgroundColor: AppColors.colorBlack,
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: formKey,
                    child: CustomTextFormField(
                      controller: controller.nameController,
                      label: 'What\'s your name?',
                      validator: (value){
                        if(value.toString().isEmpty){
                          return 'Name cannot be empty';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'This appears on your spotify profile',
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorWhite
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Color(0xff777777),
                      thickness: 1,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'By tapping on “Create account”, you agree to the spotify Terms of Use.',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorWhite
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terms of Use',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          'To learn more about how Spotify collect, uses, shares and protects your personal data, Please see the Spotify Privacy Policy.',
                          style: TextStyle(
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Please send me the news and offers from Spotify.',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.colorWhite,
                              ),
                            ),
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                value: controller.firstChecked.value,
                                shape: CircleBorder(),
                                activeColor: AppColors.primary,
                                side: BorderSide(color: Color(0xff727272)),
                                checkColor: AppColors.colorBlack,
                                onChanged: (value){
                                  controller.firstChecked.value = value ?? false;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Share my registration data with Spotify\'s content providers for marketing purposes',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.colorWhite,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                value: controller.secondChecked.value,
                                shape: CircleBorder(),
                                activeColor: AppColors.primary,
                                checkColor: AppColors.colorBlack,
                                side: BorderSide(color: Color(0xff727272)),
                                onChanged: (value){
                                  controller.secondChecked.value = value ?? false;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Center(
                  child: ButtonWidget(
                    title: 'Create an account',
                    height: 42,
                    width: 180,
                    radius: 21,
                    buttonColor: AppColors.colorWhite,
                    textColor: AppColors.colorBlack,
                    borderColor: Colors.transparent,
                    onPress: (){},
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
