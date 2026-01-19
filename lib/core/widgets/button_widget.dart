import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

const Color primaryColor = Color(0xff5E3296);

class ButtonWidget extends StatefulWidget {
  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color textColor, buttonColor, borderColor;
  final double radius;
  final double fontSize;
  final FontWeight fontweight;

  const ButtonWidget({
    super.key,
    this.buttonColor = AppColors.primary,
    this.textColor = Colors.white,
    required this.title,
    required this.onPress,
    this.width = double.infinity,
    this.height = 51,
    this.radius = 10,
    this.loading = false,
    this.borderColor = AppColors.primary,
    this.fontSize = 16,
    this.fontweight = FontWeight.w500,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(color: widget.borderColor),
        ),
        child: widget.loading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Center(
          child: Text(
            widget.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(
                color: widget.textColor,
                fontWeight: widget.fontweight,
                fontSize: widget.fontSize
            ),
          ),
        ),
      ),
    );
  }
}
