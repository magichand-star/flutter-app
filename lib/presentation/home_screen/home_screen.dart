import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import 'controller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            //Checks if current Navigator still has screens on the stack.
            if (controller.getKey!.currentState!.canPop()) {
              // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
              //If no other WillPopScope exists, it returns true
              controller.getKey!.currentState!.maybePop();
              return Future<bool>.value(false);
            }
            return Future<bool>.value(true);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Navigator(
              key: controller.getKey,
              initialRoute: AppRoutes.generalArmsesScreen,
              onGenerateRoute: controller.onGenerateRoute,
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: ColorConstant.deepOrange50,
              // type: BottomNavigationBarType.shifting,
              fixedColor: ColorConstant.brown90,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: CutomBottomNavIcon(
                    showUnderline: controller.currentIndex == 0,
                    svgPath: ImageConstant.imgBottomNavBarIcon1,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: CutomBottomNavIcon(
                    showUnderline: controller.currentIndex == 1,
                    svgPath: ImageConstant.imgBottomNavBarIcon2,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: CutomBottomNavIcon(
                    showUnderline: controller.currentIndex == 2,
                    svgPath: ImageConstant.imgBottomNavBarIcon3,
                  ),
                  label: '',
                ),
              ],
              currentIndex: controller.currentIndex,
              // selectedItemColor: Colors.pink,
              onTap: controller.changePage,
            ),
          ),
        );
      },
    );
  }
}

class CutomBottomNavIcon extends StatelessWidget {
  const CutomBottomNavIcon({
    this.svgPath,
    this.showUnderline = false,
    Key? key,
  }) : super(key: key);

  final String? svgPath;
  final bool showUnderline;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonImageView(
          svgPath: svgPath,
          width: getHorizontalSize(50),
        ),
        if (showUnderline) BottomNavItemUnderline(),
      ],
    );
  }
}

class BottomNavItemUnderline extends StatelessWidget {
  const BottomNavItemUnderline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getHorizontalSize(60),
      child: Divider(
        indent: 0,
        endIndent: 0,
        height: 0,
        color: ColorConstant.brown90,
        thickness: 2,
      ),
    );
  }
}
