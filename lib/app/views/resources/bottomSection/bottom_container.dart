import 'package:collection_application/app/views/resources/bottomSection/resorse_tile.dart';
import 'package:collection_application/app/views/resources/bottomSection/resourse_class.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  static const _resosurces = <Resourse>[
    Resourse(
        name: 'myfitnessPal',
        link:
            'https://play.google.com/store/apps/details?id=com.myfitnesspal.android',
        description: 'تطبيق لحساب القيم الغذائية للعديد من الأكل'),
    Resourse(
        name: 'EDAMAM Recipe',
        link: 'https://developer.edamam.com/recipe-demo',
        description: 'موقع لحساب القيم الغذائية للعديد من الوجبات'),
    Resourse(
        name: 'Open Food Facts',
        link: 'https://world.openfoodfacts.org/',
        description:
            'موقع لحساب القيم الغذائية للعديد من المنتجات مع الباركود الخاص بها'),
    Resourse(
        name: 'Wikipidia List Of Food',
        link: 'https://developer.edamam.com/edamam-nutrition-api-demo',
        description: 'قائمة بأكثر الطعام شهرة من ويكيبيديا (English)'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: shadowColor),
        BoxShadow(
            color: bottomGradientStartColor,
            offset: Offset(0, 6),
            blurRadius: 4,
            spreadRadius: 2),
      ]),
      child: ListView.builder(
        itemCount: _resosurces.length,
        itemBuilder: (context, index) =>
            ResourceTile(resourse: _resosurces[index]),
      ),
    );
  }
}
