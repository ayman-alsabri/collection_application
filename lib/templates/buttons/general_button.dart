import 'package:collection_application/globalControllers/responsive.dart';
import 'package:flutter/material.dart';

class GeneralButton extends StatefulWidget {
  final void Function()? onPressed;
  final List<Color> colors;
  final double width;
  final double height;
  final Widget child;
  final List<BoxShadow> shadows;

  const GeneralButton({
    super.key,
    this.onPressed,
    required this.height,
    required this.width,
    required this.colors,
    required this.child,
    this.shadows = const [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 4),
        blurRadius: 4, // Shadow blur
      ),
    ],
  });

  @override
  State<GeneralButton> createState() => _GeneralButtonState();
}

class _GeneralButtonState extends State<GeneralButton> {
  late final _buttonWidth = Responsive.width(widget.width);
  late final _buttonHeight = Responsive.height(widget.height);
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
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(
        vertical: _buttonHeight * (_animateTap ? 0.01 : 0),
        horizontal: _buttonWidth * (_animateTap ? 0.01 : 0),
      ),
      duration: _animationDuration,
      height: _buttonHeight * (_animateTap ? 0.98 : 1),
      width: _buttonWidth * (_animateTap ? 0.98 : 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.colors,
          begin: const Alignment(0, -1.25),
          end: const Alignment(0.0545, 1.5),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: _animateTap ? null : widget.shadows,
      ),
      child: TextButton(
          onPressed:() => _animateTap?null: handleTap(),
          style: TextButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            overlayColor: Colors.transparent,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
          ),
          child: widget.child),
    );
  }
}
