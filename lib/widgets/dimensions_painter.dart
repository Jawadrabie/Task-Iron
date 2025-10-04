import 'package:flutter/material.dart';
import '../models/steel_section.dart';
import 'dimensions_layout.dart';

class DimensionsPainter extends CustomPainter {
  final SteelVariant variant;

  DimensionsPainter({required this.variant});

  @override
  void paint(Canvas canvas, Size size) {
    final dimPaint = Paint()
      ..color = Colors.grey.shade500
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    final layout = DimensionsLayout(variant: variant, size: size);

    const double tick = 6;

    const double bTopMargin = 70;
    const double bWidth = 115;
    final b = layout.horizontalDim(
      x: layout.centerX - bWidth / 2,
      y: layout.centerY - layout.diagramHeight / 2 - bTopMargin,
      width: bWidth,
    );
    const double bGap = 60;
    final double bMidX = (b.start.dx + b.end.dx) / 2;
    final double bHalfGap = bGap / 2;

    canvas.drawLine(
      Offset(b.start.dx, b.start.dy),
      Offset(bMidX - bHalfGap, b.start.dy),
      dimPaint,
    );
    canvas.drawLine(
      Offset(bMidX + bHalfGap, b.end.dy),
      Offset(b.end.dx, b.end.dy),
      dimPaint,
    );
    _drawHorizontalTicks(canvas, dimPaint, b.start, b.end, tick);

    _drawText(
      textPainter,
      canvas,
      'B ${variant.b.toStringAsFixed(1)}',
      color: Colors.red,
      anchorCenter: Offset(bMidX, b.start.dy),
    );

    const double hHeight = 275;
    final double hY = layout.centerY - hHeight / 2;
    final h = layout.verticalDim(
      x: layout.centerX + layout.diagramWidth / 2 + 30,
      y: hY,
      height: hHeight,
    );
    const double hGap = 46;
    final double hMidY = (h.start.dy + h.end.dy) / 2;
    final double halfGap = hGap / 2;

    canvas.drawLine(
      Offset(h.start.dx, h.start.dy),
      Offset(h.start.dx, hMidY - halfGap),
      dimPaint,
    );
    canvas.drawLine(
      Offset(h.start.dx, hMidY + halfGap),
      Offset(h.end.dx, h.end.dy),
      dimPaint,
    );

    _drawVerticalTicks(canvas, dimPaint, h.start, h.end, tick);

    _drawText(
      textPainter,
      canvas,
      'H ${variant.h.toStringAsFixed(0)}',
      color: Colors.red,
      anchorCenter: Offset(h.start.dx, hMidY),
    );

    final double twWidth = 28;
    final tw = layout.horizontalDim(
      x: layout.centerX - twWidth / 2,
      y: layout.centerY,
      width: twWidth,
    );
    canvas.drawLine(tw.start, tw.end, dimPaint);
    _drawHorizontalTicks(canvas, dimPaint, tw.start, tw.end, tick);
    const double twLabelOffsetX = 52;
    const double twLabelOffsetY = 8;
    _drawText(
      textPainter,
      canvas,
      'Tw ${variant.tw.toStringAsFixed(1)}',
      color: Colors.red,
      anchorTopLeft: Offset(
        tw.start.dx - twLabelOffsetX,
        tw.start.dy - twLabelOffsetY,
      ),
    );

    final tfPos = layout.labelOnly(
      Offset(
        layout.centerX - layout.diagramWidth / 2 - 15,
        layout.centerY - layout.diagramHeight / 2 - 55,
      ),
    );
    _drawText(
      textPainter,
      canvas,
      'TF ${variant.tf.toStringAsFixed(1)}',
      color: Colors.red,
      anchorTopLeft: tfPos,
    );

    if (variant.r != null && variant.r! > 0) {
      const double rOffsetLeft = 14;
      const double rOffsetDown = 60;
      final r = layout.radiusMarker(
        x: layout.centerX + layout.diagramWidth / 4 - 10 - rOffsetLeft,
        y: layout.centerY + layout.diagramHeight / 4 + rOffsetDown,
        h: 40,
        v: 36,
        labelGap: 8,
      );
      canvas.drawLine(r.hStart, r.hEnd, dimPaint);
      canvas.drawLine(r.vStart, r.vEnd, dimPaint);
      _drawHorizontalTicks(canvas, dimPaint, r.hEnd, r.hEnd, tick);
      _drawVerticalTicks(canvas, dimPaint, r.vEnd, r.vEnd, tick);

      final Offset rLabelTopLeft = Offset(r.hEnd.dx + -15, r.vEnd.dy - 2);
      _drawText(
        textPainter,
        canvas,
        'R ${variant.r!.toStringAsFixed(1)}',
        color: Colors.red,
        anchorTopLeft: rLabelTopLeft,
      );
    }
  }

  void _drawText(
    TextPainter tp,
    Canvas canvas,
    String text, {
    required Color color,
    Offset? anchorCenter,
    Offset? anchorTopLeft,
    bool above = false,
  }) {
    tp.text = TextSpan(
      text: text,
      style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold),
    );
    tp.layout();

    if (anchorCenter != null) {
      final dy = above ? -tp.height : -tp.height / 2;
      final offset = Offset(
        anchorCenter.dx - tp.width / 2,
        anchorCenter.dy + dy,
      );
      tp.paint(canvas, offset);
    } else if (anchorTopLeft != null) {
      tp.paint(canvas, anchorTopLeft);
    }
  }

  void _drawHorizontalTicks(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset end,
    double tick,
  ) {
    canvas.drawLine(
      Offset(start.dx, start.dy - tick),
      Offset(start.dx, start.dy + tick),
      paint,
    );
    canvas.drawLine(
      Offset(end.dx, end.dy - tick),
      Offset(end.dx, end.dy + tick),
      paint,
    );
  }

  void _drawVerticalTicks(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset end,
    double tick,
  ) {
    canvas.drawLine(
      Offset(start.dx - tick, start.dy),
      Offset(start.dx + tick, start.dy),
      paint,
    );
    canvas.drawLine(
      Offset(end.dx - tick, end.dy),
      Offset(end.dx + tick, end.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
