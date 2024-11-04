import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class CarvedContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  const CarvedContainer({
    super.key,
    this.child,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);
    final height = Responsive.height(44);
    final width = Responsive.deviseWidth;
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: searchBarTopShadow,
        boxShadow: const [
          BoxShadow(
            color: searchBarBottomShadow,
            blurRadius: 2,
            spreadRadius: -2,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: const [
              BoxShadow(
                color: bottomGradientStartColor,
                blurRadius: 20,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
