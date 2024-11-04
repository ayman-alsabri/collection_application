import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/helpers/r_rect_stroke_clipper.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GeneralBottomSheet extends StatefulWidget {
  final Widget? child;
  final String firstButtonName;
  final String secondButtonName;
  final void Function(int index)? onTap;

  const GeneralBottomSheet({
    super.key,
    this.child,
    required this.firstButtonName,
    required this.secondButtonName,
    this.onTap,
  });

  @override
  State<GeneralBottomSheet> createState() => _GeneralBottomSheetState();
}

class _GeneralBottomSheetState extends State<GeneralBottomSheet> {
  final _animationDuration = 250.milliseconds;
  bool _animate = false;
  int _focusedIndex = 0;

  Future<void> _onTap(int index) async {
    if (_animate) return;

    setState(() {
      _animate = true;
      _focusedIndex = index;
    });

    await Future.delayed(_animationDuration);
    if (widget.onTap != null) {
      widget.onTap!(index);
    }

    setState(() {
      _animate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:  Responsive.height(450),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                colors: [
                  gradientStartColor,
                  gradientEndColor,
                ],
                begin: Alignment(-0.63, -1.09),
                end: Alignment(0, 0.191),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, -20), blurRadius: 40)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _createButton(widget.firstButtonName, 0),
                      _createButton(widget.secondButtonName, 1),
                    ],
                  ),
                ),
                Expanded(child: widget.child ?? const SizedBox())
              ],
            ),
          ),
          ClipPath(
            clipper: RRectStrokeClipper(borderRadius: 30, strokeWidth: 4),
            child: Container(
              width: double.maxFinite,
              height: Responsive.height(100),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                strokeGradientStartColor.withOpacity(0.1),
                Colors.transparent
              ], begin: const Alignment(0, -1), end: const Alignment(0, 1))),
            ),
          )
        ],
      ),
    );
  }

  Widget _createButton(String buttonName, int index) {
    bool isFocused = _focusedIndex == index;

    final elevatedShadows = [
      BoxShadow(
          color: elevatedButtonTopShadow.withOpacity(1),
          offset: const Offset(-3, -3),
          blurRadius: 6),
      BoxShadow(
          color: Colors.black.withOpacity(0.5),
          offset: const Offset(3, 3),
          blurRadius: 6),
      const BoxShadow(color: elevatedButtonColor),
    ];
    final cravedShadows = [
      const BoxShadow(
          color: cravedButtonButtomShadow, offset: Offset(2, 2), blurRadius: 1),
      const BoxShadow(color: cravedButtonTopShadow),
      const BoxShadow(
          color: cravedButtonColor,
          offset: Offset(1.5, 1.5),
          spreadRadius: -0.5,
          blurRadius: 2),
    ];

    return InkWell(
      splashColor: Colors.transparent,
      onTap: isFocused ? null : () => _onTap(index),
      child: AnimatedContainer(
        width: (Responsive.deviseWidth / 2) - 32 - 32,
        height: Responsive.height(43),
        duration: _animationDuration,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: isFocused ? cravedShadows : elevatedShadows,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            index == 0 ? widget.firstButtonName : widget.secondButtonName,
            style: TextStyle(
              fontFamily: 'TITR',
              fontSize: Responsive.width(15),height: 2
            ),
          ).animate(target: isFocused ? 1 : 0).custom(
            builder: (context, value, child) {
              final color1 =
                  ColorTween(begin: bluegradientStartColor, end: Colors.white.withOpacity(0.6))
                      .transform(value)!;
              final color2 =
                  ColorTween(begin: bluegradientEndColor, end: Colors.white.withOpacity(0.6))
                      .transform(value)!;

              return ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                        colors: [color1, color2],
                        begin: const Alignment(-1, 0),
                        end: const Alignment(1, 0),
                      ).createShader(bounds),
                  child: child);
            },
          ),
        ),
      ),
    );
  }
}
