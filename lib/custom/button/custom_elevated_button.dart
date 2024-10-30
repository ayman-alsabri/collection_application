import 'package:collection_application/globalControllers/responsive.dart';
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
  final _animationDuration = const Duration(milliseconds: 150);

  void handleTap() async {
    setState(() {
      _animateTap = true;
    });
    await Future.delayed(
        Duration(milliseconds: _animationDuration.inMilliseconds + 100));
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
      padding: EdgeInsets.all(7),
      curve: Curves.linear,
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
                const BoxShadow(
                  color: Color.fromRGBO(32, 38, 51, 0.1),
                  // offset: Offset(3, 3),
                  // blurRadius: 10
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
        child: FittedBox(fit: BoxFit.contain,
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


// class CustomElevatedButton extends StatefulWidget {
//   final double height;
//   final double width;
//   final String text;
//   const CustomElevatedButton(
//       {super.key,
//       required this.height,
//       required this.width,
//       required this.text});

//   @override
//   State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
// }

// class _CustomElevatedButtonState extends State<CustomElevatedButton> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomElevatedButton(
//         height: widget.height,
//         width: widget.width,
//         colors: const [elevatedButtonColor, elevatedButtonColor],
//         shadows: const [
//           BoxShadow(
//             color: elevatedButtonTopShadow,
//             offset: Offset(-3, -3),
//             blurRadius: 10
//           ),
//           BoxShadow(
//               color: elevatedButtonButtomShadow,
//               offset: Offset(3, 3),
//               blurRadius: 10)
//         ],
//         child: FittedBox(
//           fit: BoxFit.scaleDown,
//           child: Text(
//             widget.text,
//             style: TextStyle(
//                 color: bluegradientStartColor,
//                 fontFamily: 'SF MADA',
//                 fontSize: Responsive.width(20)),
//           ),
//         ));
//   }
// }
