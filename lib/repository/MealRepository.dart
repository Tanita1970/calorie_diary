import 'dart:convert';
import 'package:calorie_diary/providers/meal.dart';
import 'package:calorie_diary/providers/products.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MealRepository {
  final String _fbUrl =
      'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/';

  /// Сохраняет приём пищи в firebase
  void save(Meal meal) {
    // Сохранить meal в firebase
  }

  /// Достаёт приём пищи из firebase за указанную дату и тип приёма пищи
  /// Если такого приёма пищи не оказалось - создаёт его
  Future<Meal> get(DateTime mealDate, MealType mealType) async {
    return Meal(mealType: mealType, mealDate: mealDate);
    // Достать из firebase meal по указанной дате и типу приёма пищи
    // Если в firebase не нашлось приёма пищи - создаём его без продуктов и возвращаем
  }

  // Future<void> addProduct(UserProduct userProduct) async {
  //   final url =
  //   Uri.parse(_fbUrl);
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'weight': userProduct.weightProduct,
  //         'id': userProduct.product.id,
  //         'name': userProduct.product.name,
  //         'description': userProduct.product.description,
  //         'kcal': userProduct.product.kcal,
  //         'protein': userProduct.product.protein,
  //         'carbohydrate': userProduct.product.carbohydrate,
  //         'fat': userProduct.product.fat,
  //       }),
  //     );
  //
  //     final newProduct = Product(
  //       id: json.decode(response.body)['name'],
  //       name: userProduct.product.name,
  //       description: userProduct.product.description,
  //       kcal: userProduct.product.kcal,
  //       protein: userProduct.product.protein,
  //       carbohydrate: userProduct.product.carbohydrate,
  //       fat: userProduct.product.fat,
  //     );
  //
  //     final newUserProduct = UserProduct(
  //       weightProduct: userProduct.weightProduct,
  //       product: newProduct,
  //     );
  //
  //
  //     List<UserProduct> mealsProducts = Meal(mealDate: mealDate, mealType: mealType).items;
  //
  //     mealsProducts.add(newUserProduct);
  //     // _items.insert(0, newProduct); // Добавляет продукт в начало списка
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }
  //
  Future<Meal> get_old(DateTime mealDate, MealType mealType) async {
    final response = await http.get(
        Uri.parse('$_fbUrl/mealProducts/${_formatDate(mealDate)}.json'));
    if (response.statusCode == 200) {
      if (response.body != 'null') {
        return Meal(mealDate: mealDate, mealType: mealType);
      }
      else {
        throw Exception('Return NULL!!!  ');
      }
    } else {
      throw Exception('Failed to load: response.statusCode != 200  ');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
