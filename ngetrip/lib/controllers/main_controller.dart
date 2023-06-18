import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngetrip/core/models/place_model.dart';
import 'package:ngetrip/core/models/user_model.dart';
import 'package:ngetrip/services/service.dart';

class MainController extends GetxController {
  final picker = ImagePicker();

  UserModel? _user;
  UserModel? get user => _user;
  set user(UserModel? value) {
    _user = value;
    update();
  }

  PlaceModel? _place;
  PlaceModel? get place => _place;
  set place(PlaceModel? value) {
    _place = value;
    update();
  }

  final service = AppService();

  Future<void> getPlaces() async {
    try {
      var raw = await service.getPlaces();
      var temp = PlaceModel.fromJson(raw);
      place = temp;
    } catch (e) {
      EasyLoading.showError('Gagal');
    } finally {}
  }

  Future<void> getPlace() async {
    try {
      var raw = await service.getPlace(place?.id ?? '');
      var temp = PlaceModel.fromJson(raw);
      place = temp;
    } catch (e) {
      EasyLoading.showError('Gagal');
    } finally {}
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show();
      var raw = await service.signIn(email: email, password: password);
      var temp = UserModel.fromJson(raw);
      user = temp;
      EasyLoading.showSuccess('Berhasil');
      return true;
    } catch (e) {
      EasyLoading.showError('Gagal');
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<bool> signUp({
    required UserModel user,
    File? image,
  }) async {
    try {
      EasyLoading.show();
      var raw = await service.signUp(user: user, image: image);
      var temp = UserModel.fromJson(raw);
      user = temp;
      EasyLoading.showSuccess('Berhasil');
      return true;
    } catch (e) {
      EasyLoading.showError('Gagal');
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> post({required List<File> image}) async {
    try {
      EasyLoading.show();
      await service.post(image: image, uid: place?.id ?? '');
      await EasyLoading.showSuccess('Berhasil');
      await getPlace();
    } catch (e) {
      debugPrint('statement error sign up: $e');
      EasyLoading.showError('Gagal');
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPlaces();
  }
}
