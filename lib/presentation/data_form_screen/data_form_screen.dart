import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_button.dart';
import 'controller/data_form_controller.dart';
import 'widgets/attach_photo_field.dart';
import 'widgets/title_dropdown.dart';
import 'widgets/title_text_form_field.dart';

class DataFormScreen extends StatefulWidget {
  const DataFormScreen({super.key});

  @override
  State<DataFormScreen> createState() => _DataFormScreenState();
}

class _DataFormScreenState extends State<DataFormScreen> {
  GlobalKey<DropdownSearchState> activitiesDropdownKey =
      GlobalKey<DropdownSearchState>();

  GlobalKey<DropdownSearchState> hobbiesDropdownKey =
      GlobalKey<DropdownSearchState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.deepOrange50,
        body: GetBuilder<DataFormController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: getHorizontalSize(
                                261.00,
                              ),
                              margin: getMargin(
                                left: 15,
                                top: 16,
                                right: 15,
                              ),
                              child: Text(
                                "msg11".tr,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: AppStyle.txtPoiretOneRegular32,
                              ),
                            ),
                            Padding(
                              padding: getPadding(
                                left: 15,
                                top: 16,
                                right: 15,
                              ),
                              child: Text(
                                "msg12".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtCormorantRomanRegular20,
                              ),
                            ),
                            AttachPhotoField(
                              photoUrl: controller.photoUrlLocal,
                              photoFile: controller.photoFile,
                              onTap: () async => controller.pickImage(),
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.lastNameController,
                              titleString: "lbl13".tr,
                              hintString: "lbl14".tr,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.firstNameController,
                              titleString: "lbl15".tr,
                              hintString: "lbl16".tr,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.fathersNameController,
                              titleString: "lbl17".tr,
                              hintString: "lbl18".tr,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                            TitleDropDown(
                              items: controller.dataformModelObj.value
                                  .genderDropdownItemList,
                              onChanged: controller.onSelected,
                              titleString: "lbl19".tr,
                              hintString: "lbl20".tr,
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.birthPlaceController,
                              titleString: "lbl21".tr,
                              hintString: "lbl22".tr,
                              keyboardType: TextInputType.text,
                              isSearchField: true,
                              suggestions: controller.citiesSuggestions,
                              onSuggestionTap:
                                  controller.onBirthplaceSuggestionTap,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                if (!controller.cities.contains(val)) {
                                  return 'Выберите город из списка';
                                }
                                return null;
                              },
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.birthdayController,
                              readOnly: true,
                              onTap: controller.birthdayPicker,
                              titleString: "Дата рождения".tr,
                              hintString: "Например 01.10.1977".tr,
                            ),
                            TitleTextFormField(
                              maxLength: 3,
                              textEditingController:
                                  controller.activityController,
                              // onSuggestionTap:
                              //     controller.onActivitiesSuggestionTap,
                              titleString: "msg13".tr,
                              hintString: "msg14".tr,
                              isDropdownSearch: true,
                              dropdownItems: controller.activities,
                              dropdownKey: activitiesDropdownKey,

                              onDropdownChanged: controller.onActivitiesChanged,
                              // dropdownSelectedItems:
                              //     controller.selectedActivities,
                              // onDropdownChanged: controller.onActivitiesChanged,
                              dropdownValidator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Поле обязательно';
                                }
                                return null;
                              },
                              // isSearchField: true,
                              // suggestions: controller.activitiesSuggestions,
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.socMediaController,
                              titleString: "msg15".tr,
                              hintString: "msg_https".tr,
                              keyboardType: TextInputType.url,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                String url = val!;
                                if (!isURL(url)) {
                                  return 'Необходима ссылка на соц.сеть';
                                }

                                return null;
                              },
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.hobbiesController,
                              titleString: "msg16".tr,
                              hintString: "msg17".tr,
                              dropdownSelectedItems: controller.selectedHobbies,
                              onDropdownChanged: controller.onHobbiesChanged,
                              dropdownKey: hobbiesDropdownKey,
                              dropdownValidator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Поле обязательно';
                                }
                                return null;
                              },
                              maxLength: 5,
                              isDropdownSearch: true,
                              dropdownItems: controller.hobbies,
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.fathersFullNameController,
                              titleString: "lbl23".tr,
                              hintString: "msg18".tr,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                return null;
                              },
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.fathersNationalityController,
                              isSearchField: true,
                              suggestions:
                                  controller.maleNationalitiesSuggestions,
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                if (!controller.maleNationalities
                                    .contains(val)) {
                                  return 'Выберите национальность из списка';
                                }
                                return null;
                              },
                              titleString: "msg19".tr,
                              hintString: "msg20".tr,
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.mothersFullNameController,
                              titleString: "lbl24".tr,
                              hintString: "msg21".tr,
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                return null;
                              },
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.mothersNationalityController,
                              isSearchField: true,
                              suggestions:
                                  controller.femaleNationalitiesSuggestions,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                if (!controller.femaleNationalities
                                    .contains(val)) {
                                  return 'Выберите национальность из списка';
                                }
                                return null;
                              },
                              titleString: "msg22".tr,
                              hintString: "msg23".tr,
                            ),
                            TitleTextFormField(
                              textEditingController:
                                  controller.pluralLastNameController,
                              titleString: "Фамилия во множественном числе".tr,
                              hintString: "",
                              onTap: controller.onPluralLastNameTapped,
                              validator: (val) {
                                if (!isFilled(val)) {
                                  return 'Поле обязательно';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                            ),
                            CustomButton(
                              width: 345,
                              onTap: controller.onFormSubmitted,
                              text: "lbl25".tr,
                              margin: getMargin(
                                left: 15,
                                top: 20,
                                right: 15,
                                bottom: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
