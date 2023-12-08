import 'package:fgv_data_record/screens/home_screen.dart';
import 'package:fgv_data_record/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      checkToken();
    });
  }

  checkToken() async {
    final storage = await SharedPreferences.getInstance();
    final userToken = storage.getString('user_token');
    // storage.clear();
    if (userToken != null) {
      //IF USER HAVE TOKEN
      Get.offAll(() => HomeScreen());
    } else {
      //IF USER DOES NOT HAVE TOKEN NAVIGATE TO LOGIN SCREEN
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(size: 200),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
