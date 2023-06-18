import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngetrip/core/binding.dart';
import 'package:ngetrip/core/camera.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:ngetrip/core/themes.dart';
import 'package:ngetrip/pages/splashscreen.dart';
import 'package:ngetrip/routes/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColor.secondaryBackgroundApp,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  /// Rotasi
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  try {
    availableCameras().then((value) => cameras = value);
  } on CameraException catch (e) {
    logCameraError(e.code, e.description);
  }

  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      title: 'Ngetrip',
      home: const SplashScreen(),
      initialBinding: InitialBinding(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.secondaryBackgroundApp,
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
          bodySmall: text12,
          bodyMedium: text14,
          bodyLarge: text16,
        ),
        primaryTextTheme: Theme.of(context)
            .primaryTextTheme
            .apply(bodyColor: AppColor.blackFont),
        primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
              color: AppColor.blackFont,
              size: 24,
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.secondaryBackgroundApp,
          elevation: 0,
          titleTextStyle: textBold14,
          foregroundColor: AppColor.blackFont,
          iconTheme: IconThemeData(
            color: AppColor.blackFont,
            size: 24,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColor.blackFont,
            size: 24,
          ),
          centerTitle: true,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
