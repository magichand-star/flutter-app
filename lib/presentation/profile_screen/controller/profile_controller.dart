import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../backend/backend.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/custom_functions.dart';
import '../../../core/utils/dynamic_urls.dart';
import '../../../core/utils/gender_formatter.dart';
import '../../../core/utils/rating_controller.dart';
import '../../../domain/auth/auth_util.dart';
import '../../../widgets/emblem/emblem_widget.dart';

class ProfileController extends GetxController {
  int _rating = RatingController.rating;
  String? city, name, image, association;
  UsersRecord? currentUserDocument;
  List<GeneratedEmblems?> generatedEmblems = [];
  WidgetsToImageController widgetToImageController = WidgetsToImageController();
  Uint8List? bytes;
  EmblemType? emblemType;

  String get rating => _rating.toString();

  signOut() async {
    await FirebaseAuth.instance.signOut();
    await GetStorage().erase();
    Get.offAllNamed(AppRoutes.authorizationScreen);
  }

  shareEmblem() async {
    bytes = await widgetToImageController.capture();
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/emblem.jpg').create();
    if (bytes != null) {
      String? url = await DynamicURLs().generateLink();
      if (url != null) {
        file.writeAsBytesSync(bytes!);
        // ignore: deprecated_member_use
        Share.shareFiles(
          [file.path],
          mimeTypes: ['image/png'],
          text:
              'Смотри какой герб я себе сделал в Monarchium! Сделай и ты! \n$url',
        );
      }
    }
  }

  String? get status {
    final box = GetStorage();
    Gender? gender;
    String? genderStr = box.read('gender');

    if (genderStr != null && genderStr.isNotEmpty) {
      gender = getGender(genderStr);
    } else {
      genderStr = currentUserDocument?.gender;
      gender = getGender(genderStr);

      if (genderStr != null && genderStr.isNotEmpty) {
        box.write('gender', genderStr);
      }
    }

    for (var status in statuses) {
      if ((_rating >= status['limitFrom'] && status['limitTo'] == null) ||
          (_rating >= status['limitFrom'] && _rating < status['limitTo'])) {
        switch (gender) {
          case Gender.male:
            return status['titleMale'];
          case Gender.female:
            return status['titleFemale'];
          default:
        }
      }
    }
    return null;
  }

  @override
  void onReady() {
    showOverlay(asyncFunction: () async {
      currentUserDocument = await initCurrentUserDocument();

      city = currentUserDocument?.birthdayPlace;
      name = currentUserDocument?.displayName;
      AssotiationsRecord? associationsRecord =
          currentUserDocument?.association == null
              ? null
              : await AssotiationsRecord.getDocumentOnce(
                  currentUserDocument!.association!);
      association = associationsRecord?.name;
      image = currentUserDocument?.photoUrl;

      generatedEmblems =
          await currentUserDocument?.generatedEmblems?.toList() ?? [];
      emblemType = stringToEmblemType(await currentUserDocument?.emblemType);
      update();
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
