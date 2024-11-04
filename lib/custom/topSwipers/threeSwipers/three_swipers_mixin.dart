import 'package:collection_application/custom/topSwipers/threeSwipers/move_alignment_extention.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers_controllers.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

mixin ThreeSwipersMixin {
  final margin = 24;
  final containerWidth = Responsive.width(60);
// positions (movements) [-1,0,1] == lastPosition - _alignments.index

  final _alignments = const [
    Alignment(-1, -1),
    Alignment(0, 1),
    Alignment(1, -1),
  ];

  List<Effect> firstEffects = [
    const AlignEffect(
        curve: Curves.linear,
        begin: Alignment(0, 0),
        end: Alignment(-1, -1),
        duration: ThreeSwipersControllers.duration)
  ];
  List<Effect> secondEffects = [
    const AlignEffect(
        curve: Curves.linear,
        end: Alignment(0, 1),
        duration: ThreeSwipersControllers.duration)
  ];
  List<Effect> thirdEffects = [
    const AlignEffect(
        curve: Curves.linear,
        end: Alignment(1, -1),
        duration: ThreeSwipersControllers.duration)
  ];

  Alignment firstAlignment = const Alignment(-1, -1);
  Alignment secondAlignment = const Alignment(0, 1);
  Alignment thirdAlignment = const Alignment(1, -1);

  int defineMovement(Containers tappedContaner) {
    final int movement;
    switch (tappedContaner) {
      case Containers.first:
        movement = (1 -
            _alignments.indexWhere(
              (element) =>
                  element.x == firstAlignment.x &&
                  element.y == firstAlignment.y,
            ));
        break;
      case Containers.second:
        movement = (1 -
            _alignments.indexWhere(
              (element) =>
                  element.x == secondAlignment.x &&
                  element.y == secondAlignment.y,
            ));
        break;
      case Containers.third:
        movement = (1 -
            _alignments.indexWhere(
              (element) =>
                  element.x == thirdAlignment.x &&
                  element.y == thirdAlignment.y,
            ));
        break;
      default:
        movement = 0;
    }
    return movement;
  }

  void setEffects(int movement) {
    firstEffects =
        _createEffects(firstAlignment, firstAlignment.move(movement), movement);
    firstAlignment = firstAlignment.move(movement);
    secondEffects = _createEffects(
        secondAlignment, secondAlignment.move(movement), movement);
    secondAlignment = secondAlignment.move(movement);
    thirdEffects =
        _createEffects(thirdAlignment, thirdAlignment.move(movement), movement);
    thirdAlignment = thirdAlignment.move(movement);

    // switch (movement) {
    //   case -1:
    //   case 0:
    //   case 1:
    // }
  }

  List<Effect> _createEffects(
      Alignment previousAlignment, Alignment nextAlignment, int movement) {
    // assuming that the movement will only be 1 and -1 which matches the affected alignment
    if (previousAlignment.x == movement) {
      final xOffset = (Responsive.deviseWidth * 0.75 -
              margin * 1.5 -
              0.25 * containerWidth) *
          previousAlignment.x;
      final halfDuration = Duration(
          milliseconds:
              (ThreeSwipersControllers.duration.inMilliseconds / 2).round());
      return [
        MoveEffect(
          curve: Curves.linear,
          begin: Offset(
              (Responsive.deviseWidth * 0.5 - margin - containerWidth * 0.5) *
                  previousAlignment.x,
              -10),
          // 12 is half the padding
          end: Offset(xOffset, -20),
          duration: halfDuration,
        ),
        MoveEffect(
          delay: halfDuration,
          curve: Curves.linear,
          // 12 is half the padding
          end: Offset(-xOffset * 2, 0),
          duration: Duration.zero,
        ),
        MoveEffect(
          delay: halfDuration,
          curve: Curves.linear,
          // 12 is half the padding
          end: Offset(
              ((Responsive.deviseWidth - 2 * margin) * previousAlignment.x -
                  xOffset),
              10),
          duration: halfDuration,
        ),
      ];
    }
    return [
      AlignEffect(
          curve: Curves.linear,
          begin: previousAlignment,
          end: nextAlignment,
          duration: ThreeSwipersControllers.duration)
    ];
  }
}
