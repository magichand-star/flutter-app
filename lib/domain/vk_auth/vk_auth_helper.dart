import 'package:flutter_login_vk/flutter_login_vk.dart';

class VKAuthHelper {
  static String clientId = '51508339';
  static late VKLogin vk;

  init() async {
    vk = VKLogin();
    await vk.initSdk();
  }

  login() async {
    final res = await vk.logIn(
      scope: [
        VKScope.email,
        VKScope.friends,
      ],
    );

// Check result
    if (res.isValue) {
      // There is no error, but we don't know yet
      // if user loggen in or not.
      // You should check isCanceled
      final VKLoginResult? data = res.asValue?.value;
      if (data != null) {
        if (data.isCanceled) {
          return null;
        } else {
          // debugger();
          // Send access token to server for validation and auth
          final VKAccessToken? accessToken = data.accessToken;
          print('Access token: ${accessToken?.token}');

          // Get profile data
          final profile = await vk.getUserProfile();
          VKUserProfile? userProfile = profile.asValue?.value;
          if (userProfile != null) {
            print(
                'Hello, ${userProfile.firstName}! You ID: ${userProfile.userId}');
          }
          // Get email (since we request email permissions)
          final email = await vk.getUserEmail();
          print('And your email is $email');
          return userProfile;
        }
      }
    } else {
      // Log in failed
      final errorRes = res.asError;
      print('Error while log in: ${errorRes!.error}');
      return null;
    }
  }
}
