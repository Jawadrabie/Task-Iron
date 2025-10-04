import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/steel_section.dart';
import '../services/steel_data_service.dart';

class SteelSvgImage extends StatelessWidget {
  final SteelVariant variant;

  const SteelSvgImage({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    try {
      final imagePath = SteelDataService.getAssetPath(
        SteelDataService.getImagePath(variant.bigImg),
      );

      return SvgPicture.asset(
        imagePath,
        fit: BoxFit.contain,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        placeholderBuilder: (context) =>
            const Center(child: CircularProgressIndicator(color: Colors.black)),
      );
    } catch (e) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('خطأ في تحميل الصورة', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }
  }
}
