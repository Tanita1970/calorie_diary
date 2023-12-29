import 'package:flutter/material.dart';

class TileButtonWidget extends StatelessWidget {
  final IconData iconImage;
  final String title;
  final int count;
  final String measure;

  const TileButtonWidget({
    required this.iconImage,
    required this.title,
    required this.count,
    required this.measure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 70,
      // height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(3, 0), // changes position of shadow
          ),
        ],
      ),
      // padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(4),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconImage, size: 40,),
            // SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(count.toString()), // Здесь число
                SizedBox(width: 4),
                Text(measure), // Здесь текст
              ],
            ),
          ],
        ),
      ),
    );
  }
}


