import 'dart:convert';

import 'package:calorie_diary/providers/meal.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MealRepository {
  /// Сохраняет приём пищи в firebase
  Future<Meal> save(Meal meal) async {
    if (meal.id != null) {
      return await _update(meal);
    } else {
      return await _create(meal);
    }
  }

  /// Достаёт приём пищи из firebase за указанную дату и тип приёма пищи
  /// Если такого приёма пищи не оказалось - создаёт его
  Future<Meal> get(DateTime mealDate, MealType mealType) async {
    try {
      var url = Uri.parse(
          'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json'
          '?orderBy="date"'
          '&equalTo="${_formatDate(mealDate)}"');
      var response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception(
            'МОЁ СООБЩЕНИЕ: Failed to load meal / Failed to save meal');
      }
      Map<String, dynamic> mealsByDateMap = json.decode(response.body);
      var meal = findMeal(mealsByDateMap, mealType);
      if (meal != null) {
        return meal;
      } else {
        final meal = Meal(mealDate: mealDate, mealType: mealType, items: []);
        return await save(meal);
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      throw Exception('МОЁ СООБЩЕНИЕ ВТОРОЕ: Failed to load meal');
    }
  }

  Future<Meal> _update(Meal meal) async {
    final url = Uri.parse(
        'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals/${meal.id}.json');
    await http.patch(
      url,
      body: json.encode({
        'date': _formatDate(meal.mealDate),
        'type': meal.mealType.toString(),
        'items': meal.items.map((item) => item.toJson()).toList(),
      }),
    );

    return meal;
  }

  Future<Meal> _create(Meal meal) async {
    final url = Uri.parse(
        'https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json');
    var response = await http.post(
      url,
      body: json.encode({
        'date': _formatDate(meal.mealDate),
        'type': meal.mealType.toString(),
        'items': meal.items.map((item) => item.toJson()).toList(),
      }),
    );
    meal.id = json.decode(response.body)['name'];
    return meal;
  }

  String _formatDate(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  Meal? findMeal(Map<String, dynamic> mealsByDateMap, MealType mealType) {
    for (var entry in mealsByDateMap.entries) {
      var id = entry.key;
      var mealMap = entry.value;
      var meal = Meal.fromJson(mealMap);
      meal.id = id;
      if (meal.mealType == mealType) {
        return meal;
      }
    }

    return null;
  }
}
