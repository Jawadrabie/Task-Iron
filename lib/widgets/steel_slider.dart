import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../models/steel_section.dart';
import '../core/constants/app_constants.dart';

// =======================================================================
// Custom thumb shape with value label
// =======================================================================
class CustomSliderThumbWithValue extends SliderComponentShape {
  final double thumbRadius;
  final String value;

  const CustomSliderThumbWithValue({
    required this.thumbRadius,
    required this.value,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius + 20);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter? labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        text: this.value,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    final Offset textCenter = Offset(center.dx, center.dy + thumbRadius + 18);
    final Rect rect = Rect.fromCenter(
      center: textCenter,
      width: tp.width + 24,
      height: tp.height + 12,
    );
    final RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(rRect, Paint()..color = Colors.black);
    tp.paint(canvas, textCenter - Offset(tp.width / 2, tp.height / 2));
  }
}

// =======================================================================
// Steel Slider — accelerated drag + stable slider (no bounce)
// =======================================================================
class SteelSlider extends StatefulWidget {
  final List<SteelVariant> variants;
  final int selectedIndex;
  final Function(int) onVariantSelected;

  const SteelSlider({
    super.key,
    required this.variants,
    required this.selectedIndex,
    required this.onVariantSelected,
  });

  @override
  State<SteelSlider> createState() => _SteelSliderState();
}

class _SteelSliderState extends State<SteelSlider> {
  late PageController _pageController;
  double _sliderValue = 0.0;
  final double _itemWidth = 180.0;
  Drag? _drag;

  static const double _dragSpeedMultiplier = 10;
  bool _isUserDragging = false;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.selectedIndex.toDouble();
    _pageController = PageController(
      viewportFraction: 0.5,
      initialPage: widget.selectedIndex,
    );

    _pageController.addListener(() {
      if (_pageController.page != null && !_isUserDragging) {
        setState(() {
          _sliderValue = _pageController.page!;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant SteelSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _pageController.animateToPage(
        widget.selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      _sliderValue = widget.selectedIndex.toDouble();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variants.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // Slider
        Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(AppColors.accent),
              inactiveTrackColor: Colors.black,
              trackHeight: 12,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
              trackShape: const RoundedRectSliderTrackShape(),
              thumbShape: CustomSliderThumbWithValue(
                thumbRadius: 16,
                value: widget
                    .variants[_sliderValue.round().clamp(
                      0,
                      widget.variants.length - 1,
                    )]
                    .size,
              ),
            ),
            child: Slider(
              value: _sliderValue.clamp(
                0.0,
                (widget.variants.length - 1).toDouble(),
              ),
              min: 0,
              max: (widget.variants.length - 1).toDouble(),
              onChanged: (value) {
                final double clamped = value.clamp(
                  0.0,
                  (widget.variants.length - 1).toDouble(),
                );
                setState(() => _sliderValue = clamped);
                _pageController.jumpToPage(clamped.round());
              },
              onChangeEnd: (value) {
                final int target = value.round();
                _pageController.animateToPage(
                  target,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ),

        // Carousel with accelerated drag (no slider bounce)
        Container(
          height: 80,
          child: GestureDetector(
            onHorizontalDragStart: (details) {
              _isUserDragging = true;
              _drag = _pageController.position.drag(details, () {
                _drag = null;
                _isUserDragging = false;
              });
            },
            onHorizontalDragUpdate: (details) {
              final double? primaryDelta = details.primaryDelta;
              _drag?.update(
                DragUpdateDetails(
                  globalPosition: details.globalPosition,
                  localPosition: details.localPosition,
                  sourceTimeStamp: details.sourceTimeStamp,
                  delta: details.delta * _dragSpeedMultiplier,
                  primaryDelta: primaryDelta != null
                      ? primaryDelta * _dragSpeedMultiplier
                      : null,
                ),
              );
            },
            onHorizontalDragEnd: (details) {
              _isUserDragging = false;
              _drag?.end(
                DragEndDetails(
                  primaryVelocity: details.primaryVelocity != null
                      ? details.primaryVelocity! * _dragSpeedMultiplier
                      : null,
                  velocity: Velocity(
                    pixelsPerSecond:
                        details.velocity.pixelsPerSecond * _dragSpeedMultiplier,
                  ),
                ),
              );

              Future.delayed(const Duration(milliseconds: 100), () {
                if (_pageController.hasClients) {
                  setState(() {
                    _sliderValue = _pageController.page!;
                  });
                }
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ..._buildOverlappingItems(),
                IgnorePointer(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.variants.length,
                    onPageChanged: widget.onVariantSelected,
                    itemBuilder: (context, index) => Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Overlapping 3D items

  List<Widget> _buildOverlappingItems() {
    final List<MapEntry<int, Widget>> items = [];
    final double page = _pageController.hasClients
        ? _pageController.page ?? widget.selectedIndex.toDouble()
        : widget.selectedIndex.toDouble();

    int centerIndex = page.round();

    for (int index = 0; index < widget.variants.length; index++) {
      double difference = page - index;
      int zIndex = (centerIndex - index).abs();
      items.add(MapEntry(zIndex, _buildTransformedItem(index, difference)));
    }

    items.sort((a, b) => b.key.compareTo(a.key));
    return items.map((e) => e.value).toList();
  }

  Widget _buildTransformedItem(int index, double difference) {
    double absDiff = difference.abs();
    double scale = (1 - absDiff * 0.3).clamp(0.0, 1.0);
    double offsetX = difference * -100;
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..translate(offsetX)
        ..scale(scale),
      alignment: Alignment.center,
      child: _buildListItem(index, index == _sliderValue.round()),
    );
  }

  Widget _buildListItem(int index, bool isSelected) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        setState(() => _sliderValue = index.toDouble());
      },
      child: RepaintBoundary(
        child: Container(
          width: _itemWidth,
          height: 70,
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? null : Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.variants[index].size,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
