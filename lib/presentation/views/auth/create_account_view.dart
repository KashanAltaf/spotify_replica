import 'package:flutter/material.dart';
import 'package:spotify_replica/core/theme/app_colors.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorBlack,
        centerTitle: true,
        title: Text('Create Account'),
        titleTextStyle: TextStyle(
          color: AppColors.colorWhite,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppColors.colorBlack,
    );
  }
}
