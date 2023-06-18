// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ngetrip/core/camera.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class TakePhotoView extends StatefulWidget {
  const TakePhotoView({
    Key? key,
  }) : super(key: key);

  @override
  _TakePhotoViewState createState() => _TakePhotoViewState();
}

class _TakePhotoViewState extends State<TakePhotoView>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    Permission.camera.request().then((value) {
      if (value.isDenied || value.isPermanentlyDenied) {
        EasyLoading.showError('Permission Denied');
      }
    }).whenComplete(() {
      if (cameras.isNotEmpty) {
        controller = CameraController(
          cameras[0],
          ResolutionPreset.max,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );
        controller?.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        }).catchError((e) async {
          if (e is CameraException) {
            await EasyLoading.showError('${e.code}. ${e.description}');
          }
        });
      } else {
        EasyLoading.showError('No Camera');
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _onNewCameraSelected(cameraController.description);
    }
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          _cameraPreviewWidget(context),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _captureControlRowWidget(),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Platform.isIOS ? Icons.chevron_left : Icons.arrow_back,
                  color: AppColor.secondaryBackgroundApp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget(BuildContext context) {
    final CameraController? cameraController = controller;
    final mediaSize = MediaQuery.of(context).size;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    } else {
      final scale = 1 / (controller!.value.aspectRatio * mediaSize.aspectRatio);
      return ClipRect(
        clipper: _MediaSizeClipper(mediaSize),
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: CameraPreview(controller!),
        ),
      );
    }
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    final CameraController? cameraController = controller;

    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      color: AppColor.blackFont,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: AppColor.secondaryBackgroundApp, shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.flip_camera_ios, color: AppColor.primaryColor),
              color: Colors.blue,
              onPressed: controller != null
                  ? () => controller?.description.lensDirection ==
                          CameraLensDirection.back
                      ? _onSetFlipCameraButtonPressed(true)
                      : _onSetFlipCameraButtonPressed(false)
                  : null,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColor.secondaryBackgroundApp, shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.camera_alt,
                  size: 28, color: AppColor.primaryColor),
              color: Colors.blue,
              onPressed: cameraController != null &&
                      cameraController.value.isInitialized &&
                      !cameraController.value.isRecordingVideo
                  ? _onTakePictureButtonPressed
                  : null,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColor.secondaryBackgroundApp, shape: BoxShape.circle),
            child: IconButton(
              icon: controller?.value.flashMode == FlashMode.torch
                  ? Icon(Icons.flash_on, color: AppColor.primaryColor)
                  : Icon(Icons.flash_off, color: AppColor.primaryColor),
              onPressed: controller != null
                  ? () => controller?.value.flashMode == FlashMode.torch
                      ? _onSetFlashModeButtonPressed(FlashMode.off)
                      : _onSetFlashModeButtonPressed(FlashMode.torch)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    EasyLoading.showInfo(message);
  }

  void _onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      cameraController.description.lensDirection;
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// Upload file dari kamera
  void _onTakePictureButtonPressed() async {
    await _takePicture().then((XFile? file) {
      if (mounted) {
        if (file != null) {
          setState(() {
            imageFile = File(file.path);
            // Fluttertoast.showToast(msg: file.path);
          });
          Navigator.of(context).pop(imageFile);
        }
      }
    });
  }

  void _onSetFlashModeButtonPressed(FlashMode mode) {
    debugPrint(controller?.value.flashMode.toString());
    _setFlashMode(mode).then((_) {
      if (mounted) setState(() {});
    });
  }

  void _onSetFlipCameraButtonPressed(bool isFlip) {
    debugPrint(controller?.description.lensDirection.toString());
    _setFlipCamera(isFlip).then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _setFlipCamera(bool isFlip) async {
    int cameraPos = isFlip ? 1 : 0;
    controller = CameraController(
      cameras[cameraPos],
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<void> _setFlashMode(FlashMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<XFile?> _takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    logCameraError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
