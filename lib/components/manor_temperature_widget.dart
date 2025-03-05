import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ManorTemperature extends StatelessWidget {
  final double mamorTemp;

  final List<Color> temperColors = [
    Color(0xff072038),
    Color(0xff0d3a65),
    Color(0xff186ec0),
    Color(0xff37b24d),
    Color(0xffffad13),
    Color(0xfff76707),
  ];

  ManorTemperature(
      {super.key, required this.mamorTemp, required double manorTemp});

  int get level {
    if (mamorTemp <= 20) {
      return 0;
    } else if (mamorTemp < 32) {
      return 1;
    } else if (mamorTemp < 36.5) {
      return 2;
    } else if (mamorTemp < 40) {
      return 3;
    } else if (mamorTemp < 50) {
      return 4;
    } else {
      return 5;
    }
  }

  Widget _makeTempLabelAndBar() {
    double maxWidth = 60;
    double barWidth = (maxWidth / 99) * mamorTemp;
    barWidth = barWidth.clamp(0, maxWidth); // 최소 0, 최대 65로 제한

    return SizedBox(
      width: maxWidth,
      child: Column(
        children: [
          Text(
            "$mamorTemp℃",
            style: TextStyle(
              color: temperColors[level],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              height: 6,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.2),
              child: Row(
                children: [
                  Container(
                    height: 6,
                    width: barWidth,
                    decoration: BoxDecoration(
                      color: temperColors[level], // 레벨별 색상 적용
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _makeTempLabelAndBar(),
            Container(
              margin: const EdgeInsets.only(left: 7),
              width: 30,
              height: 30,
              child: Image.asset("assets/images/level-$level.jpg"),
            )
          ],
        ),
        Text(
          "매너온도",
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 12,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
