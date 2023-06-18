import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void logCameraError(String code, String? message) {
  if (message != null) {
    debugPrint('Camera Error: $code\nCamera Error Message: $message');
  } else {
    debugPrint('Camera Error: $code');
  }
  EasyLoading.showError('Camera Error: $code\nCamera Error Message: $message');
}

List<CameraDescription> cameras = [];
