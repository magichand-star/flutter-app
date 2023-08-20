import 'dart:developer';

import 'package:monarchium/backend/backend.dart';
import 'package:monarchium/core/utils/user_activity.dart';
import 'package:monarchium/domain/auth/auth_util.dart';

class RatingController {
  static int rating = 0;

  initRating() async {
    UsersRecord? userDoc;

    if (currentUserDocument == null) {
      userDoc = await initCurrentUserDocument();
    } else {
      userDoc = currentUserDocument;
    }

    rating = userDoc?.rating ?? 100;
    applyRules();
    // print(rating);
  }

  updateRating(int amount, [UsersRecord? user]) async {
    DocumentReference userReference = user?.reference ?? currentUserReference!;

    if (user != null)
      print(user.uid);
    else
      rating += amount;

    final updateData = {
      'rating': rating,
    };

    await maybeUpdateUser(userReference, updateData);
    log('Updated rating: $rating');
  }

  applyRules() async {
    if (UserActivity.isFirstMonth) {
      await firstMonthRules();
    }
    if (UserActivity.isSecondMonth) {
      await secondMonthRules();
    }
    if (UserActivity.thirdMonthCondition) {
      await thirdMonthRules();
    }
  }

  firstMonthRules() async {
    if (UserActivity.daysFromLastRatingUpdated! >= 1 &&
        UserActivity.daysFromCreated != 0) {
      updateRating(10);
      UserActivity userActivity = UserActivity();

      await userActivity.updateLastRatingUpdated();
      await userActivity.updateDays();
    }
  }

  secondMonthRules() async {
    if (UserActivity.daysFromLastRatingUpdated! >= 1) {
      await updateRating(1);
      UserActivity userActivity = UserActivity();

      await userActivity.updateLastRatingUpdated();
      await userActivity.updateDays();
    }
  }

  thirdMonthRules() async {
    updateRating(3);
    UserActivity userActivity = UserActivity();

    await userActivity.updateLastRatingUpdated();
    await userActivity.updateDays();
  }
}
