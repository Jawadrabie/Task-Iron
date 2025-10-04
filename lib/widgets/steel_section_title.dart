import 'package:flutter/material.dart';
import '../models/steel_section.dart';

class SteelSectionTitle extends StatelessWidget {
  final SteelVariant variant;

  const SteelSectionTitle({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        variant.name.ar,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
