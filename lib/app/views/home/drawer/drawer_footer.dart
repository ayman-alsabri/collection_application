import 'package:collection_application/app/globalControllers/dataController/data_controller.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerFooter extends StatelessWidget {
  const DrawerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DataController>();
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 24, left: 24, right: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: Responsive.width(55),
            height: Responsive.width(55),
            decoration: BoxDecoration(
              color: gradientEndColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: FittedBox(
                child: Image.asset(
                  fit: BoxFit.contain,
                  'assets/icons/user.png',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      controller.userName.value,
                      style: const TextStyle(
                          fontFamily: 'TITR',
                          fontSize: 20,
                          color: strokeGradientStartColor),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      controller.email.value,
                      style: const TextStyle(
                          fontFamily: 'SF MADA',
                          fontSize: 16,
                          color: strokeGradientStartColor),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            children: [
              const Text(
                'النقاط',
                style: TextStyle(
                    fontFamily: 'SF MADA',
                    fontSize: 16,
                    color: strokeGradientStartColor),
              ),
              Text(
                controller.points.value.toString(),
                style: const TextStyle(
                    fontFamily: 'SF MADA',
                    fontSize: 16,
                    color: strokeGradientStartColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
