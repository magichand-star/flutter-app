import 'package:flutter/widgets.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../../backend/backend.dart';
import '../../core/app_export.dart';

enum EmblemType {
  four,
  two_vertical,
  two_horizontal,
  three_down,
  three_up,
  three_left,
  three_right,
  diagonal_right,
  diagonal_left,
  single,
}

EmblemType stringToEmblemType(String? typeString) {
  // debugger();
  if (typeString == null) return EmblemType.four;
  EmblemType emblemType =
      EmblemType.values.firstWhere((e) => e.toString() == typeString);
  return emblemType;
}

class EmblemWidget extends StatelessWidget {
  const EmblemWidget({
    super.key,
    this.height = 200,
    this.width = 150,
    required this.emblems,
    this.emblemType,
  });

  final double width, height;
  final List<GeneratedEmblems?> emblems;
  final EmblemType? emblemType;

  @override
  Widget build(BuildContext context) {
    switch (emblemType) {
      case EmblemType.single:
        return _buildEmblemSymbol(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: height + 20,
                width: width,
                color: fromCssColor(emblems[0]!.backgroundColor!),
              ),
              Positioned(
                height: height,
                width: width,
                top: 0,
                child: Center(
                  child: Image.network(
                    emblems[0]!.emblem ?? defaultImg1,
                    fit: BoxFit.cover,
                    width: width,
                  ),
                ),
              ),
            ],
          ),
          // Container(
          //   color: fromCssColor(emblems[0]!.backgroundColor!),
          //   height: height,
          //   child: Center(
          //     child: Image.network(
          //       emblems[0]!.emblem ?? defaultImg1,
          //       fit: BoxFit.cover,
          //       width: width,
          //     ),
          //   ),
          // ),
        );
      case EmblemType.four:
        return _buildFourTypeEmblem();
      case EmblemType.two_horizontal:
        return _buildTwoHorizontalEmblem();
      case EmblemType.two_vertical:
        return _buildTwoVerticalEmblem();
      case EmblemType.three_up:
        return _buildThreeEmblem(EmblemType.three_up);
      case EmblemType.three_down:
        return _buildThreeEmblem(EmblemType.three_down);
      case EmblemType.three_left:
        return _buildThreeEmblem(EmblemType.three_left);
      case EmblemType.three_right:
        return _buildThreeEmblem(EmblemType.three_right);
      case EmblemType.diagonal_left:
        return _buildDiagonal(EmblemType.diagonal_left);
      case EmblemType.diagonal_right:
        return _buildDiagonal(EmblemType.diagonal_right);
      default:
        return _buildFourTypeEmblem();
    }
  }

  _buildEmblemSymbol({Widget? child}) {
    double emblemWidth = getHorizontalSize(width),
        emblemHeight = getVerticalSize(height);
    // This is the ratio of the tail size to the emblem height
    const double tailHeightRatio = 0.2;

    // Calculate the height of each emblem without including the tail
    double emblemHeightWithoutTail = emblemHeight / 2;

    // Calculate the height of the tail
    double tailHeight = emblemHeightWithoutTail * tailHeightRatio;

    // The total height of the widget, including the tail
    double totalHeight = emblemHeight + tailHeight;

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

    return Container(
      width: emblemWidth,
      height: totalHeight,
      child: ClipPath(
        clipper: ProsteThirdOrderBezierCurve(
          position: ClipPosition.bottom,
          list: curvesList,
        ),
        child: child,
      ),
    );
  }

  emblemsChildren(double emblemWidth, double emblemHeight) {
    return emblems.map(
      (var emblem) {
        GeneratedEmblems currentEmblem = emblem!;
        String? defaultImage;
        if (emblems.indexOf(emblem) % 2 == 0) {
          defaultImage = defaultImg1;
        } else {
          defaultImage = defaultImg2;
        }
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          fit: StackFit.expand,
          children: [
            Positioned(
              height: emblemHeight,
              width: emblemWidth / 2,
              child: Container(
                // color: emblems!.indexOf(emblem) % 2 == 0
                //     ? Color(0xFF17991C)
                //     : Colors.red,
                color: fromCssColor(
                  currentEmblem.backgroundColor ?? '#ffffff',
                ),
              ),
            ),
            Positioned(
              height:
                  (currentEmblem.filled ?? false) ? (emblemHeight / 2) : null,
              width: (currentEmblem.filled ?? false) ? (emblemWidth / 2) : null,
              child: Image.network(
                currentEmblem.emblem ?? defaultImage,
                fit: BoxFit.fill,
              ),
            ),
          ],
        );
      },
    ).toList();
  }

  _buildFourTypeEmblem() {
    double emblemWidth = getHorizontalSize(width),
        emblemHeight = getVerticalSize(height);
    // This is the ratio of the tail size to the emblem height
    const double tailHeightRatio = 0.2;

    // Calculate the height of each emblem without including the tail
    double emblemHeightWithoutTail = emblemHeight / 2;

    // Calculate the height of the tail
    double tailHeight = emblemHeightWithoutTail * tailHeightRatio;

    // The total height of the widget, including the tail
    emblemHeight = emblemHeight + tailHeight;

    return _buildEmblemSymbol(
      child: Container(
        // height: emblemHeight,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          physics: NeverScrollableScrollPhysics(),
          children: emblemsChildren(emblemWidth, emblemHeight),
        ),
      ),
    );
  }

  _buildTwoHorizontalEmblem() {
    double emblemWidth = getHorizontalSize(width),
        emblemHeight = getVerticalSize(height);
    // This is the ratio of the tail size to the emblem height
    const double tailHeightRatio = 0.2;

    // Calculate the height of each emblem without including the tail
    double emblemHeightWithoutTail = emblemHeight / 2;

    // Calculate the height of the tail
    double tailHeight = emblemHeightWithoutTail * tailHeightRatio;

    // The total height of the widget, including the tail
    emblemHeight = emblemHeight + tailHeight;

    return _buildEmblemSymbol(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: emblemHeight,
                width: emblemWidth / 2,
                color: fromCssColor(
                  emblems[0]!.backgroundColor ?? '#ffffff',
                ),
              ),
              Positioned(
                bottom:
                    emblems.first?.filled ?? false ? null : emblemHeight / 3.5,
                height: emblems.first?.filled ?? false ? emblemHeight : null,
                child: Image.network(
                  emblems[0]!.emblem ?? defaultImg1,
                  width: emblemWidth / 2,
                  fit: emblems.first?.filled ?? false
                      ? BoxFit.fill
                      : BoxFit.contain,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: emblemHeight,
                width: emblemWidth / 2,
                color: fromCssColor(
                  emblems[1]!.backgroundColor ?? '#ffffff',
                ),
              ),
              Positioned(
                bottom: emblems[1]?.filled ?? false ? null : emblemHeight / 3.5,
                height: emblems[1]?.filled ?? false ? emblemHeight : null,
                child: Image.network(
                  emblems[1]!.emblem ?? defaultImg2,
                  width: emblemWidth / 2,
                  fit: emblems[1]?.filled ?? false
                      ? BoxFit.fill
                      : BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildTwoVerticalEmblem() {
    double emblemWidth = getHorizontalSize(width),
        emblemHeight = getVerticalSize(height);
    // This is the ratio of the tail size to the emblem height
    const double tailHeightRatio = 0.2;

    // Calculate the height of each emblem without including the tail
    double emblemHeightWithoutTail = emblemHeight / 2;

    // Calculate the height of the tail
    double tailHeight = emblemHeightWithoutTail * tailHeightRatio;

    // The total height of the widget, including the tail
    emblemHeight = emblemHeight + tailHeight;

    return _buildEmblemSymbol(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: emblemHeight / 2.2,
                child: Container(
                  // width: emblemWidth,
                  color: fromCssColor(
                    emblems[0]!.backgroundColor ?? '#ffffff',
                  ),
                ),
              ),
              Container(
                height: emblemHeight / 2,
                // width: emblemWidth,
                color: fromCssColor(
                  emblems[1]!.backgroundColor ?? '#ffffff',
                ),
              ),
            ],
          ),
          SizedBox(
            width: emblemWidth,
            height: emblemHeight - emblemHeight * .1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: emblems[0]?.filled ?? false ? emblemWidth : null,
                    child: Image.network(
                      emblems[0]!.emblem ?? defaultImg1,
                      width: emblemWidth / 2,
                      height:
                          emblems[0]?.filled ?? false ? emblemHeight / 2 : null,
                      fit:
                          // emblems[0]?.filled ?? false?
                          // BoxFit.cover:
                          BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: fromCssColor(
                      emblems[1]!.backgroundColor ?? '#ffffff',
                    ),
                    width: emblemWidth,
                    height: emblemHeight / 2,
                    child: Center(
                      child: Image.network(
                        emblems[1]!.emblem ?? defaultImg1,
                        width: (emblems[1]?.filled ?? false)
                            ? emblemWidth
                            : (emblemWidth / 2),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildThreeEmblem(EmblemType type) {
    double emblemWidth = getHorizontalSize(width),
        emblemHeight = getVerticalSize(height);
    // This is the ratio of the tail size to the emblem height
    const double tailHeightRatio = 0.2;

    // Calculate the height of each emblem without including the tail
    double emblemHeightWithoutTail = emblemHeight / 2;

    // Calculate the height of the tail
    double tailHeight = emblemHeightWithoutTail * tailHeightRatio;

    // The total height of the widget, including the tail
    emblemHeight = emblemHeight + tailHeight;

    switch (type) {
      case EmblemType.three_up:
        return _buildEmblemSymbol(
          child: Container(
            width: emblemWidth,
            height: emblemHeight,
            child: Column(
              children: [
                Container(
                  color: fromCssColor(
                    emblems[0]!.backgroundColor ?? '#ffffff',
                  ),
                  width: emblemWidth,
                  height: emblemHeight / 2.3,
                  child: Center(
                    child: Image.network(
                      emblems[0]!.emblem ?? defaultImg1,
                      fit: BoxFit.fill,
                      width: (emblems[0]?.filled ?? false) ? emblemWidth : null,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: emblemWidth / 2,
                          height: emblemHeight / 2,
                          color: fromCssColor(
                            emblems[1]!.backgroundColor ?? '#ffffff',
                          ),
                        ),
                        Container(
                          width: emblemWidth / 2,
                          height: emblemHeight / 2,
                          color: fromCssColor(
                            emblems[2]!.backgroundColor ?? '#ffffff',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (emblems[1]?.filled ?? false)
                              ? null
                              : emblemWidth / 2,
                          height: emblemHeight / 2.4,
                          child: Center(
                            child: Image.network(
                              emblems[1]!.emblem ?? defaultImg2,
                              fit: BoxFit.cover,
                              width: emblemWidth / 2,
                            ),
                          ),
                        ),
                        Container(
                          width: (emblems[2]?.filled ?? false)
                              ? null
                              : emblemWidth / 2,
                          height: emblemHeight / 2.4,
                          child: Center(
                            child: Image.network(
                              emblems[2]!.emblem ?? defaultImg2,
                              fit: BoxFit.cover,
                              width: emblemWidth / 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case EmblemType.three_down:
        return _buildEmblemSymbol(
          child: Container(
            width: emblemWidth,
            height: emblemHeight,
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: emblemWidth / 2,
                          height: emblemHeight / 2.3,
                          color: fromCssColor(
                            emblems[0]!.backgroundColor ?? '#ffffff',
                          ),
                        ),
                        Container(
                          width: emblemWidth / 2,
                          height: emblemHeight / 2.3,
                          color: fromCssColor(
                            emblems[1]!.backgroundColor ?? '#ffffff',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (emblems[0]?.filled ?? false)
                              ? null
                              : emblemWidth / 2,
                          height: emblemHeight / 2.3,
                          child: Center(
                            child: Image.network(
                              emblems[0]!.emblem ?? defaultImg2,
                              fit: BoxFit.cover,
                              width: emblemWidth / 2,
                            ),
                          ),
                        ),
                        Container(
                          width: (emblems[1]?.filled ?? false)
                              ? null
                              : emblemWidth / 2,
                          height: emblemHeight / 2.3,
                          child: Center(
                            child: Image.network(
                              emblems[1]!.emblem ?? defaultImg2,
                              fit: BoxFit.fill,
                              width: emblemWidth / 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  color: fromCssColor(
                    emblems[2]!.backgroundColor ?? '#ffffff',
                  ),
                  width: emblemWidth,
                  height: emblemHeight / 2,
                  padding: EdgeInsets.only(
                    bottom: emblemHeight * .08,
                  ),
                  child: Center(
                    child: Image.network(
                      emblems[2]!.emblem ?? defaultImg1,
                      width: (emblems[2]?.filled ?? false)
                          ? emblemWidth
                          : (emblemWidth / 2),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case EmblemType.three_left:
        return _buildEmblemSymbol(
          child: Container(
            width: emblemWidth,
            height: emblemHeight,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    color: fromCssColor(
                      emblems[0]!.backgroundColor ?? '#ffffff',
                    ),
                    padding: (emblems[0]!.filled ?? false)
                        ? null
                        : EdgeInsets.only(
                            bottom: emblemHeight * .1,
                          ),
                    width: emblemWidth / 2,
                    height: emblemHeight,
                    child: Image.network(
                      emblems[0]!.emblem ?? defaultImg1,
                      fit: (emblems[0]!.filled ?? false)
                          ? BoxFit.fill
                          : BoxFit.fitWidth,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        color: fromCssColor(
                          emblems[1]!.backgroundColor ?? '#ffffff',
                        ),
                        width: emblemWidth / 2,
                        height: emblemHeight / 2.3,
                        child: Image.network(
                          emblems[1]!.emblem ?? defaultImg2,
                          fit: (emblems[1]!.filled ?? false)
                              ? BoxFit.fill
                              : BoxFit.fitWidth,
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            color: fromCssColor(
                              emblems[2]!.backgroundColor ?? '#ffffff',
                            ),
                            width: emblemWidth / 2,
                            height: emblemHeight / 2,
                          ),
                          SizedBox(
                            height: emblemHeight / 2.3,
                            width: emblemWidth / 2,
                            child: Image.network(
                              emblems[2]!.emblem ?? defaultImg2,
                              fit: (emblems[2]!.filled ?? false)
                                  ? BoxFit.fill
                                  : BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      case EmblemType.three_right:
        return _buildEmblemSymbol(
          child: Container(
            width: emblemWidth,
            height: emblemHeight,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        color: fromCssColor(
                          emblems[0]!.backgroundColor ?? '#ffffff',
                        ),
                        width: emblemWidth / 2,
                        height: emblemHeight / 2.3,
                        child: Image.network(
                          emblems[0]!.emblem ?? defaultImg2,
                          fit: (emblems[0]!.filled ?? false)
                              ? BoxFit.fill
                              : BoxFit.fitWidth,
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            color: fromCssColor(
                              emblems[1]!.backgroundColor ?? '#ffffff',
                            ),
                            width: emblemWidth / 2,
                            height: emblemHeight / 2,
                          ),
                          SizedBox(
                            height: emblemHeight / 2.3,
                            width: emblemWidth / 2,
                            child: Image.network(
                              emblems[1]!.emblem ?? defaultImg2,
                              fit: (emblems[1]!.filled ?? false)
                                  ? BoxFit.fill
                                  : BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: fromCssColor(
                      emblems[2]!.backgroundColor ?? '#ffffff',
                    ),
                    padding: (emblems[2]!.filled ?? false)
                        ? null
                        : EdgeInsets.only(
                            bottom: emblemHeight * .1,
                          ),
                    width: emblemWidth / 2,
                    height: emblemHeight,
                    child: Image.network(
                      emblems[2]!.emblem ?? defaultImg1,
                      fit: (emblems[2]!.filled ?? false)
                          ? BoxFit.fill
                          : BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return _buildThreeEmblem(EmblemType.three_up);
    }
  }

  _buildDiagonal(EmblemType type) {
    double emblemWidth = getHorizontalSize(width),
        emblemHeight = getVerticalSize(height);
    // This is the ratio of the tail size to the emblem height
    const double tailHeightRatio = 0.2;

    // Calculate the height of each emblem without including the tail
    double emblemHeightWithoutTail = emblemHeight / 2;

    // Calculate the height of the tail
    double tailHeight = emblemHeightWithoutTail * tailHeightRatio;

    // The total height of the widget, including the tail
    emblemHeight = emblemHeight + tailHeight;

    return _buildEmblemSymbol(
      child: Stack(
        children: [
          // First emblem
          ClipPath(
            clipper: type == EmblemType.diagonal_left
                ? DiagonalLeftClipper()
                : DiagonalRightClipper(),
            child: Container(
              width: emblemWidth,
              height: emblemHeight,
              padding: type == EmblemType.diagonal_left
                  ? EdgeInsets.only(
                      bottom:
                          emblems[0]?.filled ?? false ? 0 : emblemHeight * .4,
                      right: emblems[0]?.filled ?? false ? 0 : emblemWidth * .4,
                    )
                  : EdgeInsets.only(
                      left: emblems[0]?.filled ?? false ? 0 : emblemWidth * .45,
                      top: emblems[0]?.filled ?? false ? 0 : emblemHeight * .2,
                    ),
              color: fromCssColor(emblems[0]!.backgroundColor ?? '#ffffff'),
              child: Image.network(
                emblems[0]!.emblem ?? defaultImg1,
                width: emblemWidth,
                height: emblemHeight,
                fit: emblems[0]?.filled ?? false ? BoxFit.fill : BoxFit.contain,
              ),
            ),
          ),
          // Second emblem
          ClipPath(
            clipper: type == EmblemType.diagonal_left
                ? DiagonalRightClipper()
                : DiagonalLeftClipper(),
            child: Container(
              width: emblemWidth,
              height: emblemHeight,
              padding: type == EmblemType.diagonal_left
                  ? EdgeInsets.only(
                      top: emblems[2]?.filled ?? false ? 0 : emblemHeight * .25,
                      left: emblems[2]?.filled ?? false ? 0 : emblemWidth * .4,
                    )
                  : EdgeInsets.only(
                      right:
                          emblems[2]?.filled ?? false ? 0 : emblemWidth * .45,
                      bottom:
                          emblems[2]?.filled ?? false ? 0 : emblemHeight * .4,
                    ),
              color: fromCssColor(emblems[2]!.backgroundColor ?? '#ffffff'),
              child: Image.network(
                emblems[2]!.emblem ?? defaultImg2,
                width: emblemWidth,
                height: emblemHeight,
                fit: emblems[2]?.filled ?? false ? BoxFit.fill : BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiagonalLeftClipper extends CustomClipper<Path> {
  DiagonalLeftClipper();

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(-30, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DiagonalRightClipper extends CustomClipper<Path> {
  DiagonalRightClipper();

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(-30, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SingleEmblem extends StatelessWidget {
  const SingleEmblem({
    super.key,
    required this.emblems,
  });

  final List<GeneratedEmblems?> emblems;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fromCssColor(emblems[0]!.backgroundColor!),
      child: Center(
        child: Image.network(
          emblems.first!.emblem ?? defaultImg1,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
