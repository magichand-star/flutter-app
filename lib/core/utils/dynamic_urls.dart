import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

import '../app_export.dart';

class DynamicURLs {
  Future<String?> generateLink() async {
    // debugger();
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse("https://www.monarchium.com/?invitedBy=$uid"),
        uriPrefix: "https://monarchium.page.link",
        androidParameters:
            const AndroidParameters(packageName: "com.monarchium.app"),
        iosParameters: const IOSParameters(
          bundleId:
              "com.googleusercontent.apps.484757252858-9rupmmar8nnmh6l68fv5bl59g0rojues",
        ),
      );

      final unguessableDynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable,
      );
      printInfo(info: unguessableDynamicLink.shortUrl.toString());
      // await shareTheLink(unguessableDynamicLink);
      return unguessableDynamicLink.shortUrl.toString();
    }
    return null;
  }

  shareTheLink(ShortDynamicLink unguessableDynamicLink) async {
    await Share.share(
      unguessableDynamicLink.shortUrl.toString(),
    );
  }
}
