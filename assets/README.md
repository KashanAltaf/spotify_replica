# Assets Directory

This directory contains all static assets used in the application.

## 📁 Directory Structure

```
assets/
├── images/          # Image assets (PNG, JPG, WebP)
├── icons/           # Icon assets (SVG, PNG)
└── fonts/           # Custom font files (TTF, OTF)
```

## 🖼️ Images

Place all image assets in the `images/` directory.

### Supported Formats
- PNG (recommended for images with transparency)
- JPG/JPEG (recommended for photos)
- WebP (recommended for optimized images)

### Usage

```dart
import 'package:spotify_replica/core/utils/app_assets.dart';
import 'package:spotify_replica/core/widgets/app_image.dart';

// Using AppImage widget
AppImage(
  imagePath: AppAssets.logo,
  width: 200,
  height: 200,
)

// Or directly with Image.asset
Image.asset(AppAssets.logo)
```

## 🎨 Icons

Place all icon assets in the `icons/` directory.

### Supported Formats
- SVG (recommended for scalable vector icons)
- PNG (for raster icons, include @1x, @2x, @3x variants)

### Usage

```dart
import 'package:spotify_replica/core/utils/app_assets.dart';
import 'package:spotify_replica/core/widgets/app_icon.dart';

// Using AppIcon widget
AppIcon(
  iconPath: AppAssets.iconHome,
  size: 24,
  color: Colors.white,
)

// Using AppIconButton
AppIconButton(
  iconPath: AppAssets.iconSearch,
  onPressed: () {},
  tooltip: 'Search',
)
```

## 🔤 Fonts

Place all custom font files in the `fonts/` directory.

### Supported Formats
- TTF (TrueType Font)
- OTF (OpenType Font)

### Setup

1. Add font files to `assets/fonts/` directory
2. Update `pubspec.yaml` with font family definitions:

```yaml
fonts:
  - family: Circular
    fonts:
      - asset: assets/fonts/Circular/Circular-Regular.ttf
      - asset: assets/fonts/Circular/Circular-Medium.ttf
        weight: 500
      - asset: assets/fonts/Circular/Circular-Bold.ttf
        weight: 700
```

3. Use in your code:

```dart
Text(
  'Hello World',
  style: TextStyle(
    fontFamily: AppAssets.fontFamilyPrimary,
    fontWeight: FontWeight.bold,
  ),
)
```

## 📝 Adding New Assets

1. **Add the asset file** to the appropriate directory
2. **Update `app_assets.dart`** with the new asset path:

```dart
// In lib/core/utils/app_assets.dart
static const String myNewImage = '$imagesPath/my_new_image.png';
static const String myNewIcon = '$iconsPath/my_new_icon.svg';
```

3. **Use the asset** in your code:

```dart
AppImage(imagePath: AppAssets.myNewImage)
```

## 🎯 Best Practices

1. **Naming Convention**: Use snake_case for asset file names
   - ✅ `logo_dark.png`
   - ❌ `logo-dark.png` or `logoDark.png`

2. **Organization**: Group related assets in subdirectories
   ```
   images/
   ├── logos/
   ├── backgrounds/
   └── illustrations/
   ```

3. **Optimization**: 
   - Use WebP for better compression
   - Optimize images before adding to assets
   - Use SVG for icons when possible

4. **Resolution**: For raster images, provide multiple resolutions:
   - `image.png` (1x)
   - `image@2x.png` (2x)
   - `image@3x.png` (3x)

5. **SVG Icons**: Prefer SVG for icons as they scale perfectly

## 🔍 Asset Paths

All asset paths are centralized in `lib/core/utils/app_assets.dart` for easy maintenance and refactoring.

## 📚 Related Files

- `lib/core/utils/app_assets.dart` - Asset path constants
- `lib/core/widgets/app_image.dart` - Image widget with error handling
- `lib/core/widgets/app_icon.dart` - Icon widget with SVG support
- `lib/core/theme/app_colors.dart` - Color constants

