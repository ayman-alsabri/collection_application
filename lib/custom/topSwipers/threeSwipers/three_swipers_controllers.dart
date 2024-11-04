import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

enum Containers {
  first,
  second,
  third,
}

class ThreeSwipersControllers extends GetxController with ThreeSwipersMixin {
  static const duration = Duration(milliseconds: 300);

  final focusedIndex = Containers.second.obs;
  final isAnimating = false.obs;


  void onTap(Containers tappedContaner) async {
    final movement = defineMovement(tappedContaner);
    if (movement == 0) return;
    setEffects(movement);
    isAnimating.value = true;
    await Future.delayed(duration);
    focusedIndex.value = tappedContaner;
    isAnimating.value = false;
  }

  List<Effect> getEffect(Containers targetedContainer) {
    switch (targetedContainer) {
      case Containers.first:
        return firstEffects;
      case Containers.second:
        return secondEffects;
      case Containers.third:
        return thirdEffects;
      default:
        return [];
    }
  }

  Alignment getAlignment(Containers targetedContainer) {
    switch (targetedContainer) {
      case Containers.first:
        return firstAlignment;
      case Containers.second:
        return secondAlignment;
      case Containers.third:
        return thirdAlignment;
      default:
        return const Alignment(0, 0);
    }
  }
}
