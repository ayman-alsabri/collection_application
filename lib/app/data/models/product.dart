const _productId = 'id';
const _name = 'foodName';
const _caloriesPer100g = 'caloriesPer100g';
const _protinePer100g = 'protine';
const _carbPer100g = 'carb';
const _fatPer100g = 'fat';
const _foodCategory = 'category';
const _barcode = 'barCode';
const _weightInGram = 'weight';
const _isMine = 'isMine';

class Product {
  final int id;
  final String name;
  final String? category;
  final bool isMine;
  String barCode;
  int weightInGram;
  int caloriePer100g;
  int protine;
  int carbs;
  int fat;

  Product({
    required this.id,
    required this.name,
    required this.caloriePer100g,
    required this.weightInGram,
    required this.barCode,
    required this.protine,
    required this.carbs,
    required this.fat,
    this.isMine = true,
    this.category,
  });

  Product.fromJson(Map<String, dynamic> product)
      : id = product[_productId],
        name = product[_name],
        caloriePer100g = product[_caloriesPer100g],
        isMine = product[_isMine],
        protine = product[_protinePer100g],
        fat = product[_fatPer100g],
        carbs = product[_carbPer100g],
        category = product[_foodCategory],
        barCode = product[_barcode],
        weightInGram = product[_weightInGram];
}
