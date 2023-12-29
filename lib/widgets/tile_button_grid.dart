import 'package:calorie_diary/widgets/tile_button_widget.dart';
import 'package:flutter/material.dart';

class TileButtonGrid extends StatefulWidget {
  @override
  State<TileButtonGrid> createState() => _TileButtonGridState();
}

class _TileButtonGridState extends State<TileButtonGrid> {
  @override
  Widget build(BuildContext context) {
    final listTiles = [
      TileButtonWidget(
        iconImage: Icons.free_breakfast,
        title: "Завтрак",
        count: 1000,
        measure: 'Ккал',
      ),
      TileButtonWidget(
        iconImage: Icons.lunch_dining,
        title: "Обед",
        count: 1000,
        measure: 'Ккал',
      ),
      TileButtonWidget(
        iconImage: Icons.dinner_dining_sharp,
        title: "Ужин",
        count: 1000,
        measure: 'Ккал',
      ),
      TileButtonWidget(
        iconImage: Icons.fastfood,
        title: "Перекус",
        count: 1000,
        measure: 'Ккал',
      ),
      TileButtonWidget(
        iconImage: Icons.local_drink,
        title: "Вода",
        count: 1000,
        measure: 'мл',
      ),
      TileButtonWidget(
        iconImage: Icons.snowshoeing,
        title: "Шаги",
        count: 35000,
        measure: 'шагов',
      ),
      TileButtonWidget(
        iconImage: Icons.scale,
        title: "Вес",
        count: 110,
        measure: 'кг',
      ),
      TileButtonWidget(
        iconImage: Icons.add_circle_outline,
        title: 'Добавить',
        count: 1,
        measure: 'плитку',
      ),

    ];

    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 3,
        children: listTiles,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text('Пример виджета'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: InformationsTilesGrid(),
//         ),
//       ),
//     ),
//   ));
// }