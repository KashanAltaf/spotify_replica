import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spotify_replica/core/theme/app_colors.dart';
import 'package:spotify_replica/core/widgets/button_widget.dart';
import 'package:spotify_replica/core/widgets/custom_text_form_field.dart';
import 'package:spotify_replica/presentation/controllers/create_account_controller.dart';

class CreateAccountView3 extends StatefulWidget {
  const CreateAccountView3({super.key});

  @override
  State<CreateAccountView3> createState() => _CreateAccountView3State();
}

class _CreateAccountView3State extends State<CreateAccountView3> {

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
                  controller: controller.genderController,
                  label: 'What\'s your gender?',
                ),
              ),
              SizedBox(height: 50,),
              Center(
                child: Obx(() => ButtonWidget(
                    title: 'Next',
                    height: 42,
                    radius: 40,
                    textColor: AppColors.colorBlack,
                    buttonColor: controller.isGenderFilled.value ? AppColors.primary : Color(0xff535353),
                    borderColor: Colors.transparent,
                    width: 82,
                    onPress: (){
                      controller.goNext3();
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
