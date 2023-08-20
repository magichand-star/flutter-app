import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import '../../backend/schema/generated_emblems.dart';
import 'emblem_widget.dart';

class ArmsOfCoatWidget extends StatelessWidget {
  final List<GeneratedEmblems?> emblems;
  final EmblemType emblemType;
  final double height;
  final double width;

  ArmsOfCoatWidget({
    required this.emblems,
    required this.emblemType,
    this.height = 200, // Default height
    this.width = 150, // Default width
  });

  int get _rows {
    switch (emblemType) {
      case EmblemType.single:
      case EmblemType.two_horizontal:
      case EmblemType.diagonal_left:
      case EmblemType.diagonal_right:
        return 1;
      case EmblemType.two_vertical:
      case EmblemType.three_up:
      case EmblemType.three_down:
      case EmblemType.three_left:
      case EmblemType.three_right:
        return 2;
      case EmblemType.four:
        return 2;
    }
  }

  int get _columns {
    switch (emblemType) {
      case EmblemType.single:
      case EmblemType.two_vertical:
      case EmblemType.three_up:
      case EmblemType.three_down:
        return 1;
      case EmblemType.two_horizontal:
      case EmblemType.three_left:
      case EmblemType.three_right:
      case EmblemType.diagonal_left:
      case EmblemType.diagonal_right:
      case EmblemType.four:
        return 2;
    }
  }

  int _determineCrossAxisCount(EmblemType emblemType) {
    switch (emblemType) {
      case EmblemType.four:
      case EmblemType.diagonal_right:
      case EmblemType.diagonal_left:
        return 2;
      case EmblemType.two_horizontal:
      case EmblemType.three_up:
      case EmblemType.three_down:
      case EmblemType.three_left:
      case EmblemType.three_right:
        return 2;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final double emblemSize = 0.35 * height; // 35% of the height

    double squareSide =
        (height * 0.9) / 2; // Assuming EmblemType.four as default
    if (emblemType == EmblemType.two_vertical) {
      squareSide = height * 0.9;
    } else if (emblemType == EmblemType.two_horizontal) {
      squareSide = width / 2;
    }

    // Bezier curve logic
    double emblemWidth = width;
    // double emblemHeight = height;
    const double tailHeightRatio = 0.05; // Updated to 5%
    double emblemHeightWithoutTail = height * (1 - tailHeightRatio);
    double tailHeight = emblemHeightWithoutTail * tailHeightRatio;
    double totalHeight = emblemHeightWithoutTail + tailHeight;

    List<ThirdOrderBezierCurveSection> curvesList = [
      ThirdOrderBezierCurveSection(
        p1: Offset(0, totalHeight - .3 * totalHeight),
        p2: Offset(0, totalHeight),
        p3: Offset(emblemWidth / 2, totalHeight - .3 * totalHeight),
        p4: Offset(emblemWidth / 2, totalHeight - totalHeight * .05),
        smooth: .1,
      ),
      ThirdOrderBezierCurveSection(
        p1: Offset(emblemWidth / 2, totalHeight),
        p2: Offset(emblemWidth / 2, totalHeight - .3 * totalHeight),
        p3: Offset(emblemWidth, totalHeight),
        p4: Offset(
            emblemWidth, totalHeight - .3 * totalHeight - totalHeight * .05),
        smooth: .1,
      ),
    ];

    final emblemSize = width / _columns;

    return Container(
      width: width,
      height: height,
      child: ClipPath(
        clipper: ProsteThirdOrderBezierCurve(
          position: ClipPosition.bottom,
          list: curvesList,
        ),
        child: Stack(
          children: emblems.asMap().entries.map((entry) {
            final index = entry.key;
            final emblem = entry.value;

            final row = (index / _columns).floor();
            final column = index % _columns;

            return Positioned(
              top: row * emblemSize,
              left: column * emblemSize,
              width: emblemSize,
              height: emblemSize,
              child: Container(
                color: fromCssColor(emblem?.backgroundColor ?? '#FFFFFF'),
                child: emblem?.filled ?? false
                    ? Image.network(emblem!.emblem!, fit: BoxFit.fill)
                    : Center(child: Image.network(emblem!.emblem!)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
