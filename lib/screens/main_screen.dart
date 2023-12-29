import 'package:calorie_diary/widgets/summary_info_widget.dart';
import 'package:calorie_diary/widgets/tile_button_grid.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SummaryInfoWinget(),
        TileButtonGrid(),
      ],
    );
  }
}
