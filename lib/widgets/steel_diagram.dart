import 'package:flutter/material.dart';
import '../models/steel_section.dart';
import 'dimensions_painter.dart';
import 'steel_section_title.dart';
import 'steel_svg_image.dart';

class SteelDiagram extends StatelessWidget {
  final SteelVariant variant;

  const SteelDiagram({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SteelSectionTitle(variant: variant),

          const SizedBox(height: 20),

          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                      maxHeight: 300,
                    ),
                    child: SteelSvgImage(variant: variant),
                  ),
                ),

                Positioned.fill(
                  child: CustomPaint(
                    painter: DimensionsPainter(variant: variant),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
