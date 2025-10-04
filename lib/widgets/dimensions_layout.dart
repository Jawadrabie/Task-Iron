import 'package:flutter/widgets.dart';
import '../models/steel_section.dart';

class DimensionsLayout {
  final SteelVariant variant;
  final Size size;

  late final double centerX;
  late final double centerY;
  late final double diagramWidth;
  late final double diagramHeight;

  DimensionsLayout({required this.variant, required this.size}) {
    centerX = size.width / 2;
    centerY = size.height / 2;
    diagramWidth = size.width * 0.6;
    diagramHeight = size.height * 0.6;
  }

  ({Offset start, Offset end, Offset label}) horizontalDim({
    required double x,
    required double y,
    required double width,
    double labelPadding = 5,
  }) {
    final start = Offset(x, y);
    final end = Offset(x + width, y);
    final label = Offset(x + width / 2, y - labelPadding);
    return (start: start, end: end, label: label);
  }

  ({Offset start, Offset end, Offset labelCenter}) verticalDim({
    required double x,
    required double y,
    required double height,
    double leftShift = 20,
  }) {
    final start = Offset(x, y);
    final end = Offset(x, y + height);
    final labelCenter = Offset(x - leftShift, y + height / 2);
    return (start: start, end: end, labelCenter: labelCenter);
  }

  Offset labelOnly(Offset position) => position;

  ({Offset hStart, Offset hEnd, Offset vStart, Offset vEnd, Offset label})
  radiusMarker({
    required double x,
    required double y,
    double h = 22,
    double v = 14,
    double labelGap = 6,
  }) {
    final hStart = Offset(x, y);
    final hEnd = Offset(x + h, y);
    final vStart = Offset(x, y);
    final vEnd = Offset(x, y - v);
    final label = Offset(x + h + labelGap, y);
    return (
      hStart: hStart,
      hEnd: hEnd,
      vStart: vStart,
      vEnd: vEnd,
      label: label,
    );
  }
}
