import 'dart:convert';

import 'package:calorie_diary/providers/products.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
}

class Meal with ChangeNotifier {
  final DateTime mealDate;
  final MealType mealType;
  final List<UserProduct> _items = [];

  Meal({
    required this.mealDate,
    required this.mealType,
  });

  List<UserProduct> get items {
    return [..._items];
  }

  Future<void> addProduct(UserProduct userProduct) async {
    _items.add(userProduct);
    // _items.insert(0, newProduct); // Добавляет продукт в начало списка
    notifyListeners();
  }
}
