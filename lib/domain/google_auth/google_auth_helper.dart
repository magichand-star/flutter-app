import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/domain/auth/auth_util.dart';

class GoogleAuthHelper {
  /// Handle Google Signin to authenticate user
  Future<User?> googleSignInProcess() async {
    // GoogleSignIn _googleSignIn = GoogleSignIn(
    //   scopes: [
    //     'email',
    //     'https://www.googleapis.com/auth/contacts.readonly',
    //   ],
    // );
    return signInWithGoogle(Get.context!).then((User? googleUser) {
      if (googleUser != null) {
        return googleUser;
      }
      return null;
    });
  }

  /// To Check if the user is already signedin through google
  Future<bool> alreadySignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    bool alreadySignIn = await _googleSignIn.isSignedIn();
    return alreadySignIn;
  }

  /// To signout from the application if the user is signed in through google
  Future<GoogleSignInAccount?> googleSignOutProcess() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await _googleSignIn.signOut();

    return googleUser;
  }
}
