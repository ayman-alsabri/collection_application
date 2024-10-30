import 'dart:ui';

import 'package:collection_application/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class PrimaryCurvedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const PrimaryCurvedContainer(
      {super.key, required this.child, this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Responsive.withHeightPercentage(
      270 / 844,
      Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: shadowColor.withOpacity(0.6), // External shadow color
          //     blurRadius: 60,
          //     spreadRadius: 0,
          //     offset:
          //         const Offset(0, 20), // Mimicking the shadow from the filter
          //   ),
          // ],
        ),
        child: Stack(
          children: [
            ClipPath(
              clipper: PrimaryCurvedContainerClipper(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      // TODO: adjust the alignment according to the logo
                      begin: const Alignment(0.45, 0.35),
                      end: const Alignment(0.55, 0.9),
                      colors: [
                        gradientStartColor
                            .withOpacity(0.6), // External gradient color
                        gradientEndColor.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: SizedBox.expand(
                      child: Padding(
                          padding: padding, child: Center(child: child))),
                ),
              ),
            ),
            ClipPath(
              clipper: PrimaryCurvedContainerClipper(20, true),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      strokeGradientStartColor.withOpacity(0.2),
                      strokeGradientEndColor.withOpacity(0.2),
                      strokeGradientEndColor.withOpacity(0.2),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom clipper for the container shape
class PrimaryCurvedContainerClipper extends CustomClipper<Path> {
  double borderRadius;
  final bool _isParent;
  double _padding = 2;
  PrimaryCurvedContainerClipper(this.borderRadius, [this._isParent = false]);
  final _deviseHeight = Responsive.deviseHeight;
  // final _deviseWidth = Responsive.instanse.deviseWidth;
  @override
  Path getClip(Size size) {
    Path parentPath = Path();
    Path childPath = Path();
    if (!_isParent) {
      _padding = 0;
      _drawPrimaryContainerShape(childPath, size);
      return childPath;
    }
    borderRadius -= _padding;
    _drawPrimaryContainerShape(childPath, size);
    borderRadius += _padding;
    _padding = 0;
    _drawPrimaryContainerShape(parentPath, size);
    return Path.combine(PathOperation.difference, parentPath, childPath);
  }

  void _drawPrimaryContainerShape(Path path, Size size) {
    path.moveTo((0) + _padding, (size.height - borderRadius) - _padding);
    path.cubicTo(
        (0) + _padding,
        (size.height - (borderRadius / 2.5)) - _padding,
        ((borderRadius / 2.5) + borderRadius / 10) + _padding,
        (size.height + 1.3) - _padding,
        (borderRadius + borderRadius / 10) + _padding,
        (size.height - 0.1) - _padding);
    path.lineTo((size.width - borderRadius) - _padding,
        (size.height - (_deviseHeight / 21)) - _padding);
    path.cubicTo(
        (size.width - (borderRadius / 2.5)) - _padding,
        (size.height - 1 - (_deviseHeight / 21)) - _padding,
        (size.width) - _padding,
        (size.height -
                ((borderRadius / 2.5) + borderRadius / 10) -
                (_deviseHeight / 21)) -
            _padding,
        (size.width) - _padding,
        (size.height - borderRadius - (_deviseHeight / 21)) - _padding);

    path.lineTo((size.width) - _padding, (borderRadius) + _padding);
    path.cubicTo(
        (size.width) - _padding,
        (borderRadius / 2.5) + _padding,
        (size.width - (borderRadius / 2.5)) - _padding,
        _padding,
        (size.width - borderRadius) - _padding,
        _padding);
    path.lineTo((borderRadius) + _padding, _padding);
    path.cubicTo((borderRadius / 2.5) + _padding, _padding, _padding,
        (borderRadius / 2.5) + _padding, _padding, (borderRadius) + _padding);
    path.lineTo(_padding, (size.height - borderRadius) - _padding);
    path.close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
