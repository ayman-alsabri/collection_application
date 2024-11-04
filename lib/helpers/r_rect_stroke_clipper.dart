import 'package:flutter/material.dart';

class RRectStrokeClipper extends CustomClipper<Path> {
  final double borderRadius;
  final double strokeWidth;
  RRectStrokeClipper({
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
