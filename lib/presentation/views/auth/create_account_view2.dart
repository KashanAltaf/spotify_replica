import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spotify_replica/core/theme/app_colors.dart';
import 'package:spotify_replica/core/widgets/button_widget.dart';
import 'package:spotify_replica/core/widgets/custom_text_form_field.dart';
import 'package:spotify_replica/presentation/controllers/create_account_controller.dart';

class CreateAccountView2 extends StatefulWidget {
  const CreateAccountView2({super.key});

  @override
  State<CreateAccountView2> createState() => _CreateAccountView2State();
}

class _CreateAccountView2State extends State<CreateAccountView2> {

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: CustomTextFormField(
                  controller: controller.passController,
                  label: 'Create a password',
                  validator: (value){
                    if (value!.length < 8) {
                      return 'Must be at least 8 characters long';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Use atleast 8 characters',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorWhite
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Center(
                child: Obx(() => ButtonWidget(
                    title: 'Next',
                    height: 42,
                    radius: 40,
                    textColor: AppColors.colorBlack,
                    buttonColor: controller.isPassFilled.value ? AppColors.primary : Color(0xff535353),
                    borderColor: Colors.transparent,
                    width: 82,
                    onPress: (){
                      controller.goNext2();
                    }
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
