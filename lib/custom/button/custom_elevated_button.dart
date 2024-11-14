import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomElevatedButton extends StatefulWidget {
  final Future<void> Function()? onPressed;
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
  bool _isloading = false;
  final _animationDuration = const Duration(milliseconds: 250);

  void handleTap() async {
    setState(() {
      _animateTap = true;
    });

    await Future.delayed(
        Duration(milliseconds: _animationDuration.inMilliseconds + 50));
    if (widget.onPressed != null) {
      setState(() {
        _isloading = true;
      });

      await widget.onPressed!();
      setState(() {
        _isloading = true;
      });
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
        
        borderRadius: BorderRadius.circular(10),
        boxShadow: _animateTap
            ? [
                BoxShadow(
                    color: cravedButtonButtomShadow.withOpacity(0.4),
                    offset: const Offset(2.5, 2.5),
                    blurRadius: 2,
                    spreadRadius: -2),
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                ),
                BoxShadow(
                  spreadRadius: -0.5,
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                  color: Color.alphaBlend(
                      elevatedButtonColor.withOpacity(0.3), gradientEndColor),
                ),
              ]
            : [
                BoxShadow(
                  color: 
                      cravedButtonButtomShadow.withOpacity(0.6),
                  offset: const Offset(-2, -2),
                  spreadRadius: -1,
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  offset: const Offset(2, 2),
                  spreadRadius: -1,
                  blurRadius: 6,
                ),
                BoxShadow(
                  color:  Color.alphaBlend(
                      elevatedButtonColor.withOpacity(0.45), gradientEndColor)
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
          child: _isloading
              ? LoadingAnimationWidget.waveDots(
                  size: Responsive.width(20),
                  color: strokeGradientStartColor.withOpacity(0.6))
              : Text(
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
