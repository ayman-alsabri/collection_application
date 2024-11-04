import 'dart:ui';

import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class SecondaryCurvedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SecondaryCurvedContainer(
      {super.key, required this.child, this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Responsive.withHeightPercentage(
      222 / 844,
      Container(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.6), // External shadow color
              blurRadius: 60,
              spreadRadius: 0,
              offset:
                  const Offset(0, 20), // Mimicking the shadow from the filter
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -(Responsive.deviseHeight / 21),
              height: Responsive.height(222),
              width: Responsive.deviseWidth - 32,
              child: ClipPath(
                clipper: SecondaryCurvedContainerClipper(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5 + 0, sigmaY: 50),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: const Alignment(0.45, 0.35),
                        end: const Alignment(0.55, 0.9),
                        colors: [
                          gradientStartColor
                              .withOpacity(0.6), // External gradient color
                          gradientEndColor.withOpacity(0.6),
                        ],
                      ),
                    ),child: Padding(
                      padding: padding,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -(Responsive.deviseHeight / 21),
              height: Responsive.height(222),
              width: Responsive.deviseWidth - 32,
              child: ClipPath(
                clipper: SecondaryCurvedContainerClipper(20, true),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        strokeGradientEndColor.withOpacity(0.2),
                        strokeGradientEndColor.withOpacity(0.2),
                        strokeGradientStartColor.withOpacity(0.2),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom clipper for the container shape
class SecondaryCurvedContainerClipper extends CustomClipper<Path> {
   double borderRadius;
  final bool _isParent;
  double _padding = 2;
  SecondaryCurvedContainerClipper(this.borderRadius, [this._isParent = false]);
  final _deviseHeight = Responsive.deviseHeight;
  // final _deviseWidth = Responsive.instanse.deviseWidth;
  @override
  Path getClip(Size size) {
    Path parentPath = Path();
    Path childPath = Path();
    if (!_isParent) {
      _padding = 0;
      _drawSecondaryContainerShape(childPath, size);
      return childPath;
    }
    borderRadius -= _padding;
    _drawSecondaryContainerShape(childPath, size);
    borderRadius += _padding;
    _padding = 0;
    _drawSecondaryContainerShape(parentPath, size);
    return Path.combine(PathOperation.difference, parentPath, childPath);
  }

  void _drawSecondaryContainerShape(Path path, Size size) {
    path.moveTo((0) + _padding, (size.height - borderRadius) - _padding);
    path.cubicTo(
        (0) + _padding,
        (size.height - (borderRadius / 2.5)) - _padding,
        (borderRadius / 2.5) + _padding,
        (size.height) - _padding,
        (borderRadius) + _padding,
        (size.height) - _padding);
    path.lineTo(
        (size.width - borderRadius) - _padding, (size.height) - _padding);
    path.cubicTo(
        (size.width - (borderRadius / 2.5)) - _padding,
        (size.height) - _padding,
        (size.width) - _padding,
        (size.height - (borderRadius / 2.5)) - _padding,
        (size.width) - _padding,
        (size.height - borderRadius) - _padding);
    path.lineTo((size.width) - _padding, borderRadius + _padding);

    path.cubicTo(
        (size.width) - _padding,
        (borderRadius / 2.5) + _padding,
        (size.width) - _padding - borderRadius / 2,
        (-1) + _padding,
        (size.width) - borderRadius / 10 - borderRadius - _padding,
        (0) + _padding);

    path.lineTo((borderRadius - (borderRadius / 10)) + _padding,
        (_deviseHeight / 21) + _padding);

    path.cubicTo(
        (borderRadius / 2.5) + _padding,
        (1 + _deviseHeight / 21) + _padding,
        _padding,
        ((_deviseHeight / 21) + borderRadius / 2) + _padding,
        _padding,
        ((_deviseHeight / 21) + borderRadius) + _padding);

    path.lineTo(_padding, (size.height - borderRadius) - _padding);

    path.close();
    return;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
