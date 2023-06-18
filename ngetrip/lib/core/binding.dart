import 'package:get/get.dart';
import 'package:ngetrip/controllers/main_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController(), permanent: true);
  }
}
