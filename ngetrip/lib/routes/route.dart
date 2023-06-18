import 'package:get/get.dart';
import 'package:ngetrip/pages/splashscreen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const loading = '/loading';
  static const error = '/error';

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
