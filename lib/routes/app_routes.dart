import '../presentation/chats/binding/chats_binding.dart';
import '../presentation/chats/chats_screen.dart';
import '../presentation/edit_profile_screen/binding/edit_profile_binding.dart';
import '../presentation/edit_profile_screen/edit_profile_screen.dart';
import '../presentation/error_page/binding/error_page_binding.dart';
import '../presentation/error_page/error_page.dart';
import '../presentation/home_screen/binding/home_screen_binding.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/splash_screen_screen/splash_screen_screen.dart';
import '../presentation/splash_screen_screen/binding/splash_screen_binding.dart';
import '../presentation/onboarding_screen/onboarding_screen.dart';
import '../presentation/onboarding_screen/binding/onboarding_binding.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/registration_screen/binding/registration_binding.dart';
import '../presentation/authorization_screen/authorization_screen.dart';
import '../presentation/authorization_screen/binding/authorization_binding.dart';
import '../presentation/data_form_screen/data_form_screen.dart';
import '../presentation/data_form_screen/binding/dataform_binding.dart';
import '../presentation/data_processing_screen/data_processing_screen.dart';
import '../presentation/data_processing_screen/binding/data_processing_binding.dart';
import '../presentation/emblem_generation_screen/emblem_generation_screen.dart';
import '../presentation/emblem_generation_screen/binding/emblemgeneration_binding.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/profile_screen/binding/profile_binding.dart';
import '../presentation/general_armses_screen/general_armses_screen.dart';
import '../presentation/general_armses_screen/binding/general_armses_binding.dart';
import '../presentation/friend_search_screen/friend_search_screen.dart';
import '../presentation/friend_search_screen/binding/friend_search_binding.dart';
import '../presentation/friends_screen/friends_screen.dart';
import '../presentation/friends_screen/binding/friends_binding.dart';
import '../presentation/join_association_screen/join_association_screen.dart';
import '../presentation/join_association_screen/binding/join_association_binding.dart';
import '../presentation/create_association_screen/create_association_screen.dart';
import '../presentation/create_association_screen/binding/create_association_binding.dart';
import '../presentation/association_profile_screen/association_profile_screen.dart';
import '../presentation/association_profile_screen/binding/associationprofile_binding.dart';
import '../presentation/associations_screen/associations_screen.dart';
import '../presentation/associations_screen/binding/associations_binding.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String splashScreen = '/splash_screen';

  static String onboardingScreen = '/onboarding_screen';

  static String registrationScreen = '/registration_screen';

  static String authorizationScreen = '/authorization_screen';

  static String dataFormScreen = '/dataform_screen';

  static String dataProcessingScreen = '/dataprocessing_screen';

  static String emblemGenerationScreen = '/emblem_generation_screen';

  static String profileScreen = '/profile_screen';

  static String generalArmsesScreen = '/general_armses_screen';

  static String searchScreen = '/search_screen';

  static String friendsScreen = '/friends_screen';

  static String joinAssociationScreen = '/join_association_screen';

  static String createAssociationScreen = '/create_association_screen';

  static String associationProfileScreen = '/association_profile_screen';

  static String associationsScreen = '/associations_screen';

  static String appNavigationScreen = '/app_navigation_screen';

  static String homeScreen = '/home_screen';

  static String chatsScreen = '/chats_screen';

  static String editProfileScreen = '/edit_profile_screen';

  static String errorPage = '/error_page';

  static String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreenScreen(),
      bindings: [
        SplashScreenBinding(),
      ],
    ),
    GetPage(
      name: onboardingScreen,
      page: () => OnboardingScreen(),
      bindings: [
        OnboardingBinding(),
      ],
    ),
    GetPage(
      name: registrationScreen,
      page: () => RegistrationScreen(),
      bindings: [
        RegistrationBinding(),
      ],
    ),
    GetPage(
      name: authorizationScreen,
      page: () => AuthorizationScreen(),
      bindings: [
        AuthorizationBinding(),
      ],
    ),
    GetPage(
      name: dataFormScreen,
      page: () => DataFormScreen(),
      bindings: [
        DataformBinding(),
      ],
    ),
    GetPage(
      name: dataProcessingScreen,
      page: () => DataProcessingScreen(),
      bindings: [
        DataprocessingBinding(),
      ],
    ),
    GetPage(
      name: emblemGenerationScreen,
      page: () => EmblemGenerationScreen(),
      bindings: [
        EmblemGenerationBinding(),
      ],
    ),
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
      bindings: [
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: generalArmsesScreen,
      page: () => GeneralArmsesScreen(),
      bindings: [
        GeneralArmsesBinding(),
      ],
    ),
    GetPage(
      name: searchScreen,
      page: () => FriendSearchScreen(),
      bindings: [
        FriendSearchBinding(),
      ],
    ),
    GetPage(
      name: friendsScreen,
      page: () => FriendsScreen(),
      bindings: [
        FriendsBinding(),
      ],
    ),
    GetPage(
      name: joinAssociationScreen,
      page: () => JoinAssociationScreen(),
      bindings: [
        JoinAssociationBinding(),
      ],
    ),
    GetPage(
      name: createAssociationScreen,
      page: () => CreateAssociationScreen(),
      bindings: [
        CreateAssociationBinding(),
      ],
    ),
    GetPage(
      name: associationProfileScreen,
      page: () => AssociationProfileScreen(),
      bindings: [
        AssociationProfileBinding(),
      ],
    ),
    GetPage(
      name: associationsScreen,
      page: () => AssociationsScreen(),
      bindings: [
        AssociationsBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: chatsScreen,
      page: () => ChatsScreen(),
      bindings: [
        ChatsBinding(),
      ],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      bindings: [
        HomeScreenBinding(),
      ],
    ),
    GetPage(
      name: editProfileScreen,
      page: () => EditProfileScreen(),
      bindings: [
        EditProfileBinding(),
      ],
    ),
    GetPage(
      name: errorPage,
      page: () => ErrorPage(),
      bindings: [
        ErrorPageBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreenScreen(),
      bindings: [
        SplashScreenBinding(),
      ],
    )
  ];
}
