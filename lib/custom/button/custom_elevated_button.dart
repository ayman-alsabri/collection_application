import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final void Function()? onPressed;
  final double width;
  final double height;
  final String text;

  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.height,
    required this.width,
    required this.text,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  late final _buttonWidth = Responsive.width(widget.width);
  late final _buttonHeight = Responsive.height(widget.height);
  bool _animateTap = false;
  final _animationDuration = const Duration(milliseconds: 250);

  void handleTap() async {
    setState(() {
      _animateTap = true;
    });
    await Future.delayed(
        Duration(milliseconds: _animationDuration.inMilliseconds + 50));
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
    setState(() {
      _animateTap = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(vertical: 8),
      curve: Curves.easeOut,
      margin: EdgeInsets.symmetric(
        vertical: _buttonHeight * (_animateTap ? 0.01 : 0),
        horizontal: _buttonWidth * (_animateTap ? 0.01 : 0),
      ),
      duration: _animationDuration,
      height: _buttonHeight * (_animateTap ? 0.98 : 1),
      width: _buttonWidth * (_animateTap ? 0.98 : 1),
      decoration: BoxDecoration(
        color: _animateTap
            ? cravedButtonColor.withOpacity(0.7)
            : elevatedButtonColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: _animateTap
            ? [
                BoxShadow(
                  color: cravedButtonTopShadow.withOpacity(0.1),
                ),
                BoxShadow(
                    color: cravedButtonButtomShadow.withOpacity(0.7),
                    offset: const Offset(2.5, 2.5),
                    blurRadius: 2,
                    spreadRadius: -0.5)
              ]
            : [
                BoxShadow(
                  color: elevatedButtonTopShadow.withOpacity(0.7),
                  offset: const Offset(-3, -3),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(3, 3),
                  blurRadius: 6,
                ),
              ],
      ),
      child: TextButton(
        onPressed: () => _animateTap ? null : handleTap(),
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          overlayColor: Colors.transparent,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            widget.text,
            style: TextStyle(
                color: strokeGradientStartColor.withOpacity(0.6),
                fontFamily: 'SF MADA',
                fontSize: Responsive.width(20)),
          ),
        ),
      ),
    );
  }
}
