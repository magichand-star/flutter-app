import 'package:flutter/material.dart';
import 'package:monarchium/backend/backend.dart';
import 'package:monarchium/backend/schema/models/search_item_model.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/core/utils/custom_functions.dart';
import 'package:monarchium/domain/auth/auth_util.dart';
import 'package:monarchium/widgets/app_bar/appbar_image.dart';
import 'package:monarchium/widgets/app_bar/appbar_title.dart';
import 'package:monarchium/widgets/app_bar/custom_app_bar.dart';
import 'package:monarchium/widgets/search_list/search_item_widget.dart';

class AssociationProfileController extends GetxController {
  UsersRecord? currentUser;
  AssotiationsRecord? association;
  List<SearchItemModel> searchItemList = [];

  Future<void> init() async {
    currentUser = await initCurrentUserDocument();
    DocumentReference? associationRef = Get.arguments?[0];
    if (associationRef != null)
      association = await AssotiationsRecord.getDocumentOnce(associationRef);
    if (association == null) {
      Get.back(id: 1);
      showSnackbar('Возникла ошибка');
      return;
    }
    if (association?.users != null) {
      List<DocumentReference> usersRef = association!.users!.toList();

      for (var userRef in usersRef) {
        final userExists = await userRef.get().then((u) => u.exists);
        if (userExists) {
          UsersRecord user = await UsersRecord.getDocumentOnce(userRef);
          searchItemList.add(
            SearchItemModel.fromUsersRecord(
              user,
              false,
            ),
          );
        }
      }
    }
    update();
  }

  onShowMembers() async {
    await showDialog(
      context: Get.context!,
      builder: (context) => Scaffold(
        backgroundColor: ColorConstant.deepOrange50,
        appBar: CustomAppBar(
          height: getVerticalSize(62),
          styleType: Style.bgFillDeeporange50,
          title: Container(
            decoration: AppDecoration.fillDeeporange50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                AppbarImage(
                  height: getSize(25.00),
                  width: getSize(25.00),
                  svgPath: ImageConstant.imgArrowleftGray900,
                  margin: getMargin(left: 15, top: 18, bottom: 19),
                  onTap: () => Get.back(),
                ),
                SizedBox(
                  width: getHorizontalSize(context.width / 5),
                ),
                AppbarTitle(text: 'Участники')
              ],
            ),
          ),
          // centerTitle: true,
        ),
        body: Padding(
          padding: getPadding(left: 15),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchItemList.length,
            itemBuilder: (context, index) {
              SearchItemModel model = searchItemList[index];
              return SearchItemWidget(
                model: model,
                iconBool: model.isIn, hideIcon: true,
                // hideIcon: userInAssociation(index),
                onIconPressed: () {},
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void onReady() {
    showOverlay(asyncFunction: init);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
