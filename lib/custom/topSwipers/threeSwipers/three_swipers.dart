import 'package:collection_application/custom/topSwipers/swiper_container.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers_controllers.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreeSwipers extends StatelessWidget {
  const ThreeSwipers({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThreeSwipersControllers>();

    return SizedBox(
      height: Responsive.width(60) + 20,
      width: Responsive.deviseWidth - 2 * controller.margin,
      child: const Stack(
        alignment: Alignment.center,
        children: [
          SwiperContainer(
            index: Containers.first,
            iconName: 'meals.png',
            name: 'وجبات',
          ),
          SwiperContainer(
              index: Containers.second,
              iconName: 'grocery.png',
              name: 'منتجات'),
          SwiperContainer(
              index: Containers.third, iconName: 'food.png', name: 'طعام'),
        ],
      ),
    );
  }
}
