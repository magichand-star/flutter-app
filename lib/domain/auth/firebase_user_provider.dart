import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MonarchiumFirebaseUser {
  MonarchiumFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

MonarchiumFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MonarchiumFirebaseUser> monarchiumFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MonarchiumFirebaseUser>(
      (user) {
        currentUser = MonarchiumFirebaseUser(user);
        return currentUser!;
      },
    );
