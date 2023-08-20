import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../backend/backend.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/custom_functions.dart';
import '../../../domain/auth/auth_util.dart';
import '../../../widgets/emblem/emblem_widget.dart';
import '../../association_profile_screen/association_profile_screen.dart';
import '../../association_profile_screen/binding/associationprofile_binding.dart';
import '../../associations_screen/associations_screen.dart';
import '../../associations_screen/binding/associations_binding.dart';
import '../../chats/binding/chats_binding.dart';
import '../../chats/chats_screen.dart';
import '../../create_association_screen/binding/create_association_binding.dart';
import '../../create_association_screen/create_association_screen.dart';
import '../../emblem_generation_screen/binding/emblemgeneration_binding.dart';
import '../../emblem_generation_screen/controller/emblem_generation_controller.dart';
import '../../emblem_generation_screen/emblem_generation_screen.dart';
import '../../error_page/binding/error_page_binding.dart';
import '../../error_page/error_page.dart';
import '../../friend_search_screen/binding/friend_search_binding.dart';
import '../../friend_search_screen/friend_search_screen.dart';
import '../../friends_screen/binding/friends_binding.dart';
import '../../friends_screen/friends_screen.dart';
import '../../general_armses_screen/binding/general_armses_binding.dart';
import '../../general_armses_screen/general_armses_screen.dart';
import '../../join_association_screen/binding/join_association_binding.dart';
import '../../join_association_screen/join_association_screen.dart';
import '../../profile_screen/binding/profile_binding.dart';
import '../../profile_screen/controller/profile_controller.dart';
import '../../profile_screen/profile_screen.dart';

class HomeScreenController extends GetxController {
  var currentIndex = 0;

  GlobalKey<NavigatorState>? getKey = Get.nestedKey(1);

  List<GeneratedEmblems>? emblems;

  EmblemType? emblemType;

  final pages = <String>[
    AppRoutes.generalArmsesScreen,
    AppRoutes.emblemGenerationScreen,
    AppRoutes.profileScreen
  ];

  // List<GlobalKey<NavigatorState>> keys =
  //     List.generate(3, (_) => GlobalKey<NavigatorState>());

  // GlobalKey<NavigatorState>? get getKey => keys[currentIndex];

  void changePage(int index) async {
    if (index != currentIndex) {
      currentIndex = index;
      switch (index) {
        case 0:
          getKey?.currentState!
              .pushReplacementNamed(AppRoutes.generalArmsesScreen);
          break;
        case 1:
          getKey?.currentState!
              .pushReplacementNamed(AppRoutes.emblemGenerationScreen);
          await setEmblems();
          break;
        case 2:
          getKey?.currentState!.pushReplacementNamed(AppRoutes.profileScreen);
          break;
        default:
          break;
      }
    }

    update();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.generalArmsesScreen)
      return GetPageRoute(
        settings: settings,
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: GeneralArmsesScreen(),
        ),
        binding: GeneralArmsesBinding(),
        transition: Transition.noTransition,
      );

    if (settings.name == AppRoutes.emblemGenerationScreen)
      return GetPageRoute(
        settings: settings,
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: EmblemGenerationScreen(),
        ),
        binding: EmblemGenerationBinding(),
        transition: Transition.noTransition,
      );

    if (settings.name == AppRoutes.profileScreen)
      return GetPageRoute(
        settings: settings,
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: ProfileScreen(),
        ),
        binding: ProfileBinding(),
        transition: Transition.noTransition,
      );
    if (settings.name == AppRoutes.friendsScreen)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: FriendsScreen(),
        ),
        transition: Transition.noTransition,
        binding: FriendsBinding(),
        settings: settings,
      );
    if (settings.name == AppRoutes.searchScreen)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: FriendSearchScreen(),
        ),
        transition: Transition.noTransition,
        binding: FriendSearchBinding(),
        settings: settings,
      );
    if (settings.name == AppRoutes.createAssociationScreen)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: CreateAssociationScreen(),
        ),
        transition: Transition.noTransition,
        binding: CreateAssociationBinding(),
        settings: settings,
      );
    if (settings.name == AppRoutes.joinAssociationScreen)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: JoinAssociationScreen(),
        ),
        transition: Transition.noTransition,
        binding: JoinAssociationBinding(),
        settings: settings,
      );
    if (settings.name == AppRoutes.associationProfileScreen)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: AssociationProfileScreen(),
        ),
        transition: Transition.noTransition,
        binding: AssociationProfileBinding(),
        settings: settings,
      );
    if (settings.name == AppRoutes.associationsScreen)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: AssociationsScreen(),
        ),
        transition: Transition.noTransition,
        binding: AssociationsBinding(),
        settings: settings,
      );
    if (settings.name == AppRoutes.errorPage)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: ErrorPage(),
        ),
        transition: Transition.noTransition,
        binding: ErrorPageBinding(),
        settings: settings,
      );
    if (settings.name == AppRoutes.chatsScreen)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: ChatsScreen(),
        ),
        transition: Transition.noTransition,
        binding: ChatsBinding(),
        settings: settings,
      );
    if (settings.name == AppRoutes.errorPage)
      return GetPageRoute(
        page: () => WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: ErrorPage(),
        ),
        transition: Transition.noTransition,
        binding: ErrorPageBinding(),
        settings: settings,
      );
    return null;
  }

  setEmblems() async {
    UsersRecord? usersRecord =
        currentUserDocument ?? await initCurrentUserDocument();

    if (Get.arguments == null) {
      emblems = usersRecord?.generatedEmblems?.toList() ?? [];
      emblemType = stringToEmblemType(usersRecord?.emblemType.toString());
    } else {
      emblems = Get.arguments.first['emblems']
          .map((e) => GeneratedEmblems.fromJson(jsonEncode(e)))
          .cast<GeneratedEmblems>()
          .toList();
      // debugger();
      emblemType = Get.arguments.first['emblemType'];
      // emblemType = stringToEmblemType(typeTemp.toString());
    }
    printInfo(info: 'Emblem Type: $emblemType');
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => EmblemGenerationController());
    ProfileController profileController = Get.find<ProfileController>();
    EmblemGenerationController emblemGenerationController =
        Get.find<EmblemGenerationController>();

    profileController.emblemType = emblemType;
    emblemGenerationController.emblems = emblems;
    emblemGenerationController.emblemType = emblemType;
    emblemGenerationController.update();
  }

  @override
  void onReady() async {
    await showOverlay(asyncFunction: () async {
      await setEmblems();
      changePage(1);
    });

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
