import 'dart:convert';

import 'package:fgv_data_record/screens/loadingscreen.dart';
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
      storage.setString('user_token', responseBody['token']['token']);
      final userToken = storage.getString('user_token');
      debugPrint('This is debug token: $userToken');
      Get.snackbar('Login', 'Successfully login',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else if (responseCode == 401) {
      debugPrint('This is debug token: $responseBody');
      Get.snackbar('Login', 'Not authorised',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  logout() async {
    try {
      //token
      final storage = await SharedPreferences.getInstance();
      final userToken = storage.getString('user_token');
      //endpoint
      final endpoint = Uri.parse('$baseUrl/logout');
      //headers
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      };
      //response
      final response = await http.get(endpoint, headers: headers);
      // //response body
      // final responseBody = json.decode(response.body);
      //response status code
      final responseCode = response.statusCode;
      //condition
      if (responseCode == 200) {
        storage.remove('user_token');
        Get.to(() => LoadingScreen());
      }
    } catch (e) {
      debugPrint('Error logout : $e');
      CheckConnection().checkConnectionState();
    }
  }
}
