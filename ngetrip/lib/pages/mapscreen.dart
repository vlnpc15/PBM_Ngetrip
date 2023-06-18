import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ngetrip/controllers/main_controller.dart';
import 'package:ngetrip/core/colors.dart';
import 'dart:async';

import 'package:ngetrip/core/themes.dart';
import 'package:ngetrip/pages/upload_camera.dart';
import 'package:ngetrip/services/service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(-8.1902271, 113.6462227),
    zoom: 18,
  );
  CameraPosition? camPos;
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  var place = Get.find<MainController>().place;

  String toSimpleIDR(dynamic val, {bool withoutDecimal = false}) {
    var f = NumberFormat.simpleCurrency(
      locale: 'id_ID',
      decimalDigits: withoutDecimal ? 0 : null,
    );
    if (val is String) val = int.parse(val.replaceAll('.', ''));
    return f.format(val);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: false,
        mapType: MapType.hybrid,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        onTap: (pos) {
          debugPrint('statement lang: $pos');
          showModalBottomSheet(
            context: context,
            useSafeArea: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.grey[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        place?.name ?? '',
                        style: textBold18,
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.close,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        label: Text(
                          '7 Minutes',
                          style: textWhiteBold14,
                        ),
                        icon: Icon(
                          Icons.directions_car_filled,
                          color: AppColor.secondaryBackgroundApp,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.more_horiz,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Text(
                      'Open',
                      style: textGray12.copyWith(color: Colors.green),
                    ),
                    title: Text(
                      'Hours',
                      style: textGray12,
                    ),
                    subtitle: Text(
                      '17:00-00:00',
                      style: textBold14,
                    ),
                    isThreeLine: true,
                    dense: true,
                    trailing: Icon(
                      Icons.expand_more,
                      color: AppColor.greyFont,
                    ),
                  ),
                  Text(
                    'Details',
                    style: textBold18.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryBackgroundApp,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: appShadowSmooth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                          style: text14,
                        ),
                        Text(
                          place?.phone ?? '',
                          style: textBold14.copyWith(
                            color: AppColor.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: text14,
                            ),
                            IconButton(
                              onPressed: () {},
                              color: AppColor.greyColor,
                              icon: Icon(
                                Icons.directions,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          place?.address ?? '',
                          style: textBold14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryBackgroundApp,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: appShadowSmooth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width,
                          height: 50,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var image
                                    in (place?.thumbnails ?? <String>[]))
                                  Container(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.grayButton,
                                      image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                InkWell(
                                  onTap: () {
                                    Get.to(UploadCameraScreen());
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.grayButton,
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.camera_outlined,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.add,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            color: AppColor.greyColor,
                            height: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'IDR',
                              style: textBold14,
                            ),
                            Text(
                              toSimpleIDR(place?.price ?? 0),
                              style: textBold14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
