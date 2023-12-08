import 'dart:convert';

import 'package:fgv_data_record/screens/home_screen.dart';
import 'package:fgv_data_record/screens/login_screen.dart';
import 'package:fgv_data_record/utils/check_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final baseUrl = 'https://staging.ecomplaint.tarsoft.my/api/v1';

  login(
      String email, String password, String playerId, String deviceName) async {
    // Save token in shared preference
    final storage = await SharedPreferences.getInstance();
    // endpoint
    final endpoint = Uri.parse('$baseUrl/login');
    // headers
    final header = {
      'Accept': 'application/json',
      // 'Authorisation':'Bearer $token'
    };
    final body = {
      'email': email,
      'password': password,
      'player_id': playerId,
      'device_name': deviceName,
    };
    // request
    final response = await http.post(endpoint, headers: header, body: body);

    // response body from server
    final responseBody = json.decode(response.body);

    // response status code
    final responseCode = response.statusCode;

    debugPrint('This is reponse body: $responseBody');
    debugPrint('This is reponse status code: $responseCode');

    if (responseCode == 200) {
      storage.setString('user_token', responseBody['token']['token']); // save token in shared preference
      final userToken = storage.getString('user_token'); // get token from shared preference
      debugPrint('This is debug token: $userToken'); // print token in debug console
      Get.snackbar('Login', 'Successfully login',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => HomeScreen());

    } else if (responseCode == 401) {
      debugPrint('This is debug token: $responseBody');
      Get.snackbar('Login', 'Not authorised',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }

  }


  logout() async {

    try{
       // Save token in shared preference
        final storage = await SharedPreferences.getInstance();
        // endpoint
        final endpoint = Uri.parse('$baseUrl/logout');
        // headers
        final header = {
          'Accept': 'application/json',
          'Authorisation':'Bearer ${storage.getString('user_token')}'
        };
        // request
        final response = await http.post(endpoint, headers: header);

        // response status code
        final responseCode = response.statusCode;

        if(responseCode == 200){
          storage.remove('user_token');
          Get.to(()=> LoginScreen());}

     }catch (e){
      debugPrint('This is error: $e');
      CheckConnection().checkConnectionState();
    }
   
  }
}
