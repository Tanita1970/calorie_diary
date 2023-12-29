import 'package:calorie_diary/clients/calorizator_client_impl.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final int kcal;
  final int protein;
  final int carbohydrate;
  final int fat;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.kcal,
    required this.protein,
    required this.carbohydrate,
    required this.fat,});

  factory Product.fromCalorizator(CalorizatorFoodData calorizatorFoodData) {
    return Product(id: calorizatorFoodData.name!,
        name: calorizatorFoodData.name!,
        description: calorizatorFoodData.description,
        kcal: calorizatorFoodData.kcal.round(),
        protein: calorizatorFoodData.protein.round(),
        carbohydrate: calorizatorFoodData.carbohydrate.round(),
        fat: calorizatorFoodData.fat.round()
    );
  }

  factory Product.fromShortCalorizator(CalorizatorShortFoodData calorizatorFoodData) {
    return Product(id: calorizatorFoodData.name!,
        name: calorizatorFoodData.name!,
        description: "",
        kcal: calorizatorFoodData.kcal.round(),
        protein: 0,
        carbohydrate: 0,
        fat: 0
    );
  }
}

class UserProduct with ChangeNotifier {
  int weightProduct;
  final Product product;

  UserProduct({
    required this.weightProduct,
    required this.product,
  });

  double get totalCalories {
    return (product.kcal * weightProduct) / 100.0;
  }

  double get totalProtein {
    return (product.protein * weightProduct) / 100.0;
  }

  double get totalCarbohydrate {
    return (product.carbohydrate * weightProduct) / 100.0;
  }

  double get totalFat {
    return (product.fat * weightProduct) / 100.0;
  }

  set weight(int newWeight) {
    weightProduct = newWeight;
    // вызываем notifyListeners при изменении веса
    notifyListeners();
  }
}

