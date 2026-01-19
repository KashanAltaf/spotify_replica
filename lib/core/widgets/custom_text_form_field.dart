import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFieldSubmitted;
  final String? Function(String?)? onChanged;
  final int? maxLength;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final String? labelText;
  const CustomTextFormField({
    super.key,
    required this.label,
    this.hint,
    this.borderColor,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.labelText,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.prefixIcon,
    this.onTap,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.label,
          style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: AppColors.colorWhite
          ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, right: 16, bottom: 12, left: 16),
          child: TextFormField(
            onTap: widget.onTap,
            maxLength: widget.maxLength,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            obscureText: widget.obscureText,
            obscuringCharacter: '*',
            style: TextStyle(
              color: AppColors.colorWhite,
              fontStyle: FontStyle.normal,

            ),
            decoration: InputDecoration(
              counter: Offstage(),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              hintText: widget.hint,
              labelStyle: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: AppColors.colorWhite,
              ),
              hintStyle: TextStyle(
                color: Color(0xff94A3B8),
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: AppColors.grayBgSecondary,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.grayBgSecondary, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primary, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
