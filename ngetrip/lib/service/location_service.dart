import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LocationService {
  final _key = '';
  Future<String> getPlaceId(String input) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input$input&intputtype=textquery&key=$_key';
    var res = await Dio().get(url);
    var json = jsonDecode(res.data);
    var placeId = json['candidates'][0]['place_id'];

    debugPrint('statement placeId: $placeId');

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id$input&key=$_key';
    var res = await Dio().get(url);
    var json = jsonDecode(res.data);
    var result = json['result'];

    debugPrint('statement getPlace: $result');

    return result;
  }
}
