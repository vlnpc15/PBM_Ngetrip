import 'package:dio/dio.dart';

extension MapFormatter on Response<dynamic> {
  List<Map<String, dynamic>> get listMap => data['data'].isEmpty
      ? <Map<String, dynamic>>[]
      : List<Map<String, dynamic>>.from(data?['data'].map((e) {
          return e;
        }));
  Map<String, dynamic> get toMap => data['data'];
}
