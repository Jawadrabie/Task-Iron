import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/steel_section.dart';
import '../services/steel_data_service.dart';
import '../core/constants/app_constants.dart';

class SteelDetailsDialog extends StatelessWidget {
  final SteelVariant variant;

  const SteelDetailsDialog({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    variant.size,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(AppColors.primary),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),

            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 16,
              indent: 0,
              endIndent: 0,
            ),
            // Content (image fixed, table scrollable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 110,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: SvgPicture.asset(
                    SteelDataService.getAssetPath(
                      SteelDataService.getImagePath(variant.img),
                    ),
                    height: 80,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF5E35B1),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),

            // Fixed header + scrollable body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _buildInfoHeader(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: false,
                  child: SingleChildScrollView(child: _buildInfoTable()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTable() {
    final properties = [
      {'label': 'Size', 'value': variant.size},
      {'label': 'Country', 'value': variant.countryString},
      {'label': 'Weight', 'value': '${variant.weight.toStringAsFixed(1)} kg/m'},
      {'label': 'H', 'value': '${variant.h.toStringAsFixed(1)} mm'},
      {'label': 'B', 'value': '${variant.b.toStringAsFixed(1)} mm'},
      {'label': 'Tw', 'value': '${variant.tw.toStringAsFixed(1)} mm'},
      {'label': 'Tf', 'value': '${variant.tf.toStringAsFixed(1)} mm'},
      {'label': 'Al', 'value': variant.al.toStringAsFixed(2)},
      if (variant.r != null && variant.r! > 0)
        {'label': 'r', 'value': '${variant.r!.toStringAsFixed(1)} mm'},
      {'label': 'd', 'value': '${variant.d.toStringAsFixed(1)} mm'},
      {'label': 'hi', 'value': '${variant.hi.toStringAsFixed(1)} mm'},
      {'label': 'ss', 'value': '${variant.ss.toStringAsFixed(2)} m²/m'},
      {'label': 'A', 'value': '${variant.a.toStringAsFixed(1)} cm²'},
      {'label': 'Av', 'value': '${variant.av.toStringAsFixed(1)} cm²'},
      {'label': 'Ix', 'value': '${variant.ix.toStringAsFixed(1)} cm⁴'},
      {'label': 'Iy', 'value': '${variant.iy.toStringAsFixed(1)} cm⁴'},
      {'label': 'Sx', 'value': '${variant.sx.toStringAsFixed(1)} cm³'},
      {'label': 'Sy', 'value': '${variant.sy.toStringAsFixed(1)} cm³'},
      {'label': 'Zx', 'value': '${variant.zx.toStringAsFixed(1)} cm³'},
      {'label': 'Zy', 'value': '${variant.zy.toStringAsFixed(1)} cm³'},
      {'label': 'rx', 'value': '${variant.rx.toStringAsFixed(2)} cm'},
      {'label': 'ry', 'value': '${variant.ry.toStringAsFixed(2)} cm'},
      {'label': 'J', 'value': '${variant.j.toStringAsFixed(1)} cm⁴'},
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ...properties.asMap().entries.map((entry) {
            final index = entry.key;
            final property = entry.value;
            final bool isLast = index == properties.length - 1;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                border: isLast
                    ? null
                    : Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      property['label']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      property['value']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              'Property',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Value',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Colors.black87,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
