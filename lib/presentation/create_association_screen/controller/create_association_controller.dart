import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../backend/backend.dart';
import '../../../backend/firebase_storage/storage.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/custom_functions.dart';
import '../../../core/utils/rating_controller.dart';
import '../../../core/utils/user_activity.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../domain/auth/auth_util.dart';

enum AssociationType { family, corporate, land, friends }

class CreateAssociationController extends GetxController {
  TextEditingController titleController = TextEditingController();
  String titleLabel = '';

  TextEditingController locationController = TextEditingController();
  String locationLabel = '';

  TextEditingController weburlController = TextEditingController();
  String weburlLabel = '';

  TextEditingController activitiesAndHobbiesController =
      TextEditingController();
  String activitiesAndHobbiesLabel = '';

  String associationTypeString = "";

  AssociationType? associationType;

  String? photoUrlLocal, photoUrl;

  File? photoFile;

  List<DocumentReference> members = [];

  List<String> hobbies = [], selectedHobbies = [];

  final formKey = GlobalKey<FormState>();

  pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      photoUrlLocal = image.path;
      photoFile = File(image.path);
      update();
    }
  }

  addMemeber() async {
    final result = await Get.toNamed(
      AppRoutes.searchScreen,
      arguments: [
        {'from': 'createAssociation'},
      ],
    );
    if (result != null) {
      members = result;
      printInfo(info: members.toString());
      update();
    } else {
      if (members.isNotEmpty) members.clear();
    }
    printInfo(info: members.toString());
  }

  getActivities() async {
    final box = GetStorage();
    hobbies = box.read(kHobbiesKey)?.cast<String>() ?? [];

    if (hobbies.isEmpty) {
      // debugger();
      Map<String, dynamic>? data = await ApiClient().getActivitiesAndHobbies();
      if (data != null && data.isNotEmpty && data['error'] == null) {
        hobbies = (data['hobbies'] ?? []).cast<String>();
        box.write(kHobbiesKey, hobbies);
      }
    }
  }

  onHobbiesChanged(List list) {
    hobbies = list.cast<String>();
    update();
  }

  createAssociation() async {
    showOverlay(asyncFunction: () async {
      try {
        if (formKey.currentState?.validate() ?? false) {
          if (members.isEmpty) {
            Get.snackbar('Ошибка', 'Добавьте участников');
            return;
          }
          if (associationType == AssociationType.friends &&
              selectedHobbies.isEmpty) {
            Get.snackbar('Ошибка', 'Выберите общие интересы');
            return;
          }
          if (photoFile == null) {
            Get.snackbar('Ошибка', 'Добавьте фото');
            return;
          } else {
            if (FirebaseAuth.instance.currentUser != null)
              photoUrl = await uploadDataFromFile(
                'users/${FirebaseAuth.instance.currentUser!.uid}/uploads/${photoFile!.path.split('/').last}',
                photoFile!,
              );
            if (photoUrl == null) {
              showSnackbar('Ошибка загрузки изображения');
              return;
            }
          }
          if (currentUserReference != null)
            members.add(currentUserReference!);
          else {
            UsersRecord? currentUser = await initCurrentUserDocument();
            if (currentUser != null) members.add(currentUser.reference);
          }

          final assotiationsCreateData = {
            ...createAssotiationsRecordData(
              name: titleController.text,
              creator: currentUserReference,
              logo: photoUrl,
              createdDate: DateTime.now(),
              place: locationController.text,
              website: weburlController.text,
              career: activitiesAndHobbiesController.text,
              type: associationTypeString,
            ),
            'users': members,
            'common_hobbies': selectedHobbies,
          };

          DocumentReference assotiationRecord =
              AssotiationsRecord.collection.doc();
          await assotiationRecord.set(assotiationsCreateData);

          Map<String, dynamic> usersUpdateData = {};

          if (UserActivity.isFirstMonth) {
            RatingController().updateRating(10);
            usersUpdateData['rating'] = FieldValue.increment(10);
          } else if (UserActivity.isSecondMonth) {
            RatingController().updateRating(1);
            usersUpdateData['rating'] = FieldValue.increment(1);
          }

          usersUpdateData['associations'] = FieldValue.arrayUnion([
            assotiationRecord,
          ]);

          await currentUserReference!.update(usersUpdateData);

          Get.offAllNamed(AppRoutes.homeScreen);
          Get.snackbar('Ура!', "Ваше объединение успешно создано");
        }
      } catch (e) {
        printError(info: e.toString());
        Get.snackbar('Ошибка', "Что-то пошло не так");
        return;
      }
    });
  }

  Future<dynamic> init() async {
    await getActivities();
    await initAssociationType();
  }

  Future<void> initAssociationType() async {
    try {
      associationTypeString = Get.arguments[0];
      switch (associationTypeString) {
        case 'Семейно-родовое':
          associationType = AssociationType.family;
          titleLabel = 'Название рода';
          locationLabel = 'Местоположение';
          break;
        case 'Корпоративное':
          associationType = AssociationType.corporate;
          titleLabel = 'Название организации';
          locationLabel = 'Местоположение';
          weburlLabel = 'Сайт (если есть)';
          activitiesAndHobbiesLabel = 'Сфера деятельности';
          break;
        case 'Земельное':
          associationType = AssociationType.land;
          titleLabel = 'Название';
          locationLabel = 'Местоположение';
          break;
        default:
          associationType = AssociationType.friends;
          titleLabel = 'Название';
          locationLabel = 'Местоположение';
          activitiesAndHobbiesLabel = 'Общие интересы';
      }
      update();
    } catch (e) {
      return;
    }
  }

  addUsers() {}

  @override
  void onReady() {
    showOverlay(asyncFunction: init);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    locationController.dispose();
    weburlController.dispose();
    activitiesAndHobbiesController.dispose();
  }
}
