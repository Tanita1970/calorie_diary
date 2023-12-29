import 'package:calorie_diary/providers/meal.dart';
import 'package:calorie_diary/repository/MealRepository.dart';
import 'package:calorie_diary/widgets/meal_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyDietScreen extends StatefulWidget {
  @override
  State<DailyDietScreen> createState() => _DailyDietScreenState();
}

class _DailyDietScreenState extends State<DailyDietScreen> {
  // var _expanded = false;

  @override
  Widget build(BuildContext context) {
    var mealRepository = Provider.of<MealRepository>(context);
    final DateTime mealDate = DateTime.now();
    return Column(
      children: [
        Provider(
            create: (ctx) {
              return mealRepository.get(mealDate, MealType.breakfast);
            },
            child: MealWidget(MealType.breakfast)),
        Provider(
            create: (ctx) {
              return mealRepository.get(mealDate, MealType.lunch);
            },
            child: MealWidget(MealType.lunch)),
        Provider(
            create: (ctx) {
              return mealRepository.get(mealDate, MealType.dinner);
            },
            child: MealWidget(MealType.dinner)),
        Provider(
            create: (ctx) {
              return mealRepository.get(mealDate, MealType.snack);
            },
            child: MealWidget(MealType.snack)),
      ],
    );
  }
}
