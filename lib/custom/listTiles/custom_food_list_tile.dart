import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/custom/button/completeButtons/add_subtract_button.dart';
import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:collection_application/custom/containers/calories_nutrition_chart.dart';
import 'package:collection_application/custom/dialog/dialog_with_confirmation_only.dart';
import 'package:collection_application/custom/listTiles/custom_drop_down_menu.dart';
import 'package:collection_application/templates/dialog/general_dialog.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFoodListTile extends StatefulWidget {
  final void Function(Food food, Unit selectedUnit, int quantity)? onTap;
  final Future<void> Function() onDeleteFood;
  final Food food;
  final bool canEdit;
  const CustomFoodListTile({
    this.onTap,
    super.key,
    required this.food,
    required this.onDeleteFood,
    this.canEdit = false,
  });

  @override
  State<CustomFoodListTile> createState() => _CustomFoodListTileState();
}

class _CustomFoodListTileState extends State<CustomFoodListTile> {
  late Unit _tappedUnit = widget.food.units.first;
  int _quantity = 1;

  void _onTap() async {
    if (widget.onTap != null) {
      widget.onTap!(widget.food, _tappedUnit, _quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CaloriesNutritionChart(
                  usedUnit: _tappedUnit,
                  quantity: _quantity,
                  food: widget.food,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 8.0),
                              child: FittedBox(
                                  alignment: const Alignment(1, 0),
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    widget.food.name,
                                    style: TextStyle(
                                        height: 1,
                                        fontFamily: 'TITR',
                                        fontSize: Responsive.width(30)),
                                  )),
                            ),
                          ),
                          // const Expanded(child: SizedBox()),
                          if (widget.canEdit)
                            PrimaryBlueButton(
                              shadows: const [],
                              height: 35,
                              width: 90,
                              text: 'حذف',
                              onPressed: () {
                                Get.generalDialog(
                                    transitionBuilder:
                                        GeneralDialog.transitionBuilder,
                                    transitionDuration:
                                        GeneralDialog.transitionDuration,
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return DialogWithConfirmationOnly(
                                          title: 'هل تريد الحذف بالفعل',
                                          subtitle: widget.food.name,
                                          cancelText: 'الغاء',
                                          confirmText: "نعم",
                                          onCanceled: () async => Get.back(),
                                          onConfirmed: () async {
                                            await widget.onDeleteFood();
                                            Get.back();
                                          });
                                    });
                              },
                            )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.food.category ?? '',
                        style: TextStyle(
                            height: 1,
                            color: bluegradientStartColor,
                            overflow: TextOverflow.fade,
                            fontFamily: 'SF MADA',
                            fontSize: Responsive.width(20)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            flex: 6,
                            child: AddSubtractButtons(
                              onChanged: (number) => setState(() {
                                _quantity = number;
                              }),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            fit: FlexFit.loose,
                            flex: 5,
                            child: CustomDropDownMenu(
                              onTap: (tappedUnit) => tappedUnit != null
                                  ? setState(() {
                                      _tappedUnit = tappedUnit;
                                    })
                                  : null,
                              units: widget.food.units,
                              key: ValueKey(widget.food),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: strokeGradientStartColor.withOpacity(0.2),
              height: 0,
              thickness: 0.5,
            )
          ],
        ),
      ),
    );
  }
}
