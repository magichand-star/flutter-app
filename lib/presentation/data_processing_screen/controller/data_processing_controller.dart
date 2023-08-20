import 'dart:convert';
import 'dart:math';

import 'package:from_css_color/from_css_color.dart';
import 'package:get_storage/get_storage.dart';

import '../../../backend/backend.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/colors/color_verification.dart';
import '../../../domain/auth/auth_util.dart';
import '../../../widgets/emblem/emblem_widget.dart';

class DataProcessingController extends GetxController {
  late List<String> tags = [], exclusions = [], selectedTags = [];
  String? displayName, lastName, birthPlace;
  EmblemType emblemType = EmblemType.four;
  Map<String, dynamic> emblemsFull = {}, userData = {};
  List<Map<String, dynamic>> emblems = [];

  late int limit, counter = 0;
  int totalFunctions = 5, finishedfuncs = 0;
  int retryLimit = 100; // The maximum number of retries.
  int retryCounter = 0; // The current number of retries.

  double get percentage => (finishedfuncs / totalFunctions);
  bool bdayCondition = false, birthPlaceCondition = false;

  Map<String, List<int>> emblemPositions = {
    'square': [
      0, 1, 2, 3, // EmblemType.four
      0, 1, // EmblemType.three_down, EmblemType.three_right
      1, 2, // EmblemType.three_up, EmblemType.three_left
    ],
    'rectangle horizontal': [
      2, // EmblemType.three_down
      0, // EmblemType.three_up
      0, 1, // EmblemType.two_horizontal
    ],
    'rectangle vertical': [
      0, // EmblemType.three_left
      2, // EmblemType.three_right
      0, 1, // EmblemType.two_vertical
    ],
    'diagonal': [
      0, 1, // EmblemType.diagonal_left, EmblemType.diagonal_right
    ],
  };

  final Map<String, int> emblemCounts = {};

  updateFinishedFuncs() {
    finishedfuncs++;
    if (finishedfuncs > totalFunctions) {
      finishedfuncs = totalFunctions;
    }
    update();
  }

  chooseTags() {
    if (tags.isEmpty) return;
    emblemsFull = {};

    int numTagsToSelect = 4;
    if (tags.length < numTagsToSelect && tags.length != 1) numTagsToSelect = 2;
    if (tags.length == 3 && birthPlaceCondition) numTagsToSelect = 3;
    if (bdayCondition) numTagsToSelect = 2;

    tags.shuffle();
    List<String> tempList = tags.sublist(0, numTagsToSelect);
    exclusions = tags.where((tag) => !tempList.contains(tag)).toList();
    selectedTags = tempList;

    // Add tags from exclusions until selectedTags has 4 tags
    while (selectedTags.length < 4 && exclusions.isNotEmpty) {
      selectedTags.add(exclusions.removeLast());
    }
  }

  getEmblems() async {
    QuerySnapshot<Map<String, dynamic>> tagsDocSnapshot =
        await FirebaseFirestore.instance
            .collection('tags')
            .where('tags', whereIn: selectedTags)
            .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> tagsDocs =
        tagsDocSnapshot.docs;
    if (tagsDocs.length != selectedTags.length) {
      printInfo(info: 'Not all tags found');
      List<String> foundTags =
          tagsDocs.map((e) => e['tags']).toList().cast<String>();

      List<String> notFoundTags =
          selectedTags.where((tag) => !foundTags.contains(tag)).toList();

      // TODO: Attention

      if (tags.length == 3) {
        tags.removeAt(0);
      } else if (tags.length < 2) {
        Get.offAndToNamed(AppRoutes.dataFormScreen);
        Get.snackbar("Ошибка",
            "К сожалению нам не удалось создать герб по вашим данным");
      }
      tags.removeWhere((tag) => notFoundTags.contains(tag));

      selectedTags = [];

      await recursiveSelection();
      return;
    }
    for (QueryDocumentSnapshot<Map<String, dynamic>> tag in tagsDocs) {
      Map<String, dynamic> currentTag = tag.data();
      if (currentTag['emblems'] == null) {
        continue;
      }
      List<DocumentReference> emblemsList =
          currentTag['emblems'].cast<DocumentReference>();

      emblemsFull[currentTag['tags']] = emblemsList;
    }
    await chooseEmblems();
    updateFinishedFuncs();
  }

  recursiveSelection() async {
    if (retryCounter >= retryLimit || tags.length < 4) {
      Get.offAndToNamed(AppRoutes.dataFormScreen);
      Get.snackbar(
          "Ошибка", "К сожалению нам не удалось создать герб по вашим данным");
      return;
    }
    emblems.clear();
    emblemsFull.clear();
    selectedTags.clear();
    await chooseTags();
    await getEmblems();
    retryCounter++;
  }

  chooseEmblems() async {
    int numEmblemsToSelect = selectedTags.length;

    if (emblemType == EmblemType.four && selectedTags.length < 4)
      numEmblemsToSelect = 2;
    if (emblemType == EmblemType.four && birthPlaceCondition)
      numEmblemsToSelect = 3;

    if (numEmblemsToSelect == 2 && selectedTags.length == 3) {
      selectedTags.shuffle();
      selectedTags.removeLast();
    } else if (numEmblemsToSelect == 3 && selectedTags.length == 4) {
      selectedTags.shuffle();
      selectedTags.removeLast();
    }

    List<DocumentReference<Map<String, dynamic>>> chosenEmblems = [];
    for (var tag in selectedTags) {
      if (!emblemsFull.keys
          .toList()
          .every((element) => selectedTags.contains(element))) {
        recursiveSelection();
        return;
      }
      if (chosenEmblems.length >= numEmblemsToSelect) {
        break; // Stop the iteration once we have selected the required number of emblems
      }

      bool isFound = false;
      var emblemsForTag = List<DocumentReference<Map<String, dynamic>>>.from(
          emblemsFull[tag]); // Create a copy
      while (emblemsForTag.isNotEmpty) {
        final _random = Random();
        int index = _random.nextInt(emblemsForTag.length);
        var emblem = emblemsForTag[index];
        EmblemsRecord emblemRecord =
            await EmblemsRecord.getDocumentOnce(emblem);
        if (emblemRecord.positions != null &&
            emblemRecord.positions!.isNotEmpty) {
          List<String> positions =
              emblemRecord.positions!.toList().cast<String>();

          for (var position in positions) {
            if (emblemPositions[position]!.contains(chosenEmblems.length)) {
              chosenEmblems.add(emblem);
              isFound = true;
              break;
            }
          }
        } else {
          // positions is null or empty, emblem can be used without considering position
          chosenEmblems.add(emblem);
          isFound = true;
        }
        if (isFound) break;
        emblemsForTag.removeAt(index); // Remove the checked emblem
      }
      if (!isFound) {
        // No suitable emblem found, trying again
        await recursiveSelection();
        return;
      }
    }
    verifyEmblems(chosenEmblems);

    printInfo(info: chosenEmblems.toString());
    updateFinishedFuncs();
  }

  verifyEmblems(
      List<DocumentReference<Map<String, dynamic>>> chosenEmblems) async {
    List<List<String>> emblemsColors = [];
    for (int i = 0; i < chosenEmblems.length; i++) {
      DocumentReference<Map<String, dynamic>> emblem = chosenEmblems[i];
      EmblemsRecord emblemRecord = await EmblemsRecord.getDocumentOnce(emblem);
      if (emblemRecord.backgroundColor != null) {
        emblemsColors.add([emblemRecord.backgroundColor!.toCssString()]);
      } else if (emblemRecord.suggestedColors != null &&
          emblemRecord.suggestedColors!.isNotEmpty) {
        emblemsColors.add(
          emblemRecord.suggestedColors!
              .map((color) => color.toCssString())
              .toList(),
        );
      }
      emblems.add({
        'emblem': emblemRecord.emblem,
        'color_index': i, // add the index of this emblem to the map
        'filled': emblemRecord.filled,
      });
    }
    if (emblemsColors.length != selectedTags.length) {
      printInfo(info: 'Not all emblems found');
      await recursiveSelection();
      return;
    }
    try {
      List<Color> backgroundColors =
          await processColorsWithRetry(emblemsColors);
      for (int j = 0; j < backgroundColors.length; j++) {
        Color color = backgroundColors[j];
        emblems.firstWhere(
                (emblem) => emblem['color_index'] == j)['background_color'] =
            color.toCssString();
      }
      handleEmblems(chosenEmblems);
    } catch (e) {
      print(e);
      await recursiveSelection();
    }
  }

  handleEmblems(
      List<DocumentReference<Map<String, dynamic>>> chosenEmblems) async {
    // If the emblem type is 'four' and there are exactly 2 emblems, rearrange them in the specified order.
    List<EmblemsRecord> chosenEmblemRecords = [];
    for (var emblemDoc in chosenEmblems) {
      chosenEmblemRecords.add(await EmblemsRecord.getDocumentOnce(emblemDoc));
    }

    if (emblemType == EmblemType.four && chosenEmblemRecords.length == 2 ||
        emblemType == EmblemType.four && bdayCondition) {
      if (chosenEmblemRecords[0].emblem == chosenEmblemRecords[1].emblem) {
        emblems = [emblems[0], emblems[1], emblems[0], emblems[1]];
      } else {
        emblems = [emblems[0], emblems[1], emblems[1], emblems[0]];
      }
    } else if (emblemType == EmblemType.four &&
        chosenEmblemRecords.length == 3) {
      if (chosenEmblemRecords[0].emblem == chosenEmblemRecords[1].emblem) {
        emblems = [emblems[0], emblems[1], emblems[2], emblems[0]];
      } else if (chosenEmblemRecords[0].emblem ==
          chosenEmblemRecords[2].emblem) {
        emblems = [emblems[0], emblems[1], emblems[0], emblems[2]];
      } else if (chosenEmblemRecords[1].emblem ==
          chosenEmblemRecords[2].emblem) {
        emblems = [emblems[0], emblems[1], emblems[1], emblems[2]];
      } else {
        emblems = [emblems[0], emblems[1], emblems[2], emblems[0]];
      }
    }
    // If the emblem type is 'three_down', 'three_up', 'three_left', or 'three_right', check and rearrange the emblems.
    else if (emblemType == EmblemType.three_down ||
        emblemType == EmblemType.three_up ||
        emblemType == EmblemType.three_left ||
        emblemType == EmblemType.three_right) {
      emblems = ColorVerification().checkAndRearrangeEmblems(emblems);
      updateFinishedFuncs();
    }

    // Update the current user's 'generated_emblems', 'emblems', and 'emblem_type' fields.
    DocumentReference? currentUser = currentUserReference;
    await currentUser?.update(
      {
        'generated_emblems': emblems,
        'emblems': chosenEmblems,
        'emblem_type': emblemType.toString(),
      },
    );

    // Update the number of finished functions.
    updateFinishedFuncs();

    // Navigate to the home screen with the chosen emblems and emblem type as arguments.
    Get.offAndToNamed(
      AppRoutes.homeScreen,
      arguments: [
        {'emblems': emblems, 'emblemType': emblemType},
      ],
    );
  }

  Future<List<Color>> processColorsWithRetry(List<List<String>> colorsList,
      [int retries = 0]) async {
    const maxRetries = 5; // Maximum retries for color verification.
    if (retries >= maxRetries) {
      recursiveSelection();
      throw Exception('Maximum retries exceeded for color verification.');
    }
    try {
      return ColorVerification().verify(colorsList: colorsList);
    } catch (e) {
      if (e is NoCompatibleColorsException) {
        print("Exception caught: $e. Retrying...");
        return await processColorsWithRetry(colorsList, retries + 1);
      } else {
        rethrow;
      }
    }
  }

  void determineEmblemType() {
    final cyrillicAlphabet = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя';
    final int surnameInitialPosition =
        cyrillicAlphabet.indexOf(lastName![0].toLowerCase()) + 1;
    final int birthPlaceInitialPosition =
        cyrillicAlphabet.indexOf(birthPlace![0].toLowerCase()) + 1;

    if (selectedTags.length < 4 && selectedTags.length > 1) {
      emblemType = EmblemType.four;
    } else if (selectedTags.length == 1) {
      emblemType = EmblemType.single;
    } else if (birthPlaceInitialPosition % 2 == 1) {
      birthPlaceCondition = true;
      final random = Random();
      final emblemTypes = [
        EmblemType.three_down,
        EmblemType.three_up,
        EmblemType.three_left,
        EmblemType.three_right,
        EmblemType.four
      ];
      emblemType = emblemTypes[random.nextInt(emblemTypes.length)];
    } else if (surnameInitialPosition % 2 == 0) {
      bdayCondition = true;
      final random = Random();
      final emblemTypes = [
        EmblemType.two_vertical,
        EmblemType.two_horizontal,
        EmblemType.diagonal_right,
        EmblemType.diagonal_left,
        EmblemType.four
      ];
      emblemType = emblemTypes[random.nextInt(emblemTypes.length)];
    } else {
      emblemType = EmblemType.four;
    }
  }

  getTags() async {
    if (Get.arguments == null) {
      GetStorage box = GetStorage();
      String data = box.read('userData') ?? '';
      if (data.isNotEmpty) {
        userData = jsonDecode(data);
        // TODO: Remove this.
        userData['lastName'] = 'Аслано';
        userData['birthPlace'] = 'Астана';
        userData['displayName'] = 'Асланов Артур';
        userData['firstName'] = 'Артур';
        tags = userData['tags'].cast<String>();
        // tags.removeRange(3, tags.length);
        printInfo(info: tags.toString());
        displayName = userData['displayName'];
        lastName = userData['lastName'];
        birthPlace = userData['birthPlace'];
      } else {
        tags = currentUserDocument?.tags?.toList() ?? [];
        displayName = currentUserDocument?.displayName;
        lastName = currentUserDocument?.lastName;
        birthPlace = currentUserDocument?.birthdayPlace;
      }
    } else {
      tags = Get.arguments?[0]['tags'];
      displayName = Get.arguments?[0]['displayName'];
      lastName = Get.arguments?[0]['lastName'];
      birthPlace = Get.arguments?[0]['birthPlace'];
    }
    update();

    limit = tags.length;
    updateFinishedFuncs();
  }

  init() async {
    retryCounter = 0; // Reset the retry counter.
    await getTags();
    await chooseTags();
    determineEmblemType();
    await getEmblems();
  }

  @override
  void onReady() async {
    await init();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
