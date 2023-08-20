import 'dart:developer';

import '../../backend/backend.dart';
import '../../domain/auth/auth_util.dart';

class UserActivity {
  static DateTime? lastRatingUpdated;
  static DateTime? lastEntered;
  static int? daysFromLastRatingUpdated;
  static int? daysFromCreated;
  static UsersRecord? userDoc;

  static bool get isFirstMonth => daysFromCreated! < 31;
  static bool get isSecondMonth =>
      daysFromCreated! < 61 && daysFromCreated! > 30;
  static bool get isThirdMonth =>
      (daysFromCreated! < 91 && daysFromCreated! > 60);
  static bool get thirdMonthCondition =>
      isThirdMonth &&
      DateTime.now().difference(lastEntered!).inDays < 21 &&
      DateTime.now().difference(lastRatingUpdated!).inDays > 30;

  init() async {
    await setCurrentUser();
    // debugger();
    if (userDoc!.lastEntered != null) {
      lastEntered = DateTime.fromMicrosecondsSinceEpoch(
          userDoc!.lastEntered!.microsecondsSinceEpoch);
    }
    if (userDoc!.lastRatingUpdated == null) {
      await updateLastRatingUpdated();
    } else {
      lastRatingUpdated = DateTime.fromMicrosecondsSinceEpoch(
          userDoc!.lastRatingUpdated!.microsecondsSinceEpoch);
    }

    log(lastRatingUpdated.toString());
    updateDays();
  }

  setCurrentUser() async {
    if (currentUserDocument == null) {
      userDoc = await initCurrentUserDocument();
    } else {
      userDoc = currentUserDocument;
    }
  }

  updateDays() {
    daysFromCreated = DateTime.now().difference(userDoc!.createdTime!).inDays;
    daysFromLastRatingUpdated =
        DateTime.now().difference(lastRatingUpdated!).inDays;
    log(daysFromCreated.toString());
    log(daysFromLastRatingUpdated.toString());
  }

  updateLastRatingUpdated() async {
    DocumentReference? userReference;
    if (currentUserReference != null) {
      userReference = currentUserReference!;
    } else {
      UsersRecord? userRecord = await initCurrentUserDocument();
      userReference = userRecord?.reference;
    }
    await maybeUpdateUser(
      userReference!,
      {
        'last_rating_updated': DateTime.now(),
      },
    );

    lastRatingUpdated = DateTime.now();
  }

  updateLastEntered() async {
    DocumentReference? userReference;
    if (currentUserReference != null) {
      userReference = currentUserReference!;
    } else {
      UsersRecord? userRecord = await initCurrentUserDocument();
      userReference = userRecord?.reference;
    }
    lastEntered = DateTime.now();
    await maybeUpdateUser(
      userReference!,
      {
        'last_entered': lastEntered,
      },
    );
    log('Last entered updated to $lastEntered');
  }

  // Updates the user's isOnline status to true
  Future<void> setIsOnlineTrue() async {
    DocumentReference? userReference;
    if (currentUserReference != null) {
      userReference = currentUserReference!;
    } else {
      UsersRecord? userRecord = await initCurrentUserDocument();
      userReference = userRecord?.reference;
    }
    await maybeUpdateUser(
      userReference!,
      {
        'is_online': true,
      },
    );
  }

  // Updates the user's isOnline status to false
  Future<void> setIsOnlineFalse() async {
    DocumentReference? userReference;
    if (currentUserReference != null) {
      userReference = currentUserReference!;
    } else {
      UsersRecord? userRecord = await initCurrentUserDocument();
      userReference = userRecord?.reference;
    }
    await maybeUpdateUser(
      userReference!,
      {
        'is_online': false,
      },
    );
  }

  int getMonthsSinceCreation(DateTime createdDate) {
    // DateTime createdDate =
    //     DateTime.fromMicrosecondsSinceEpoch(createdAt.microsecondsSinceEpoch);
    DateTime now = DateTime.now();

    return ((now.year - createdDate.year) * 12) + now.month - createdDate.month;
  }
}
