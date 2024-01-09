import 'package:calorie_diary/repository/MealRepository.dart';
import 'package:calorie_diary/screens/search_food_screen.dart';
import 'package:calorie_diary/screens/tabs_screen.dart';
import 'package:calorie_diary/widgets/meal_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (ctx) => SearchFoodScreen()),
        Provider(create: (ctx) => MealRepository()),
      ],
      child: MaterialApp(
          title: 'Calorie diary',
          home: TabsScreen(),
          initialRoute: '/',
          routes: {
            SearchFoodScreen.routeName: (ctx) => SearchFoodScreen(),
            // MealWidget.routeName: (context) => MealWidget('mealName'),
          }),
    );
  }
}
