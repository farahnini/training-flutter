import 'package:fgv_data_record/screens/home_screen.dart';
import 'package:fgv_data_record/screens/login_screen.dart';
import 'package:fgv_data_record/utils/check_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadinScreen extends StatefulWidget {
  const LoadinScreen({super.key});

  @override
  State<LoadinScreen> createState() => _LoadinScreenState();
}

class _LoadinScreenState extends State<LoadinScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkToken();
    });
  }


  checkToken() async{
    final storage = await SharedPreferences.getInstance();
    final userToken = storage.getString('user_token');
    if(userToken != null){
      Get.offAll(() => HomeScreen());
    }else{
      Get.offAll(() => LoginScreen());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 10),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

}