import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';

import 'app_lifecycle_observer.dart';
import 'core/app_export.dart';
import 'core/utils/referals_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await GetStorage.init();

  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  ReferralsController().validateLink(initialLink?.link);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (value) {
      Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
      runApp(
        DevicePreview(
          // enabled: !kReleaseMode,
          enabled: false,
          builder: (context) => MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLifecycleObserver appLifecycleObserver = AppLifecycleObserver();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(appLifecycleObserver);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(appLifecycleObserver);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale.fromSubtags(languageCode: 'ru'),
        Locale.fromSubtags(languageCode: 'en'),
      ],
      useInheritedMediaQuery: true,
      locale: Locale.fromSubtags(languageCode: 'ru'),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      translations: AppLocalization(),
      // locale: Get.deviceLocale, //for setting localization strings
      fallbackLocale: Locale.fromSubtags(languageCode: 'ru'),
      title: 'Monarchium',
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      theme: context.theme.copyWith(
        useMaterial3: true,
      ),
    );
  }
}
