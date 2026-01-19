import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_assets.dart';

/// Reusable icon widget that supports both SVG and image assets
class AppIcon extends StatelessWidget {
  final String iconPath;
  final double? size;
  final Color? color;
  final BoxFit fit;
  
  const AppIcon({
    super.key,
    required this.iconPath,
    this.size,
    this.color,
    this.fit = BoxFit.contain,
  });
  
  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).iconTheme.color;
    final effectiveSize = size ?? 24.0;
    
    // Check if it's an SVG file
    if (iconPath.endsWith('.svg')) {
      return SvgPicture.asset(
        iconPath,
        width: effectiveSize,
        height: effectiveSize,
        colorFilter: effectiveColor != null
            ? ColorFilter.mode(effectiveColor, BlendMode.srcIn)
            : null,
        fit: fit,
      );
    }
    
    // For PNG or other image formats
    return Image.asset(
      iconPath,
      width: effectiveSize,
      height: effectiveSize,
      color: effectiveColor,
      fit: fit,
    );
  }
}

/// Icon button with app icon
class AppIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onPressed;
  final double? iconSize;
  final Color? iconColor;
  final String? tooltip;
  final EdgeInsetsGeometry? padding;
  
  const AppIconButton({
    super.key,
    required this.iconPath,
    this.onPressed,
    this.iconSize,
    this.iconColor,
    this.tooltip,
    this.padding,
  });
  
  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      onPressed: onPressed,
      icon: AppIcon(
        iconPath: iconPath,
        size: iconSize,
        color: iconColor,
      ),
      padding: padding,
      tooltip: tooltip,
    );
    
    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }
    
    return button;
  }
}

