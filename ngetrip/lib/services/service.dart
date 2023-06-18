import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ngetrip/core/extentions.dart';
import 'package:ngetrip/core/models/user_model.dart';

class AppService {
  final _dio = Dio();
  static const url =
      'https://66ca-2001-448a-5122-6e2c-44a8-8b51-363-2dbd.ngrok-free.app -> http://localhost:3';

  Future<Map<String, dynamic>> getPlaces() async {
    try {
      String uri = '$url/places';
      var res = await _dio
          .get(uri,
              options: Options(headers: {
                'Access-Control-Allow-Credentials':
                    true, // Required for cookies, authorization headers with HTTPS
                'Access-Control-Allow-Headers':
                    'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
                'Access-Control-Allow-Methods': '*'
              }))
          .then((value) {
        return value;
      });

      return res.listMap[0];
    } catch (e) {
      throw const FormatException('Error');
    }
  }

  Future<Map<String, dynamic>> getPlace(String placeId) async {
    try {
      String uri = url;
      var res = await _dio
          .get('$uri/$placeId',
              options: Options(headers: {
                'Access-Control-Allow-Credentials':
                    true, // Required for cookies, authorization headers with HTTPS
                'Access-Control-Allow-Headers':
                    'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
                'Access-Control-Allow-Methods': '*'
              }))
          .then((value) {
        return value;
      });

      return res.toMap;
    } catch (e) {
      throw const FormatException('Error');
    }
  }

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      String uri = '$url/login';
      var res = await _dio
          .post(uri,
              data: {
                'email': email,
                'password': password,
              },
              options: Options(headers: {
                'Access-Control-Allow-Credentials':
                    true, // Required for cookies, authorization headers with HTTPS
                'Access-Control-Allow-Headers':
                    'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
                'Access-Control-Allow-Methods': '*'
              }))
          .then((value) {
        return value;
      });

      return res.toMap;
    } catch (e) {
      throw const FormatException('Error');
    }
  }

  Future<Map<String, dynamic>> signUp({
    required UserModel user,
    File? image,
  }) async {
    try {
      String uri = '$url/register';
      var json = user.toJson();
      if (image != null) {
        json['image'] = MultipartFile.fromFile(image.path);
      }
      var data = FormData.fromMap(json);
      debugPrint('statement sign up: ${data.fields}');
      var res = await _dio
          .post(uri,
              data: data,
              options: Options(headers: {
                'Access-Control-Allow-Credentials':
                    true, // Required for cookies, authorization headers with HTTPS
                'Access-Control-Allow-Headers':
                    'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
                'Access-Control-Allow-Methods': '*'
              }))
          .then((value) {
        return value;
      });

      return res.toMap;
    } catch (e) {
      debugPrint('statement error sign up: ${e}');
      throw const FormatException('Error');
    }
  }

  Future<void> post({required List<File> image, required String uid}) async {
    try {
      Map<String, dynamic> json = {};
      for (var element in image) {
        json.addAll({'images[]': MultipartFile.fromFile(element.path)});
      }
      var data = FormData.fromMap(json);

      await _dio.post('$url/post/$uid', data: data);
    } catch (e) {
      throw const FormatException('Error');
    }
  }
}
