import 'dart:convert';
import 'package:http/http.dart' as http;

class CalorizatorClientImpl {
  static const String GET_PRODUCTS = "https://calorizator.ru/widgets/c_ac.php";
  static const String GET_PRODUCT = "https://calorizator.ru/widgets/c_ap.php";

  @override
  Future<List<CalorizatorShortFoodData>> searchProducts(String search) async {
    var response =
    await http.post(Uri.parse(GET_PRODUCTS), body: {'value': search});
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => CalorizatorShortFoodData.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<CalorizatorFoodData> getProduct(String productName) async {
    var response =
    await http.post(Uri.parse(GET_PRODUCT), body: {'value': productName});
    if (response.statusCode == 200) {
      List<CalorizatorFoodData> listData = (json.decode(response.body) as List)
          .map((i) => CalorizatorFoodData.fromJson(i))
          .toList();
      if (listData.length != 1 || listData[0] == null) {
        throw Exception('Failed to load data');
      }

      listData[0].name = productName;

      return listData[0];
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class CalorizatorShortFoodData {
  late String name;
  late double kcal;

  CalorizatorShortFoodData({required this.name, required this.kcal});

  CalorizatorShortFoodData.fromJson(Map<String, dynamic> json) {
    name = json['v'];
    kcal = double.parse(json['d']);
  }

  Map<String, dynamic> toJson() => {
    'v': name,
    'd': kcal,
  };

  @override
  String toString() {
    return 'CalorizatorShortFoodData{name: $name, kcal: $kcal}';
  }
}

class CalorizatorFoodData {
  late String description;
  late double kcal;
  late double protein;
  late double carbohydrate;
  late double fat;
  String? name;

  CalorizatorFoodData(
      {required this.description,
        required this.kcal,
        required this.protein,
        required this.carbohydrate,
        required this.fat,
        this.name});

  CalorizatorFoodData.fromJson(Map<String, dynamic> json) {
    description = json['m'];
    kcal = double.parse(json['k']);
    protein = double.parse(json['p']);
    carbohydrate = double.parse(json['c']);
    fat = double.parse(json['f']);
  }

  Map<String, dynamic> toJson() => {
    'm': description,
    'k': kcal,
    'p': protein,
    'c': carbohydrate,
    'f': fat,
  };

  @override
  String toString() {
    return 'CalorizatorFoodData{'
        'description: $description, '
        'kcal: $kcal, '
        'protein: $protein, '
        'carbohydrate: $carbohydrate, '
        'fat: $fat, '
        'name: $name}';
  }
}
