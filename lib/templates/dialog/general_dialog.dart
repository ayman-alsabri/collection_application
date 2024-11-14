import 'dart:ui';

import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/helpers/r_rect_stroke_clipper.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class GeneralDialog extends StatelessWidget {
  final Widget child;
  final double? height;
  const GeneralDialog({
    super.key,
    required this.child,
    this.height,
  });

  static const transitionDuration = Duration(milliseconds: 300);
  static Widget transitionBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    final scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      ),
    );

    return FadeTransition(
      opacity: opacityAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: lightGrayShadowColor.withOpacity(0.5),
              blurRadius: 20,
            ),
            BoxShadow(
                blurStyle: BlurStyle.outer,
                color: shadowColor.withOpacity(0.4),
                blurRadius: 10)
          ],
        ),
        clipBehavior: Clip.antiAlias,
        height: height,
        width: Responsive.width(339),
        // padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      gradientStartColor.withOpacity(0.5),
                      gradientEndColor.withOpacity(0.5),
                    ],
                    begin: const Alignment(0, -1.25),
                    end: const Alignment(0.0545, 1.5),
                  ),
                ),
                child: child,
              ),
            ),
            ClipPath(
              clipper: RRectStrokeClipper(borderRadius: 20, strokeWidth: 4),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        strokeGradientStartColor.withOpacity(0.2),
                        strokeGradientEndColor.withOpacity(0.2),
                      ],
                      begin: const Alignment(-1, -1),
                      end: const Alignment(0.166, 1.375)),
                ),
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
