import 'package:flutter/material.dart';
import '../controllers/steel_viewer_controller.dart';
import 'steel_type_selector.dart';
import 'steel_diagram.dart';
import 'steel_slider.dart';

class SteelViewerBody extends StatelessWidget {
  final SteelViewerController controller;

  const SteelViewerBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final steelData = controller.steelData;
        if (steelData == null) {
          return const Center(child: Text('لا توجد بيانات'));
        }

        final currentType = controller.currentType;
        if (currentType == null) {
          return const Center(child: Text('نوع غير صحيح'));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SteelTypeSelector(
                types: steelData.types,
                selectedIndex: controller.selectedTypeIndex,
                onTypeSelected: controller.selectType,
              ),
            ),

            // Main Content
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  // Steel Diagram
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SteelDiagram(
                        variant: currentType.variants[controller.selectedVariantIndex],
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: IconButton(
                      onPressed: () => controller.showDetails(context),
                      icon: const Icon(Icons.info_outline),
                      iconSize: 28,
                      color: Colors.black,
                      tooltip: 'عرض التفاصيل',
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: SteelSlider(
                variants: currentType.variants,
                selectedIndex: controller.selectedVariantIndex,
                onVariantSelected: controller.selectVariant,
              ),
            ),
          ],
        );
      },
    );
  }
}
