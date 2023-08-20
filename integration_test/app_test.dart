import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:monarchium/backend/schema/generated_emblems.dart';
import 'package:monarchium/core/app_export.dart';

import 'package:monarchium/widgets/emblem/emblem_widget.dart';

extension ScreenSizeManager on WidgetTester {
  Future<void> setScreenSize(ScreenSize screenSize) async {
    return _setScreenSize(
      width: screenSize.width,
      height: screenSize.height,
      pixelDensity: screenSize.pixelDensity,
    );
  }

  Future<void> _setScreenSize({
    required double width,
    required double height,
    required double pixelDensity,
  }) async {
    final size = Size(width, height);
    await binding.setSurfaceSize(size);
    binding.window.physicalSizeTestValue = size;
    binding.window.devicePixelRatioTestValue = pixelDensity;
  }
}

class ScreenSize {
  const ScreenSize(this.name, this.width, this.height, this.pixelDensity);
  final String name;
  final double width, height, pixelDensity;
}

const sm_g950f = ScreenSize('sm_g950d', 2220, 1080, 3);
const sm_g981u1 = ScreenSize('sm_g981u1', 1440, 3200, 3);
const pixel7 = ScreenSize('pixel_7', 1080, 2400, 2.625);
const pixel5 = ScreenSize('pixel_5', 1080, 2340, 2.75);
const nexus5 = ScreenSize('nexus_5', 1080, 1920, 3);
const pixel = ScreenSize('pixel', 480, 640, 2.625);
const moto_e5_play = ScreenSize('moto_e5_play', 480, 960, 1.5);

final responsiveVariant = ValueVariant<ScreenSize>({
  sm_g950f,
  sm_g981u1,
  pixel7,
  pixel5,
  nexus5,
  pixel,
  moto_e5_play,
});

void testResponsiveWidgets(
  String description,
  WidgetTesterCallback callback, {
  Future<void> Function(String sizeName, WidgetTester tester)? goldenCallback,
  bool? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  ValueVariant<ScreenSize>? breakpoints,
  dynamic tags,
}) {
  final variant = breakpoints ?? responsiveVariant;
  testWidgets(
    description,
    (tester) async {
      await tester.setScreenSize(variant.currentValue!);
      await callback(tester);
      if (goldenCallback != null) {
        await goldenCallback(variant.currentValue!.name, tester);
      }
    },
    skip: skip,
    timeout: timeout,
    semanticsEnabled: semanticsEnabled,
    variant: variant,
    tags: tags,
  );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testResponsiveWidgets(
    'Check the sizes of an emblem on different devices',
    (widgetTester) async {
      widgetTester.setScreenSize(sm_g950f);

      final emblems = [
        GeneratedEmblems(
          (b) => b
            ..backgroundColor = '#000000'
            ..emblem =
                'https://firebasestorage.googleapis.com/v0/b/monarchium-5f98b.appspot.com/o/cms_uploads%2Femblems%2F1671191858031000%2F028.png?alt=media&token=8eaf2dca-f96a-4b22-a0f5-64c3573cb016'
            ..filled = false,
        ),
        GeneratedEmblems(
          (b) => b
            ..backgroundColor = '#000000'
            ..emblem =
                'https://firebasestorage.googleapis.com/v0/b/monarchium-5f98b.appspot.com/o/cms_uploads%2Femblems%2F1670783528831000%2F647ey46.png?alt=media&token=7fee635a-d1bf-4c01-878c-118074a1de12'
            ..filled = false,
        ),
        GeneratedEmblems(
          (b) => b
            ..backgroundColor = '#000000'
            ..emblem =
                'https://firebasestorage.googleapis.com/v0/b/monarchium-5f98b.appspot.com/o/cms_uploads%2Femblems%2F1671571580648000%2F354.png?alt=media&token=8b28dd96-3901-43b8-b225-67af0817568c'
            ..filled = false,
        ),
        GeneratedEmblems(
          (b) => b
            ..backgroundColor = '#000000'
            ..emblem =
                'https://firebasestorage.googleapis.com/v0/b/monarchium-5f98b.appspot.com/o/cms_uploads%2Femblems%2F1671625418824000%2F366.png?alt=media&token=072945c4-4988-4e45-bf86-6c1818e2c40b'
            ..filled = false,
        ),
      ];

      double width = getHorizontalSize(200), height = getVerticalSize(230);

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmblemWidget(
              width: width,
              height: height,
              emblems: emblems,
            ),
          ),
        ),
      );
    },
  );

  // group('end-to-end test', () {
  //   testWidgets('Check the sizes of an emblem on different devices',
  //       (tester) async {
  //     app.main();
  //     await tester.pumpAndSettle();

  //     await tester.setScreenSize(sm_g950f);
  //   });
  // });
}
