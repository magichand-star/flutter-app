import 'dart:math';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import 'colors_lists.dart';

enum BackgroundColor {
  black,
  red,
  green,
  blue,
  purple,
  orange,
  white,
  yellow,
  brown,
  unknown,
}

// Lists of available colors

class ColorVerification {
  // List of available colors

  static const List<BackgroundColor> allColors = [
    BackgroundColor.black,
    BackgroundColor.blue,
    BackgroundColor.brown,
    BackgroundColor.green,
    BackgroundColor.orange,
    BackgroundColor.purple,
    BackgroundColor.red,
    BackgroundColor.white,
    BackgroundColor.yellow,
  ];

  // Lists of compatible colors

  List<BackgroundColor> get blackMatch {
    List<BackgroundColor> exclusions = [
      BackgroundColor.black,
      BackgroundColor.brown,
    ];
    return _matchColors(exclusions: exclusions);
  }

  List<BackgroundColor> get redMatch {
    List<BackgroundColor> exclusions = [
      BackgroundColor.red,
      BackgroundColor.purple,
      BackgroundColor.orange,
      BackgroundColor.brown,
    ];
    return _matchColors(exclusions: exclusions);
  }

  List<BackgroundColor> get greenMatch {
    List<BackgroundColor> exclusions = [
      BackgroundColor.green,
      BackgroundColor.purple,
      BackgroundColor.orange,
      BackgroundColor.blue,
    ];
    return _matchColors(exclusions: exclusions);
  }

  List<BackgroundColor> get blueMatch {
    List<BackgroundColor> inclusions = [
      BackgroundColor.black,
      BackgroundColor.red,
      BackgroundColor.white,
      BackgroundColor.brown,
    ];
    return _matchColors(inclusions: inclusions);
  }

  List<BackgroundColor> get purpleMatch {
    List<BackgroundColor> inclusions = [
      BackgroundColor.black,
      BackgroundColor.white,
      BackgroundColor.brown,
    ];
    return _matchColors(inclusions: inclusions);
  }

  List<BackgroundColor> get orangeMatch {
    List<BackgroundColor> inclusions = [
      BackgroundColor.black,
      BackgroundColor.white,
      BackgroundColor.brown,
    ];
    return _matchColors(inclusions: inclusions);
  }

  List<BackgroundColor> get whiteMatch {
    List<BackgroundColor> exclusions = [
      BackgroundColor.white,
    ];
    return _matchColors(exclusions: exclusions);
  }

  List<BackgroundColor> get yellowMatch {
    List<BackgroundColor> exclusions = [
      BackgroundColor.yellow,
      BackgroundColor.purple,
      BackgroundColor.orange,
    ];
    return _matchColors(exclusions: exclusions);
  }

  List<BackgroundColor> get brownMatch {
    List<BackgroundColor> exclusions = [
      BackgroundColor.black,
      BackgroundColor.red,
      BackgroundColor.orange,
      BackgroundColor.brown,
    ];
    return _matchColors(exclusions: exclusions);
  }

  List<Map<String, dynamic>> checkAndRearrangeEmblems(
      List<Map<String, dynamic>> emblems) {
    Map<String, List<int>> colorIndexes = {};

    for (int i = 0; i < emblems.length; i++) {
      Map<String, dynamic> emblem = emblems[i];
      String? backgroundColor = emblem['background_color'];
      if (backgroundColor != null) {
        if (colorIndexes.containsKey(backgroundColor)) {
          colorIndexes[backgroundColor]!.add(i);
        } else {
          colorIndexes[backgroundColor] = [i];
        }
      }
    }

    for (String color in colorIndexes.keys) {
      List<int> indexes = colorIndexes[color]!;
      if (indexes.length == 1) {
        continue;
      }

      indexes.sort();
      int columns = (sqrt(indexes.length) + 0.5).toInt();
      int rows = (indexes.length / columns).ceil();

      List<List<Map<String, dynamic>?>> emblemGrid =
          List.generate(rows, (index) => List.filled(columns, null));
      int diagonalRowIndex = 0;
      int diagonalColumnIndex = 0;

      for (int i = 0; i < indexes.length; i++) {
        int rowIndex = i ~/ columns;
        int columnIndex = i % columns;
        if (rowIndex == diagonalRowIndex &&
            columnIndex == diagonalColumnIndex) {
          emblemGrid[rowIndex][columnIndex] = emblems[indexes[i]];
          diagonalRowIndex++;
          diagonalColumnIndex++;
        } else {
          emblemGrid[rowIndex][columnIndex] = emblems[indexes[i]];
        }
      }

      List<Map<String, dynamic>> diagonalEmblems = [];

      for (int i = 0; i < rows; i++) {
        if (i < emblemGrid.length &&
            i < emblemGrid[i].length &&
            emblemGrid[i][i] != null) {
          diagonalEmblems.add(emblemGrid[i][i]!);
          emblemGrid[i][i] = null;
        }
      }

      diagonalEmblems = diagonalEmblems.reversed.toList();

      for (int i = 0; i < min(rows, columns); i++) {
        if (emblemGrid[i][i] == null && diagonalEmblems.isNotEmpty) {
          emblemGrid[i][i] = diagonalEmblems.removeLast();
        }
      }

      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
          int index = i * columns + j;
          if (index >= indexes.length) {
            break;
          }
          emblems[indexes[index]] = emblemGrid[i][j]!;
        }
      }
    }

    return emblems;
  }

  List<BackgroundColor> _matchColors(
      {List<BackgroundColor>? exclusions, List<BackgroundColor>? inclusions}) {
    if (inclusions != null && inclusions.isNotEmpty)
      return inclusions;
    else if (exclusions != null && exclusions.isNotEmpty) {
      return allColors.where((color) {
        return !exclusions.contains(color);
      }).toList();
    } else
      return [];
  }

  List<BackgroundColor> _colorMatchesList(BackgroundColor backgroundColor) {
    switch (backgroundColor) {
      case BackgroundColor.black:
        return blackMatch;
      case BackgroundColor.blue:
        return blueMatch;
      case BackgroundColor.brown:
        return brownMatch;
      case BackgroundColor.green:
        return greenMatch;
      case BackgroundColor.orange:
        return orangeMatch;
      case BackgroundColor.purple:
        return purpleMatch;
      case BackgroundColor.red:
        return redMatch;
      case BackgroundColor.white:
        return whiteMatch;
      case BackgroundColor.yellow:
        return yellowMatch;
      default:
        return [];
    }
  }

  BackgroundColor _identifyColor(String colorCode) {
    Color color = fromCssColor(colorCode);

    if (ColorsLists.red.contains(color)) {
      return BackgroundColor.red;
    } else if (ColorsLists.green.contains(color)) {
      return BackgroundColor.green;
    } else if (ColorsLists.blue.contains(color)) {
      return BackgroundColor.blue;
    } else if (ColorsLists.purple.contains(color)) {
      return BackgroundColor.purple;
    } else if (ColorsLists.orange.contains(color)) {
      return BackgroundColor.orange;
    } else if (ColorsLists.white.contains(color)) {
      return BackgroundColor.white;
    } else if (ColorsLists.yellow.contains(color)) {
      return BackgroundColor.yellow;
    } else if (ColorsLists.brown.contains(color)) {
      return BackgroundColor.brown;
    } else if (ColorsLists.black.contains(color)) {
      return BackgroundColor.black;
    } else {
      return BackgroundColor.unknown;
    }
  }
  // [[red, blue], [red], [red, #00000, yellow], [red, black, white]]

  List<Color> verify({required List<List<String>> colorsList}) {
    // debugger();
    if (colorsList.length == 1) {
      return [
        fromCssColor(
          colorsList.first[Random().nextInt(
            colorsList.first.length,
          )],
        ),
      ];
    }

    List<Map<BackgroundColor, List<Color>>> colors = [];
    for (List<String> list in colorsList) {
      Map<BackgroundColor, List<Color>> colorMap = {};
      for (String colorCode in list) {
        BackgroundColor backgroundColor = _identifyColor(colorCode);
        // print(backgroundColor);
        if (!colorMap.containsKey(backgroundColor)) {
          colorMap[_identifyColor(colorCode)] = [fromCssColor(colorCode)];
        } else {
          colorMap[_identifyColor(colorCode)]!.add(fromCssColor(colorCode));
        }
      }
      colors.add(colorMap);
    }

    List<Color> results = [];

    for (int i = 0; i < colors.length; i++) {
      Map<BackgroundColor, List<Color>> colorsMap = colors[i];
      var random = Random();
      List keys = colorsMap.keys.toList();

      // Initialize chosenBackgroundColor with the first key of the colorsMap.
      BackgroundColor chosenBackgroundColor = keys[0] as BackgroundColor;

      bool isCompatible = false;
      int attempts = 0;

      while (!isCompatible && attempts < keys.length) {
        chosenBackgroundColor = keys[random.nextInt(keys.length)];

        isCompatible = true;
        for (Color previousColor in results) {
          BackgroundColor previousBackgroundColor =
              _identifyColor(previousColor.toCssString());
          if (!_colorMatchesList(previousBackgroundColor)
              .contains(chosenBackgroundColor)) {
            isCompatible = false;
            break;
          }
        }

        attempts++;
      }

      if (!isCompatible) {
        throw NoCompatibleColorsException(
            "No compatible colors found for emblem at index $i.");
      }

      List<Color>? chosenList = colorsMap[chosenBackgroundColor];
      Color chosenColor = colorsMap[chosenBackgroundColor]![
          Random().nextInt(chosenList!.length)];
      results.add(chosenColor);
    }

    return results;
  }
}

class NoCompatibleColorsException implements Exception {
  final String message;

  NoCompatibleColorsException([this.message = "No compatible colors found."]);

  @override
  String toString() => "NoCompatibleColorsException: $message";
}
