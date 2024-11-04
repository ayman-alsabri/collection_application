import 'package:collection_application/helpers/r_rect_stroke_clipper.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SqareButton extends StatefulWidget {
  final List<Color> colors;
  final List<BoxShadow>? shadows;
  final double strokeOpacity;
  final double borderRadius;
  final Size buttonSize;
  final Widget? child;
  final void Function()? onPressed;

  const SqareButton({
    super.key,
    required this.colors,
    required this.borderRadius,
    required this.buttonSize,
    required this.strokeOpacity,
    required this.onPressed,
    required this.shadows,
    this.child,
  });

  @override
  State<SqareButton> createState() => _SqareButtonState();
}

class _SqareButtonState extends State<SqareButton> {
  late final _buttonHeight = widget.buttonSize.height;
  late final _buttonWidth = widget.buttonSize.width;

  bool _animateTap = false;
  final _animationDuration = const Duration(milliseconds: 150);

  void handleTap() async {
    setState(() {
      _animateTap = true;
    });
    await Future.delayed(_animationDuration);
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
    setState(() {
      _animateTap = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.symmetric(
            vertical: _buttonHeight * (_animateTap ? 0.015 : 0),
            horizontal: _buttonWidth * (_animateTap ? 0.015 : 0),
          ),
          duration: _animationDuration,
          height: _buttonHeight * (_animateTap ? 0.97 : 1),
          width: _buttonWidth * (_animateTap ? 0.97 : 1),
          padding: const EdgeInsets.symmetric(horizontal: 4.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: LinearGradient(
                colors: widget.colors,
                begin: const Alignment(-1, -1),
                end: const Alignment(0.4583, 1.75),
              ),
              boxShadow: _animateTap ? null : widget.shadows),
          child: TextButton(
            onPressed: () => _animateTap ? null : handleTap(),
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              overlayColor: Colors.transparent,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
            ),
            child: SizedBox(
              child: widget.child,
            ),
          ),
        ),
        ClipPath(
            clipper: RRectStrokeClipper(
                borderRadius: widget.borderRadius,
                strokeWidth: widget.buttonSize.width / 12),
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                vertical: _buttonHeight * (_animateTap ? 0.01 : 0),
                horizontal: _buttonWidth * (_animateTap ? 0.01 : 0),
              ),
              duration: _animationDuration,
              height: _buttonHeight * (_animateTap ? 0.98 : 1),
              width: _buttonWidth * (_animateTap ? 0.98 : 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    strokeGradientStartColor.withOpacity(widget.strokeOpacity),
                    strokeGradientEndColor.withOpacity(widget.strokeOpacity),
                  ],
                  begin: const Alignment(-1, -1),
                  end: const Alignment(0, 1),
                ),
              ),
            ).animate(effects: [
              const FadeEffect(begin: 1, end: 0),
            ], target: _animateTap ? 1 : 0)),
      ],
    );
  }
}
