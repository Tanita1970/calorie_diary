import 'package:calorie_diary/providers/products.dart';
import 'package:calorie_diary/repository/MealRepository.dart';
import 'package:flutter/material.dart';

enum MealType {
  breakfast("Завтрак"),
  lunch("Обед"),
  dinner("Ужин"),
  snack("Перекус");

  final String russianName;

  const MealType(this.russianName);

  static MealType parse(String type) {
    return values.firstWhere(
          (mealType) => mealType.toString() == type,
    );
  }
}

class Meal with ChangeNotifier {
  String? id;
  final DateTime mealDate;
  final MealType mealType;
  final List<UserProduct> _items = List.empty(growable: true);

  Meal({
    required this.mealDate,
    required this.mealType,
    required List<UserProduct> items,
  }) {
    _items.addAll(items);
  }

  List<UserProduct> get items {
    return [..._items];
  }

  Future<void> addUserProduct(UserProduct userProduct) async {
    _items.add(userProduct);
    // _items.insert(0, newProduct); // Добавляет продукт в начало списка
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'mealDate': mealDate.toString(),
      // 'mealDate': mealDate.toIso8601String(),
      'mealType': mealType.toString(),
      'items': _items.map((item) => item.toJson()).toList(),
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    final mealDate = DateTime.parse(json['date']);
    final mealType = MealType.parse(json['type']);

    List<UserProduct> items = [];
    if (json['items'] != null) {
      var jsonItems = json['items'] as List<dynamic>;
      for (var element in jsonItems) {
        var mealMap = element as Map<String, dynamic>;
        items.add(UserProduct.fromJson(mealMap));
      }
    }
    return Meal(
      mealDate: mealDate,
      mealType: mealType,
      items: items,
    );
  }
}
