import 'package:calorie_diary/clients/calorizator_client_impl.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double kcal;
  final double protein;
  final double carbohydrate;
  final double fat;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.kcal,
    required this.protein,
    required this.carbohydrate,
    required this.fat,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'kcal': kcal,
      'protein': protein,
      'carbohydrate': carbohydrate,
      'fat': fat,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      kcal: json['kcal'],
      protein: json['protein'],
      carbohydrate: json['carbohydrate'],
      fat: json['fat'],
    );
  }

  factory Product.fromCalorizator(CalorizatorFoodData calorizatorFoodData) {
    return Product(
      id: calorizatorFoodData.name!,
      name: calorizatorFoodData.name!,
      description: calorizatorFoodData.description,
      kcal: calorizatorFoodData.kcal,
      protein: calorizatorFoodData.protein,
      carbohydrate: calorizatorFoodData.carbohydrate,
      fat: calorizatorFoodData.fat,
    );
  }

  factory Product.fromShortCalorizator(CalorizatorShortFoodData calorizatorFoodData) {
    return Product(
        id: calorizatorFoodData.name!,
        name: calorizatorFoodData.name!,
        description: "",
        kcal: calorizatorFoodData.kcal,
        protein: 0,
        carbohydrate: 0,
        fat: 0);
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
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'weightProduct': weightProduct,
      'product': product.toJson(),
    };
  }

  factory UserProduct.fromJson(Map<String, dynamic> json) {
    return UserProduct(
      weightProduct: json['weightProduct'],
      product: Product.fromJson(json['product']),
    );
  }
}
