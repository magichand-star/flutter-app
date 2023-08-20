import 'package:get/get.dart';
import 'package:monarchium/data/models/selectionPopupModel/selection_popup_model.dart';

class DataFormModel {
  RxList<SelectionPopupModel> genderDropdownItemList = [
    SelectionPopupModel(
      id: 1,
      title: "Мужской",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 2,
      title: "Женский",
    ),
  ].obs;
}
