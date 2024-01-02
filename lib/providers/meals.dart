import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:calorie_diary/providers/meal.dart';
import 'package:calorie_diary/providers/products.dart';
import 'package:flutter/material.dart';

class Meals with ChangeNotifier {
  List<Meal> _itemsMeals = [
    Meal(
      mealDate: DateTime.now(),
      mealType: MealType.breakfast,
      items: [
        UserProduct(
          weightProduct: 200,
          product: Product(
              id: 'p1',
              name: 'Гречка',
              description: 'Описание гречки',
              kcal: 333,
              protein: 12,
              carbohydrate: 35,
              fat: 2),
        ),
        UserProduct(
          weightProduct: 200,
          product: Product(
              id: 'p2',
              name: 'Рис',
              description: 'Описание риса',
              kcal: 360,
              protein: 16,
              carbohydrate: 50,
              fat: 5),
        ),
      ],
    ),
    Meal(
      mealDate: DateTime.now(),
      mealType: MealType.dinner,
      items: [
        UserProduct(
          weightProduct: 300,
          product: Product(
              id: 'p1',
              name: 'Гречка',
              description: 'Описание гречки',
              kcal: 333,
              protein: 12,
              carbohydrate: 35,
              fat: 2),
        ),
        UserProduct(
          weightProduct: 300,
          product: Product(
              id: 'p2',
              name: 'Рис',
              description: 'Описание риса',
              kcal: 360,
              protein: 16,
              carbohydrate: 50,
              fat: 5),
        ),
      ],
    ),
  ];

  List<Meal> get itemsMeals {
    return [..._itemsMeals];
  }

  Meal findByDateAndType(DateTime date, MealType type) {
    return _itemsMeals.firstWhere(
        (element) => element.mealDate == date && element.mealType == type);
  }

  Future<void> addMeal(Meal meal) async {
    final url = Uri.parse(
        'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'mealDate': meal.mealDate,
          'mealType': meal.mealType,
          'items': _itemsMeals.map((e) => e.items).toList(),
//          Список UserProduct наверное через провайдер,
        }),
      );
      final newMeal = Meal(
        mealDate: json.decode(response.body)['mealDate'],
        mealType: json.decode(response.body)['mealType'],
        items: _itemsMeals.map((e) => e.items) as List<UserProduct>,
      );
      _itemsMeals.add(newMeal);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
