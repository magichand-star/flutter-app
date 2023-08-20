import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_state_city/country_state_city.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

import '../../../backend/backend.dart';
import '../../../backend/firebase_storage/storage.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/custom_functions.dart';
import '../../../core/utils/pluralizer.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../domain/auth/auth_util.dart';
import '../models/dataform_model.dart';

class DataFormController extends GetxController {
  TextEditingController lastNameController = TextEditingController();

  TextEditingController pluralLastNameController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController fathersNameController = TextEditingController();

  TextEditingController birthPlaceController = TextEditingController();

  TextEditingController birthdayController = TextEditingController();

  TextEditingController activityController = TextEditingController();

  TextEditingController socMediaController = TextEditingController();

  TextEditingController hobbiesController = TextEditingController();

  TextEditingController fathersFullNameController = TextEditingController();

  TextEditingController fathersNationalityController = TextEditingController();

  TextEditingController mothersFullNameController = TextEditingController();

  TextEditingController mothersNationalityController = TextEditingController();

  Rx<DataFormModel> dataformModelObj = DataFormModel().obs;

  SelectionPopupModel? gender;

  Timer? _debounce;

  String? photoUrlLocal, photoUrl;

  File? photoFile;

  DateTime? birthday;

  // List<String>? cities;

  List<SearchFieldListItem<Object?>> activitiesSuggestions = [],
      hobbiesSuggestions = [];

  List<String> tags = [],
      activities = [],
      hobbies = [],
      selectedActivities = [],
      selectedHobbies = [],
      maleNationalities = [],
      femaleNationalities = [],
      cities = [];

  City? selectedCity;

  List<SearchFieldListItem> citiesSuggestions = [],
      maleNationalitiesSuggestions = [],
      femaleNationalitiesSuggestions = [];

  final formKey = GlobalKey<FormState>();

  // GlobalKey<DropdownSearchState<String>> activitiesDropdownKey =
  //     GlobalKey<DropdownSearchState<String>>();

  // GlobalKey<DropdownSearchState<String>> hobbiesDropdownKey =
  //     GlobalKey<DropdownSearchState<String>>();

  onPluralLastNameTapped() {
    if (lastNameController.text.isNotEmpty) {
      pluralLastNameController.text =
          Pluralizer().pluralizeRussianSurname(lastNameController.text);
    }
    update();
  }

  birthdayPicker() async {
    DateTime? date = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorConstant.lime800,
            ),
          ),
          child: child!,
        );
      },
      context: Get.context!,
      initialDate: DateTime.now().subtract(
        Duration(days: 365 * 6),
      ),
      firstDate: DateTime.now().subtract(
        Duration(days: 365 * 100),
      ),
      lastDate: DateTime.now().subtract(
        Duration(days: 365 * 6),
      ),
    );

    if (date != null) {
      birthday = date;
      birthdayController.value =
          TextEditingValue(text: DateFormat('dd.MM.yyyy').format(birthday!));
    }
    update();
  }

  pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      photoUrlLocal = image.path;
      photoFile = File(image.path);
      update();
    }
  }

  List<SearchFieldListItem> getCities(List<String>? cities) {
    if (cities != null && cities.isNotEmpty) {
      return cities
          .map(
            (city) => SearchFieldListItem(
              city,
              item: city,
            ),
          )
          .toList();
    }
    return [];
  }

  onBirthplaceSuggestionTap(
      SearchFieldListItem<Object?> searchFieldListItem) async {
    String currentText = birthPlaceController.text.split(',').first;
    birthPlaceController.value = TextEditingValue(
      text: searchFieldListItem.item.toString(),
    );

    var tempCities = await ApiClient().queryCities(currentText);
    cities = tempCities.cast<String>();
    update();
  }

  onSearchChanged() async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 1000),
      () async {
        String query = birthPlaceController.text;
        if (query.isEmpty) {
          citiesSuggestions = [];
        } else {
          printInfo(info: "Working");
          var tempCities = await ApiClient().queryCities(query);
          tempCities = tempCities.cast<String>();
          citiesSuggestions = getCities(tempCities);
          printInfo(info: cities.toString());
        }
        update();
      },
    );
  }

  getActivitiesAndHobbies() async {
    Map<String, dynamic>? data = await ApiClient().getActivitiesAndHobbies();
    if (data != null && data.isNotEmpty && data['error'] == null) {
      List activitiesList = data['activities'];
      List hobbiesList = data['hobbies'];
      activities = activitiesList.cast<String>();
      activities.sort();

      hobbies = hobbiesList.cast<String>();
      hobbies.sort();

      final box = GetStorage();

      box.write(kActivitiesKey, activities);
      box.write(kHobbiesKey, hobbies);
      update();
    }
  }

  getNationalities() async {
    Map<String, dynamic> nationalities = await ApiClient().getNationalities();
    maleNationalities = nationalities['maleNationalities'].cast<String>() ?? [];
    femaleNationalities =
        nationalities['femaleNationalities'].cast<String>() ?? [];
    maleNationalities.sort();
    femaleNationalities.sort();
    maleNationalitiesSuggestions = maleNationalities
        .map(
          (nationality) => SearchFieldListItem(
            nationality,
            item: nationality,
          ),
        )
        .toList();
    femaleNationalitiesSuggestions = femaleNationalities
        .map(
          (nationality) => SearchFieldListItem(
            nationality,
            item: nationality,
          ),
        )
        .toList();
    update();
  }

  onActivitiesChanged(List list) {
    selectedActivities = list.cast<String>();
    update();
  }

  onHobbiesChanged(List list) {
    selectedHobbies = list.cast<String>();
    update();
  }

  showSnackbar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        duration: Duration(seconds: 5),
      ),
    );
  }

  onFormSubmitted() async {
    await showOverlay(asyncFunction: () async {
      try {
        if (formKey.currentState != null && formKey.currentState!.validate()) {
          if (gender == null) {
            showSnackbar('Выберите свой пол');
            return;
          }
          if (birthday == null) {
            showSnackbar('Выберите дату рождения');
            return;
          }
          if (photoUrlLocal == null && photoFile == null) {
            showSnackbar('Выберите изображение профиля');
            return;
          } else {
            // if (photoUrlLocal != null) photoUrl = photoUrlLocal;

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
          if (birthPlaceController.text.isEmpty) {
            showSnackbar('Выберите место рождения');
            return;
          }
          String birthplace = birthPlaceController.text.split(',').first;
          List<String> tagsGenerated = createTags(
            birthplace,
            firstNameController.text,
            lastNameController.text,
            fathersNationalityController.text,
            [...selectedHobbies, ...selectedActivities],
          );
          String displayName =
              "${firstNameController.text} ${lastNameController.text}";

          final usersUpdateData = {
            ...createUsersRecordData(
              displayName: displayName,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              gender: gender!.title,
              birthday: birthday,
              birthdayPlace: birthplace,
              name: firstNameController.text,
              photoUrl: photoUrl,
              fatherFio: fathersFullNameController.text,
              motherFio: mothersFullNameController.text,
              fatherNationality: fathersNationalityController.text,
              motherNationality: mothersNationalityController.text,
              createdTime: DateTime.now(),
              lastRatingUpdated: DateTime.now(),
              socialLink: socMediaController.text,
              rating: 100,
            ),
            'tags': tagsGenerated,
          };

          GetStorage box = GetStorage();

          box.write(
              'userData',
              jsonEncode(
                {
                  'tags': tagsGenerated,
                  'displayName': displayName,
                  'lastName': lastNameController.text,
                  'birthPlace': birthplace,
                },
              ));

          printInfo(info: currentUserReference?.id.toString() ?? "Didn't work");
          await currentUserReference!.update(usersUpdateData);
          await FirebaseAuth.instance.currentUser!
              .updateDisplayName(displayName);

          Get.offAndToNamed(
            AppRoutes.dataProcessingScreen,
            arguments: [
              {
                'tags': tagsGenerated,
                'displayName':
                    "${firstNameController.text} ${lastNameController.text}",
                'lastName': lastNameController.text,
                'birthPlace': birthplace,
              }
            ],
          );
        } else {
          showSnackbar('Заполните все поля');
        }
      } catch (e) {
        printError(info: e.toString());
        showSnackbar('Что-то пошло не так');
        return;
      }
    });
  }

  Future init() async {
    // await getCities();

    birthPlaceController.addListener(onSearchChanged);
    await getActivitiesAndHobbies();
    await getNationalities();
    Map<String, dynamic>? userData = Get.arguments?[0];
    if (userData != null) {
      if (userData['firstName'] != null)
        firstNameController.value = TextEditingValue(
          text: userData['firstName'],
        );
      if (userData['lastName'] != null)
        lastNameController.value = TextEditingValue(
          text: userData['lastName'],
        );
      if (userData['photoUrl'] != null) photoUrl = userData['photoUrl'];
      if (userData['gender'] != null) onSelected(userData['gender']);
      update();
    }
  }

  @override
  void onReady() async {
    showOverlay(asyncFunction: init);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    lastNameController.dispose();
    firstNameController.dispose();
    fathersNameController.dispose();
    birthPlaceController.dispose();
    birthdayController.dispose();
    activityController.dispose();
    hobbiesController.dispose();
    fathersFullNameController.dispose();
    fathersNationalityController.dispose();
    mothersFullNameController.dispose();
    mothersNationalityController.dispose();
    _debounce?.cancel();
  }

  onSelected(dynamic value) {
    gender = value as SelectionPopupModel;
    dataformModelObj.value.genderDropdownItemList.forEach((element) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    });
    dataformModelObj.value.genderDropdownItemList.refresh();
  }
}
