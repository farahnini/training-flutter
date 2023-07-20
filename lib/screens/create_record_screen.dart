import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:fgv_data_record/constant.dart';
import 'package:fgv_data_record/models/record_model.dart';
import 'package:fgv_data_record/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRecordScreen extends StatefulWidget {
  const CreateRecordScreen({super.key});

  @override
  State<CreateRecordScreen> createState() => _CreateRecordScreenState();
}

class _CreateRecordScreenState extends State<CreateRecordScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  double? currentLongitude;
  double? currentLatitude;

  _getCoordinate() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    print('Location permission before request : $permission');

    permission = await Geolocator.requestPermission();
    print('Location permission after request : $permission');

    if (permission == LocationPermission.denied) {
      permission;
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: avoid_print
      print("ERROR DENIED FOREVER");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Open App Setting'),
                content: Text(
                    'This action will open your app setting, to allow the usage of location'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Maybe later')),
                  ElevatedButton(
                      onPressed: () {
                        AppSettings.openAppSettings();
                      },
                      child: Text('Open Settings')),
                ],
              ));
    }
    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      Position position = await Geolocator.getCurrentPosition();
      double? latitude = position.latitude;
      double? longitude = position.longitude;

      if (mounted)
        setState(() {
          currentLatitude = latitude;
          currentLongitude = longitude;
        });

      print('Currect Latitude: $currentLatitude');
      print('Currect Longitude: $currentLongitude');
    }
  }

  // To store the record
  saveRecord() async {
    final storage = await SharedPreferences.getInstance();
    final recordJson = json.encode(records
        .map((record) => {
              'id': record.id,
              'title': record.title,
              'description': record.description,
              'image_list': record.imageList,
              'latitiude': record.latitude,
              'longitude': record.longitude,
            })
        .toList());

    await storage.setString('records', recordJson);
  }

  // To add record
  addRecord(
      String title, String desc, List imgList, double lat, double long) async {
    final record = RecordModel(
      id: DateTime.now().toString(),
      title: title,
      description: desc,
      imageList: imgList,
      latitude: lat,
      longitude: long,
    );

    records.add(record);
    await saveRecord();
  }

  @override
  void initState() {
    super.initState();
    _getCoordinate();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width; No longer needed as we are using responsive sizer

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Record'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.w),
          // height: 100.h,
          child: Form(
            child: Column(
              children: [
                TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        label: Text('Title'), border: OutlineInputBorder())),
                SizedBox(
                  height: 2.h,
                ),
                TextFormField(
                    controller: descriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                        label: Text('Description'),
                        border: OutlineInputBorder())),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                    width: 100.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Take photo"),
                        Icon(Icons.camera_alt),
                      ],
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                    width: 100.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Scan QR"),
                        Icon(Icons.qr_code),
                      ],
                    )),

                // ElevatedButton(
                //   onPressed: (){},
                //   style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.green,
                //   shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),
                //   child: Text('Submit',
                //     style: TextStyle(color: Colors.white))
                //     ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addRecord(titleController.text, descriptionController.text, [],
                currentLatitude!, currentLongitude!);
            Get.back();
          },
          backgroundColor: Colors.green,
          child: Text('Submit', style: TextStyle(color: Colors.white))),
    );
  }
}
