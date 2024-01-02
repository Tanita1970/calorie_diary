import 'dart:convert';
import 'package:calorie_diary/providers/meal.dart';
import 'package:http/http.dart' as http;
import 'package:calorie_diary/providers/products.dart';

class MealRepository {

  /// Сохраняет приём пищи в firebase
  Future<void> save(Meal meal) async {
    final url = Uri.parse('https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json');
    var response = await http.post(
      url,
      body: json.encode({
        // 'date': meal.mealDate.toString(),
        'date': meal.mealDate.toIso8601String(),
        'type': meal.mealType.toString(),
        'items': meal.items.map((item) => item.toJson()).toList(),
      }),
      // headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save meal');
    }
  }

  /// Достаёт приём пищи из firebase за указанную дату и тип приёма пищи
  /// Если такого приёма пищи не оказалось - создаёт его
  Future<Meal> get(DateTime mealDate, MealType mealType) async {
    var url = Uri.parse('https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json');
    // var url = Uri.parse('https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals.json?date=${mealDate
    //     .toIso8601String()}&type=${mealType.toString()}');
    print("url -- " + url.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("test: " + response.body);
      var data = json.decode(response.body);
      var itemList = data['items'];
      var items = itemList.map((item) => UserProduct.fromJson(item)).toList();
      return Meal(mealDate: mealDate, mealType: mealType, items: items);
    } else {
      throw Exception('МОЁ СООБЩЕНИЕ: Failed to load meal');
    }
  }

  Future<void> update(Meal meal) async {
    var url = Uri.parse('https://calorie-diary-cd02d-default-rtdb.firebaseio.com/meals');
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



