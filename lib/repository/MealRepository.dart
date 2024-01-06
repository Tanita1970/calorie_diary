import 'dart:convert';
import 'package:calorie_diary/providers/meal.dart';
import 'package:calorie_diary/providers/meals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:calorie_diary/providers/products.dart';

class MealRepository {
  /// Сохраняет приём пищи в firebase
  Future<void> save(Meal meal) async {
    final url = Uri.parse(
        'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json');
    print({
      // 'date': meal.mealDate.toString(),
      'date': meal.mealDate.toIso8601String(),
      'type': meal.mealType.toString(),
      'items': meal.items.map((item) => item.toJson()).toList(),
    });
    var response = await http.post(
      url,
      body: json.encode({
        // 'date': meal.mealDate.toString(),
        // 'date': '2024-1-2',
        'date': _formatDate(meal.mealDate),
        'type': meal.mealType.toString(),
        'items': meal.items.map((item) => item.toJson()).toList(),
      }),
      // headers: {'Content-Type': 'application/json'},
    );
    print(response.toString());
    if (response.statusCode != 200) {
      throw Exception('Failed to save meal');
    }
  }

  /// Достаёт приём пищи из firebase за указанную дату и тип приёма пищи
  /// Если такого приёма пищи не оказалось - создаёт его
  Future<Meal> get(DateTime mealDate, MealType mealType) async {
    try {
      var url = Uri.parse(
          'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json'
          '?orderBy="date"'
          '&equalTo="${_formatDate(mealDate)}"'
          '&orderBy="type"'
          '&equalTo="${mealType.toString()}"');

      print("url -- " + url.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("test: " + response.body);

        // if (response.body != 'null' && response.body.isNotEmpty) {
        var res = json.decode(response.body);
        print(res);
        if (res.toString() != '{}') {
          var data = json.decode(response.body);
          var itemList = data.values.toList()[0]["items"];
          var items =
              itemList.map((item) => UserProduct.fromJson(item)).toList();
          List<UserProduct> userProductItems = [];
          for (var item in items) {
            userProductItems.add(item);
          }
          return Meal(
              mealDate: mealDate, mealType: mealType, items: userProductItems);
        } else {
          List<UserProduct> userProductItems = [
            UserProduct(
              weightProduct: 0,
              product: Product(
                  id: '',
                  name: '',
                  description: '',
                  kcal: 0,
                  protein: 0,
                  carbohydrate: 0,
                  fat: 0),
            )
          ];
          final meal = Meal(
              mealDate: mealDate, mealType: mealType, items: userProductItems);
          MealRepository().save(meal);
          return meal;
        }
      } else {
        throw Exception(
            'МОЁ СООБЩЕНИЕ: Failed to load meal / Failed to save meal');
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      throw Exception('МОЁ СООБЩЕНИЕ ВТОРОЕ: Failed to load meal');
    }
  }

  Future<void> update(Meal meal) async {
    var url = Uri.parse(
        'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json'
        '?orderBy="date"'
        '&equalTo="${_formatDate(meal.mealDate)}"'
        '&orderBy="type"'
        '&equalTo="${meal.mealType.toString()}"');
    // var url = Uri.parse(
    //     'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals/${meal.mealDate.toIso8601String()}');
    var response = await http.post(
      url,
      body: json.encode({
        'type': meal.mealType.toString(),
        'items': meal.items.map((item) => item.toJson()).toList(),
      }),
      // headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update meal');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}

// Future<Meal> get_old(DateTime mealDate, MealType mealType) async {
//   final response = await http
//       .get(Uri.parse('$_fbUrl/mealProducts/${_formatDate(mealDate)}.json'));
//   if (response.statusCode == 200) {
//     if (response.body != 'null') {
//       return Meal(mealDate: mealDate, mealType: mealType);
//     } else {
//       throw Exception('Return NULL!!!  ');
//     }
//   } else {
//     throw Exception('Failed to load: response.statusCode != 200  ');
//   }
// }
