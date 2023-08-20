import 'package:get/get.dart';
import 'associations_item_model.dart';

class AssociationsModel {
  RxList<AssociationsItemModel> associationsItemList =
      RxList.filled(5, AssociationsItemModel());
}
