import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../routes/app_routes.dart';

class CreateAccountController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final genderController = TextEditingController();
  final nameController = TextEditingController();

  final isEmailFilled = false.obs;
  final isPassFilled = false.obs;
  final isGenderFilled = false.obs;
  final isNameFilled = false.obs;

  final RxBool firstChecked = false.obs;
  final RxBool secondChecked = false.obs;


  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() {
      isEmailFilled.value = emailController.text.trim().isNotEmpty;
    });
    passController.addListener(() {
      isPassFilled.value = passController.text.isNotEmpty;
    });
    genderController.addListener(() {
      isGenderFilled.value = genderController.text.isNotEmpty;
    });
    nameController.addListener(() {
      isNameFilled.value = nameController.text.isNotEmpty;
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    genderController.dispose();
    nameController.dispose();
    super.onClose();
  }

  void goNext() {
    if (!isEmailFilled.value) return;
    Get.toNamed(Routes.createAccount2);
    emailController.clear();
  }

  void goNext2() {
    if (!isPassFilled.value) return;
    Get.toNamed(Routes.createAccount3);
    passController.clear();
  }

  void goNext3() {
    if (!isGenderFilled.value) return;
    Get.toNamed(Routes.createAccount4);
    genderController.clear();
  }
}
