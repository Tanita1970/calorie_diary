import 'package:flutter/material.dart';

class SummaryInfoWinget extends StatefulWidget {
  @override
  State<SummaryInfoWinget> createState() => _SummaryInfoWingetState();
}

class _SummaryInfoWingetState extends State<SummaryInfoWinget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CustomColumnWidget(
            title: 'КАЛОРИИ',
            text: 'всего/тек./ост.',
            number1: 1200,
            number2: 1200,
            number3: 1200,
            isdouble: false,
          ),
          CustomColumnWidget(
            title: 'Б/Ж/У',
            text: 'белки/жиры/углев',
            number1: 120,
            number2: 120,
            number3: 120,
            isdouble: false,
          ),
          CustomColumnWidget(
            title: 'ВЕС',
            text: 'тек./пред./разница',
            number1: 112.1,
            number2: 112.5,
            number3: -0.4,
            isdouble: true,
          ),
        ],
      ),
    );
  }
}

class CustomColumnWidget extends StatelessWidget {
  final String title;
  final String text;
  final double number1;
  final double number2;
  final double number3;
  final bool isdouble;

  const CustomColumnWidget({
    required this.title,
    required this.text,
    required this.number1,
    required this.number2,
    required this.number3,
    required this.isdouble,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(4),
        width: 130,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 0.8,
              height: 2,
              indent: 10,
              endIndent: 10,
            ),
            isdouble
                ? Text(
                    '$number1/$number2/$number3',
                  )
                : Text(
                    '${number1.toInt()}/${number2.toInt()}/${number3.toInt()}',
                  )
          ],
        ),
      ),
    );
  }
}
