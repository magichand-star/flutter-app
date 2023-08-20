import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:monarchium/backend/backend.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/core/utils/custom_functions.dart';
import 'package:monarchium/domain/auth/auth_util.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/presentation/profile_screen/controller/profile_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:monarchium/backend/firebase_storage/storage.dart';

class EditProfileController extends GetxController {
  TextEditingController lastNameController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController fathersNameController = TextEditingController();

  TextEditingController birthdayController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController weburlController = TextEditingController();

  DateTime? birthday;

  String phoneNumber = '';

  String? photoUrlLocal, photoUrl;

  File? photoFile;

  UsersRecord? user;

  final RegExp regExpRu = RegExp(
      r'^(\+7|7)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$');
  final RegExp regExpBe = RegExp(
      r'^(\+375|375)?[\s\-]?\(29|25|44|33\)?[\s\-]?(\d{3})(\d{2})?[\s\-]?(\d{2})$');

  bool isValidRu = false, isValidBy = false;

  onPhoneChanged(String value) {
    phoneNumber = value;
    validateNumber();
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

  validateNumber() async {
    printInfo(info: phoneNumber);
    // debugger();
    if (phoneNumber.length == 11) {
      isValidRu = await PhoneNumberUtil.isValidPhoneNumber(
              phoneNumber: phoneNumber, isoCode: 'Ru') ??
          false;
      printInfo(info: isValidRu.toString());
    } else if (phoneNumber.length == 12) {
      isValidBy = await PhoneNumberUtil.isValidPhoneNumber(
              phoneNumber: phoneNumber, isoCode: 'BY') ??
          false;
      printInfo(info: isValidBy.toString());
    } else {
      if (isValidBy) isValidBy = false;
      if (isValidRu) isValidRu = false;
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

  initUserData() async {
    user = await initCurrentUserDocument();
    printInfo(info: user?.uid ?? "Not found");
    if (user != null) {
      photoUrlLocal = user!.photoUrl;
      lastNameController.value = TextEditingValue(text: user!.lastName ?? "");
      firstNameController.value = TextEditingValue(text: user!.firstName ?? "");
      fathersNameController.value =
          TextEditingValue(text: user!.fatherFio ?? "");
      birthdayController.value = TextEditingValue(
          text: user!.birthday != null
              ? DateFormat('dd.MM.yyyy').format(user!.birthday!)
              : "");
      birthday = user!.birthday;
      mobileNoController.value =
          TextEditingValue(text: user!.phoneNumber ?? "");
      emailController.value = TextEditingValue(text: user!.email ?? "");
      weburlController.value = TextEditingValue(text: user!.socialLink ?? "");
      emailController.value = TextEditingValue(text: user!.email ?? "");
    }
    update();
  }

  writeEmail() async {
    await launchUrlString('mailto:$kMonarchiumEmail?subject=Челобитная');
  }

  Future<void> updateUserData() async {
    Map<String, dynamic> data = {
      'last_name': lastNameController.text,
      'first_name': firstNameController.text,
      'father_fio': fathersNameController.text,
      'phone_number': mobileNoController.text,
      'email': emailController.text,
      'social_link': weburlController.text,
      'birthday': birthday,
    };

    nestedUpdate() async {
      await maybeUpdateUser(user!.reference, data);
      await initCurrentUserDocument();
      final profileController = Get.put<ProfileController>(ProfileController());
      profileController.update();
      Get.showSnackbar(
        GetSnackBar(
          message: 'Вы успешно обновили свои данные',
          duration: Duration(seconds: 3),
        ),
      );

      Get.toNamed(AppRoutes.profileScreen, id: 1);
    }

    if (user != null) {
      if (user?.birthday != birthday) {
        await nestedUpdate();
        return;
      }
      if (user?.lastName != lastNameController.text) {
        await nestedUpdate();
        return;
      }
      if (user?.firstName != firstNameController.text) {
        await nestedUpdate();
        return;
      }
      if (user?.fatherFio != fathersNameController.text) {
        await nestedUpdate();
        return;
      }
      if (user?.phoneNumber != mobileNoController.text) {
        await nestedUpdate();
        return;
      }
      if (user?.email != emailController.text) {
        await nestedUpdate();
        return;
      }
      if (user?.socialLink != weburlController.text) {
        await nestedUpdate();
        return;
      }
      if (photoFile != null) {
        if (FirebaseAuth.instance.currentUser != null)
          photoUrl = await uploadDataFromFile(
            'users/${FirebaseAuth.instance.currentUser!.uid}/uploads/${photoFile!.path.split('/').last}',
            photoFile!,
          );
        data['photo_url'] = photoUrl;
        if (photoUrl == null) {
          showSnackbar('Ошибка загрузки изображения');
          return;
        }
        await nestedUpdate();
        return;
      }
    }
    Get.showSnackbar(
      GetSnackBar(
        message: 'Вы не изменили свои данные',
        duration: Duration(seconds: 3),
      ),
    );
    return;
  }

  saveProfile() async {
    await showOverlay(
      asyncFunction: updateUserData,
    );
  }

  @override
  void onReady() async {
    await initUserData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    lastNameController.dispose();
    firstNameController.dispose();
    fathersNameController.dispose();
    birthdayController.dispose();
    mobileNoController.dispose();
    emailController.dispose();
    weburlController.dispose();
  }
}
