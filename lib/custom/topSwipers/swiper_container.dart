import 'package:collection_application/custom/topSwipers/swiper_controller.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers_controllers.dart';
import 'package:collection_application/helpers/r_rect_stroke_clipper.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SwiperContainer extends StatelessWidget {
  final Containers index;
  final String iconName;
  final String name;
  const SwiperContainer({
    super.key,
    required this.index,
    required this.iconName,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final ThreeSwipersControllers controller = Get.find();
    final swiperController = SwiperController();
    const pressCurve = Curves.easeIn;
    const borderRadius = 10.0;

    return Obx(() {
      final isFocused = controller.focusedIndex.value == index;
      return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: -(8 + controller.containerWidth / 2),
              child: AnimatedOpacity(
                duration: ThreeSwipersControllers.duration,
                opacity: isFocused ? 1 : 0,
                curve: Curves.easeOutCubic,
                child: Text(
                  name,
                  style: const TextStyle(fontFamily: 'SF MADA', fontSize: 20),
                ),
              )),
          InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            splashColor: Colors.transparent,
            onTap: controller.isAnimating.value
                ? null
                : () async {
                    if (isFocused) return;
                    await swiperController.onTap();
                    await Future.delayed(Duration(milliseconds: ThreeSwipersControllers.duration.inMilliseconds -120));
                    return controller.onTap(index);
                  },
            child: AnimatedContainer(
              alignment: Alignment.center,
              height: controller.containerWidth -
                  (swiperController.showShadow.value ? 0 : 4),
              width: controller.containerWidth -
                  (swiperController.showShadow.value ? 0 : 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              curve: pressCurve,
              duration: ThreeSwipersControllers.duration,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                  colors: (isFocused)
                      ? const [
                          bluegradientStartColor,
                          bluegradientEndColor,
                        ]
                      : const [gradientStartColor, gradientEndColor],
                  begin: (isFocused)
                      ? const Alignment(0, -1.25)
                      : const Alignment(-0.05, 0.15),
                  end: (isFocused)
                      ? const Alignment(0.0545, 1.5)
                      : const Alignment(0.0545, 0.9),
                ),
                boxShadow: [
                  BoxShadow(
                      color: grayShadowColor.withOpacity(0.7),
                      offset: const Offset(0, -20),
                      blurRadius: 20),
                  BoxShadow(
                    color: shadowColor,
                    offset:
                        Offset(0, swiperController.showShadow.value ? 20 : 5),
                    blurRadius: swiperController.showShadow.value ? 30 : 10,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/icons/$iconName',
                fit: BoxFit.contain,
                opacity: AlwaysStoppedAnimation(isFocused ? 1 : 0.6),
              ),
            ),
          ),
          ClipPath(
            clipper: RRectStrokeClipper(
              borderRadius: borderRadius,
              strokeWidth: 4,
            ),
            child: AnimatedContainer(
              duration: ThreeSwipersControllers.duration,
              curve: pressCurve,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      strokeGradientStartColor.withOpacity(0.2),
                      strokeGradientEndColor.withOpacity(0.2),
                      strokeGradientEndColor.withOpacity(0.2),
                    ],
                    stops: const [
                      0,
                      0.7,
                      1
                    ],
                    begin: const Alignment(-1, -1),
                    end: const Alignment(0.7, 1.3)),
              ),
              height: controller.containerWidth -
                  (swiperController.showShadow.value ? 0 : 4),
              width: controller.containerWidth -
                  (swiperController.showShadow.value ? 0 : 4),
            ),
          )
        ],
      ).animate(
        key: ValueKey(controller.getAlignment(index)),
        effects: controller.getEffect(index),
      );
    });
  }
}
