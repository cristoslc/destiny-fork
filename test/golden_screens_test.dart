import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/locator.dart';
import 'package:destiny/views/desktop/receive/receive.dart' as dt_receive;
import 'package:destiny/views/desktop/send/send.dart' as dt_send;
import 'package:destiny/views/desktop/settings.dart' as dt_settings;
import 'package:destiny/views/mobile/Info.dart' as mobile_info;
import 'package:destiny/views/mobile/receive/receive.dart' as mobile_receive;
import 'package:destiny/views/mobile/send/send.dart' as mobile_send;
import 'package:destiny/views/shared/send.dart';
import 'package:destiny/views/shared/receive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:destiny/config/theme/custom_theme.dart';
import 'package:destiny/main.dart';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getDownloadsPath() async {
    return "downloads";
  }
}

Widget buildTestApp(Widget widget, {Size size = const Size(360, 690)}) {
  return ScreenUtilInit(
    designSize: size,
    minTextAdapt: true,
    splitScreenMode: true,
    builder: () {
      WidgetsFlutterBinding.ensureInitialized();
      return MaterialApp(
        theme: CustomTheme.darkThemeMobile,
        onGenerateRoute: selectRoutes(),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => SendSharedState()),
            ChangeNotifierProvider(create: (context) => ReceiveSharedState()),
          ],
          child: widget,
        ),
      );
    },
  );
}

Widget buildDesktopTestApp(Widget widget) {
  return buildTestApp(widget, size: const Size(1024, 768));
}

void main() {
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    PackageInfo.setMockInitialValues(
      appName: "Destiny",
      packageName: "com.leastauthority.destiny",
      version: "1.0.3",
      buildNumber: "34",
      buildSignature: "test",
      installerStore: "test",
    );
    SharedPreferences.setMockInitialValues({});
    final Config local = Config(
      rendezvousUrl: "ws://localhost:4000/v1",
      transitRelayUrl: "tcp://localhost:4001",
    );
    register(getIt, local);
    await getIt.allReady();
  });

  testWidgets('Send screen (desktop) golden', (WidgetTester tester) async {
    await tester.pumpWidget(buildDesktopTestApp(dt_send.SendScreen()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(dt_send.SendScreen),
      matchesGoldenFile('goldens/send_desktop.png'),
    );
  });

  testWidgets('Receive screen (desktop) golden', (WidgetTester tester) async {
    await tester.pumpWidget(buildDesktopTestApp(dt_receive.ReceiveScreen()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(dt_receive.ReceiveScreen),
      matchesGoldenFile('goldens/receive_desktop.png'),
    );
  });

  testWidgets('Settings screen (desktop) golden', (WidgetTester tester) async {
    await tester.pumpWidget(buildDesktopTestApp(dt_settings.Settings()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(dt_settings.Settings),
      matchesGoldenFile('goldens/settings_desktop.png'),
    );
  });

  testWidgets('Info screen (mobile) golden', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp(mobile_info.Info()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(mobile_info.Info),
      matchesGoldenFile('goldens/info_mobile.png'),
    );
  });

  testWidgets('Send screen (mobile) golden', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp(mobile_send.SendScreen()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(mobile_send.SendScreen),
      matchesGoldenFile('goldens/send_mobile.png'),
    );
  });

  testWidgets('Receive screen (mobile) golden', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp(mobile_receive.ReceiveScreen()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(mobile_receive.ReceiveScreen),
      matchesGoldenFile('goldens/receive_mobile.png'),
    );
  });
}
