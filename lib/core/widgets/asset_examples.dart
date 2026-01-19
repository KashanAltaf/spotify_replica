import 'package:flutter/material.dart';
import '../utils/app_assets.dart';
import 'app_image.dart';
import 'app_icon.dart';

/// Example usage of assets in the application
/// This file demonstrates how to use images, icons, and fonts
class AssetExamples extends StatelessWidget {
  const AssetExamples({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Examples
            _buildSection(
              title: 'Images',
              children: [
                // Local asset image
                AppImage(
                  imagePath: AppAssets.logo,
                  width: 200,
                  height: 200,
                  borderRadius: BorderRadius.circular(12),
                ),
                const SizedBox(height: 16),
                
                // Network image
                AppNetworkImage(
                  imageUrl: 'https://example.com/image.jpg',
                  width: 200,
                  height: 200,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Icon Examples
            _buildSection(
              title: 'Icons',
              children: [
                Row(
                  children: [
                    AppIcon(
                      iconPath: AppAssets.iconLogo,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    AppIcon(
                      iconPath: AppAssets.iconSearch,
                      size: 32,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 16),
                    AppIcon(
                      iconPath: AppAssets.iconPlay,
                      size: 32,
                      color: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Icon buttons
                Row(
                  children: [
                    AppIconButton(
                      iconPath: AppAssets.iconLogo,
                      onPressed: () {},
                      tooltip: 'Home',
                    ),
                    AppIconButton(
                      iconPath: AppAssets.iconSearch,
                      onPressed: () {},
                      tooltip: 'Search',
                    ),
                    AppIconButton(
                      iconPath: AppAssets.iconPlay,
                      onPressed: () {},
                      tooltip: 'Play',
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Font Examples
            _buildSection(
              title: 'Fonts',
              children: [
                Text(
                  'Regular Text',
                  style: TextStyle(
                    fontFamily: AppAssets.fontFamilyPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bold Text',
                  style: TextStyle(
                    fontFamily: AppAssets.fontFamilyPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Secondary Font',
                  style: TextStyle(
                    fontFamily: AppAssets.fontFamilySecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}

