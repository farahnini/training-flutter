import 'package:app_settings/app_settings.dart';
import 'package:fgv_data_record/constant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateRecordScreen extends StatefulWidget {
  const CreateRecordScreen({super.key});

  @override
  State<CreateRecordScreen> createState() => _CreateRecordScreenState();
}

class _CreateRecordScreenState extends State<CreateRecordScreen> {
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
                    decoration: InputDecoration(
                        label: Text('Record'), border: OutlineInputBorder())),
                SizedBox(
                  height: 2.h,
                ),
                TextFormField(
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
          onPressed: () {},
          backgroundColor: Colors.green,
          child: Text('Submit', style: TextStyle(color: Colors.white))),
    );
  }
}
