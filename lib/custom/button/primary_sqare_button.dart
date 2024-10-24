import 'package:collection_application/globalControllers/authController/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PrimarySqareButton extends StatefulWidget {
  final String iconName;
  final void Function()? onPressed;

  const PrimarySqareButton({
    super.key,
    required this.iconName,
    this.onPressed,
  });

  @override
  State<PrimarySqareButton> createState() => _PrimarySqareButtonState();
}

class _PrimarySqareButtonState extends State<PrimarySqareButton> {
  final _responsive = Responsive.instanse;
  late final _buttonHeight = _responsive.height(24);
  late final _buttonWidth = _responsive.height(24);

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
            gradient: const LinearGradient(colors: [
              bluegradientStartColor,
              bluegradientEndColor,
            ], begin: Alignment(-1, -1), end: Alignment(0.4583, 1.75)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextButton(
            onPressed:handleTap,
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              overlayColor: Colors.transparent,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
            ),
            child: Image.asset('assets/icons/${widget.iconName}'),
          ),
        ),
        ClipPath(
            clipper: StrokeClipper(borderRadius: 5, strokeWidth: 2),
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
                      strokeGradientStartColor.withOpacity(0.6),
                      strokeGradientEndColor.withOpacity(0.6),
                    ],
                    begin: const Alignment(-1, -1),
                    end: const Alignment(0.166, 1.375)),
              ),
            ).animate(effects: [const FadeEffect(begin: 1, end: 0),],target: _animateTap?1:0)),
      ],
    );
  }
}

class StrokeClipper extends CustomClipper<Path> {
  final double borderRadius;
  final double strokeWidth;
  StrokeClipper({
    required this.borderRadius,
    required this.strokeWidth,
  });

  @override
  Path getClip(Size size) {
    final outerpath = Path();
    final innerrpath = Path();

    final outerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );
    outerpath.addRRect(outerRect);

    final innerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth,
          size.height - strokeWidth),
      Radius.circular(borderRadius - strokeWidth / 2),
    );
    innerrpath.addRRect(innerRect);

    return Path.combine(
      PathOperation.difference,
      outerpath,
      innerrpath,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
