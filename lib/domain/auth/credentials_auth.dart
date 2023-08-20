import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_util.dart';

Future<User?> signInWithCredentials(
  BuildContext context, {
  required String providerId,
  required String signInMethod,
}) async {
  final signInFunc =
      () => FirebaseAuth.instance.signInWithCredential(AuthCredential(
            providerId: providerId,
            signInMethod: signInMethod,
          ));
  return signInOrCreateAccount(context, signInFunc, signInMethod);
}
