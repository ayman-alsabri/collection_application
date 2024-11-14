import 'dart:ui';

import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/helpers/r_rect_stroke_clipper.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class TransparentRrectContainer extends StatelessWidget {
  final double hight;
  final Widget child;
  const TransparentRrectContainer({
    super.key,
    required this.child,
    this.hight = 194,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveHight = Responsive.height(hight);
    return Container(
      clipBehavior: Clip.antiAlias,
      height: responsiveHight,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.6),
            blurRadius: 60,
            spreadRadius: 0,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: lightGrayShadowColor.withOpacity(0.5),
            blurRadius: 60,
            offset:
                const Offset(0, -20), // Mimicking the shadow from the filter
          ),
        ],
      ),
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              decoration: BoxDecoration(

                  // borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [
                    gradientStartColor.withOpacity(0.4),
                    gradientEndColor.withOpacity(0.4),
                  ],
                      begin: const Alignment(0.4, 0.55),
                      end: const Alignment(0.5, 2.2))),
              child: child
            ),
          ),
          ClipPath(
            clipper: RRectStrokeClipper(borderRadius: 20, strokeWidth: 4),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    stops: const [
                      0.0,
                      0.84,
                      1.0
                    ],
                    colors: [
                      strokeGradientStartColor.withOpacity(0.2),
                      strokeGradientEndColor.withOpacity(0.2),
                      strokeGradientEndColor.withOpacity(0.2),
                    ],
                    begin: const Alignment(-1, -1),
                    end: const Alignment(0.5, 1)),
              ),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}
