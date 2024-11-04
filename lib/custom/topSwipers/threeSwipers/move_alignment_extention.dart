import 'package:flutter/material.dart';

extension MoveAlignmentExtention on Alignment {
  Alignment move(int movement) {
    double newX = x + movement;
    if (newX < -1) {
      newX = 1;
    } else if (newX > 1) {
      newX = -1;
    }

    double newY = x + movement == 0 ? 1 : -1;

    return Alignment(newX, newY);
  }

}
