import 'package:calorie_diary/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дневник калорий'),
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const AppDrawer(),
      body: Text('kggjj'),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.cyan,
        // unselectedItemColor: Colors.white,
        // selectedItemColor: Colors.orangeAccent,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
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
            label: 'Тренировки',
          ),
        ],
        // selectedItemColor: Colors.amber[800],
        // unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
