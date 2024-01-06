import 'package:calorie_diary/providers/products.dart';
import 'package:calorie_diary/repository/MealRepository.dart';
import 'package:flutter/material.dart';

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
}

// String get mealTypeTitle {
//   switch (type) {
//     case MealType.breakfast: return 'Завтрак';
//     case MealType.lunch: return 'Обед';
//     case MealType.dinner: return 'Ужин';
//     case MealType.snack: return 'Перекус';
//     default: return 'Неопознанный приём пищи';
//   }
// }

class Meal with ChangeNotifier {
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
}
