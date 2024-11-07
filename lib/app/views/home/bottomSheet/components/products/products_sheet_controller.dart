import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/globalControllers/dataController/data_controller.dart';
import 'package:collection_application/custom/dialog/waiting_dialog.dart';
import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
import 'package:get/get.dart';

class ProductsSheetController extends GetxController {
  final DataController _dataController = Get.find();

  final productName = ''.obs;
  String _caloriesPer100g = '';
  String _protinePer100g = '';
  String _carbPer100g = '';
  String _fatPer100g = '';
  String _notes = '';

  String _barcode = '';
  String _weightInGram = '';

  final currentFormIndex = 0.obs;

  Future submit() async {
    if ([_barcode, _weightInGram].any(
      (element) => element.isEmpty,
    )) {
      showCustomSnackBar('خطأ', 'يرجى تعبئة البيانات كاملةً');
      return;
    }
    WaitingDialog.show();
    final successful = await _dataController.addProduct(Product(
        id: 0,
        name: productName.value,
        caloriePer100g: int.parse(_caloriesPer100g),
        barCode: _barcode,
        protine: double.parse(_protinePer100g),
        carbs: double.parse(_carbPer100g),
        fat: double.parse(_fatPer100g),
        category: _notes,
        isMine: true,
        units: [
          Unit(id: 0, name: 'وحدة', weight: double.parse(_weightInGram))
        ]));
    WaitingDialog.hide();
    //TODO: handle error with custom error class
    if (!successful) {
      showCustomSnackBar('لا يوجد اتصال بالانترنت',
          "الرجاء الاتصال بالانترنت والمحاولة لاحقاَ");
      return;
    }

    Get.back();
  }

  void setNutritionalValues({
    String? calories,
    String? carb,
    String? fat,
    String? name,
    String? protine,
    String? notes,
  }) {
    productName.value = name?.trim() ?? productName.value;
    _caloriesPer100g = calories?.trim() ?? _caloriesPer100g;
    _protinePer100g = protine?.trim() ?? _protinePer100g;
    _carbPer100g = carb?.trim() ?? _carbPer100g;
    _fatPer100g = fat?.trim() ?? _fatPer100g;
    _notes = notes?.trim() ?? _notes;
  }

  void setBarcodeValues({String? barCode, String? weight}) {
    _barcode = barCode?.trim() ?? _barcode;
    _weightInGram = weight?.trim() ?? _weightInGram;
  }

  Future<void> onTap(int index) async {
    if (index == currentFormIndex.value) return;

    try {
      if (index == 1) {
        await _toSecondSection();
        return;
      }

      await _toFirstSection();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _toSecondSection() async {
    final nutritionalValues = [
      _caloriesPer100g,
      _protinePer100g,
      _carbPer100g,
      _fatPer100g
    ];

    if (productName.value.isEmpty) {
      await showCustomSnackBar('خطأ', 'يرجى كتابة اسم المنتج أولا');
      throw Error();
    }
    if (nutritionalValues.any(
      (element) => element.isEmpty,
    )) {
      await showCustomSnackBar('خطأ', 'يرجى كتابة القيم الغذائية كاملةً');
      throw Error();
    }
    currentFormIndex.value = 1;
  }

  Future<void> _toFirstSection() async {
    currentFormIndex.value = 0;
  }
}
