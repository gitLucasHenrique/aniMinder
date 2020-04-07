import 'dart:math';

import 'package:flutter/material.dart';

class AnimeBackground extends StatelessWidget {
  final List<IconData> iconData = <IconData>[
    Icons.call,
    Icons.school,
    Icons.explore,
    Icons.extension,
    Icons.fastfood,
    Icons.feedback,
    Icons.filter_b_and_w,
    Icons.filter_drama,
    Icons.filter_vintage,
    Icons.fitness_center,
    Icons.format_paint,
    Icons.free_breakfast,
    Icons.grade,
    Icons.group_work,
    Icons.hdr_strong,
    Icons.hot_tub,
    Icons.insert_emoticon,
  ];
  final List<double> iconSizes = [20, 40, 40, 40, 60, 60];
  final Random r = Random();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _linhaOdd(r, iconData, iconSizes),
        ),
        Expanded(
          flex: 1,
          child: _linhaEven(r, iconData, iconSizes),
        ),
        Expanded(
          flex: 1,
          child: _linhaEven(r, iconData, iconSizes),
        ),
        Expanded(
          flex: 1,
          child: _linhaOdd(r, iconData, iconSizes),
        ),
        Expanded(
          flex: 1,
          child: _linhaOdd(r, iconData, iconSizes),
        ),
        Expanded(
          flex: 1,
          child: _linhaEven(r, iconData, iconSizes),
        ),
        Expanded(
          flex: 1,
          child: _linhaEven(r, iconData, iconSizes),
        ),
      ],
    );
  }
}

_linhaEven(r, iconData, iconSizes) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
    ],
  );
}

_linhaOdd(r, iconData, iconSizes) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: RotatedBox(
          quarterTurns: r.nextInt(3),
          child: Icon(
            iconData[r.nextInt(iconData.length)],
            color: Colors.grey[300],
            size: iconSizes[r.nextInt(iconSizes.length)],
          ),
        ),
      ),
    ],
  );
}
