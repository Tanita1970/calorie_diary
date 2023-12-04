import 'package:calorie_diary/screens/daily_diet_screen.dart';
import 'package:calorie_diary/screens/fitness_screen.dart';
import 'package:calorie_diary/screens/main_screen.dart';
import 'package:calorie_diary/screens/other_screen.dart';
import 'package:calorie_diary/screens/recipe_screen.dart';
import 'package:calorie_diary/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  final List<Map<String, Object>> _screens = [
    {'screen': MainScreen(), 'title': 'Главная'},
    {'screen': DailyDietScreen(), 'title': 'Рацион дня'},
    {'screen': RecipeScreen(), 'title': 'Рецепты'},
    {'screen': FitnessScreen(), 'title': 'Фитнес'},
    {'screen': OtherScreen(), 'title': 'Дополнительно'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex] as String),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: (index) {
          setState(() {
            _selectedScreenIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.cyan,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[500],
        selectedFontSize: 15,
        // showUnselectedLabels: true,
        // unselectedFontSize: 12,
        // iconSize: 30,
        // showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.event_note_outlined),
            label: 'Рацион дня',
          ),
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.fastfood),
            label: 'Рецепты',
          ),
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.fitness_center),
            label: 'Фитнес',
          ),
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.more_vert),
            label: 'Ещё',
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: IndexedStack(
        index: _selectedScreenIndex,
        children: _screens,
      ),
    );
  }
}
