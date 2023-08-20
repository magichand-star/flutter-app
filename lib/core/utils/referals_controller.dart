import 'package:monarchium/backend/backend.dart';
import 'package:monarchium/core/utils/custom_functions.dart';
import 'package:monarchium/core/utils/rating_controller.dart';
import 'package:monarchium/domain/auth/auth_util.dart';

class ReferralsController {
  validateLink(Uri? link) async {
    if (link == null) return;
    String? uid = link.queryParameters['invitedBy'];
    if (uid != null && uid.isNotEmpty) {
      final userRecordDocRef = UsersRecord.collection.doc(uid);
      final userExists = await userRecordDocRef.get().then((u) => u.exists);
      if (userExists) {
        UsersRecord userRecord =
            await UsersRecord.getDocumentOnce(userRecordDocRef);

        int difference =
            DateTime.now().difference(userRecord.createdTime!).inDays;

        bool isFirstMonth = difference < 31;
        bool isSecondMonth = difference > 30 && difference < 61;

        bool alreadyInvited =
            userRecord.referrals!.contains(currentUserReference);
        bool notSameUser = userRecord.uid != currentUserUid;

        Map<String, dynamic>? updateData;

        if (notSameUser && !alreadyInvited) {
          if (isFirstMonth) {
            RatingController().updateRating(15, userRecord);
            showSnackbar('Поздравляем! Вы получили +15 к рейтингу!');
            updateData = {
              'referrals': FieldValue.arrayUnion(
                [currentUserReference],
              ),
            };
          }

          if (isSecondMonth) {
            updateData = {
              'referrals': FieldValue.arrayUnion(
                [currentUserReference],
              ),
            };
          }
        }

        if (updateData != null) maybeUpdateUser(userRecordDocRef, updateData);
      }
    }
  }
}
