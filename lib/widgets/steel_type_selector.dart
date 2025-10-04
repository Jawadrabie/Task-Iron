import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/steel_section.dart';
import '../services/steel_data_service.dart';

class SteelTypeSelector extends StatelessWidget {
  final List<SteelType> types;
  final int selectedIndex;
  final Function(int) onTypeSelected;

  const SteelTypeSelector({
    super.key,
    required this.types,
    required this.selectedIndex,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(types.length, (index) {
          final type = types[index];
          final isSelected = index == selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTypeSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SVG Icon
                    Container(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        SteelDataService.getAssetPath(type.symbol),
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Type Name
                    Text(
                      type.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
