import 'package:collection_application/app/data/models/food.dart';

const _barcode = 'barCode';

final class Product extends Food {
  String barCode;

  Product({
    required super.id,
    required super.name,
    required super.caloriePer100g,
    required super.protine,
    required super.carbs,
    required super.fat,
    required super.units,
    super.isMine = true,
    super.category,
    required this.barCode,
  });

  Product.fromJson(super.food, super.units, String barCode)
      : barCode = _barcode,
        super.fromJson();

  Product.fromFood(super.food, String barcode)
      : barCode = barcode,
        super.fromFood();
}
