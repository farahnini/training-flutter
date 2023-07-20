import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckConnection {
  static bool? isConnect;

  checkConnectionState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      isConnect = true;
      debugPrint('Connected to internet');
    } else if (result == ConnectivityResult.mobile) {
      isConnect = true;
      debugPrint('Connected to internet');
    } else {
      isConnect = false;
      debugPrint('Not connected to internet');
      Get.snackbar(
          'No internet connection', 'Please check you internet connection');
    }
  }
}
