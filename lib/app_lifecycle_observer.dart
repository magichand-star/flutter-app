import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'core/utils/rating_controller.dart';
import 'core/utils/user_activity.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final RatingController ratingController = RatingController();
  final UserActivity userActivity = UserActivity();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (FirebaseAuth.instance.currentUser != null) {
      if (state == AppLifecycleState.paused ||
          state == AppLifecycleState.inactive) {
        // The app is in the background or inactive.
        // Call your functions here.
        print('App is in the background or inactive');
        userActivity.updateLastEntered();
        userActivity.setIsOnlineFalse();
        ratingController.applyRules();
      } else if (state == AppLifecycleState.resumed) {
        userActivity.setIsOnlineTrue();
      } else if (state == AppLifecycleState.detached) {
        userActivity.setIsOnlineTrue();
      }
    }
  }
}
