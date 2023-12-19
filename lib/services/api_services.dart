import 'dart:convert';
import 'package:fgv_data_record/screens/home_screen.dart';
import 'package:fgv_data_record/screens/index_grading.dart';
import 'package:fgv_data_record/screens/loadingscreen.dart';
import 'package:fgv_data_record/screens/login_screen.dart';
import 'package:fgv_data_record/utils/check_connection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final baseUrl = 'http://bunctracker.quickcapt.cloud/api';

  login(String email, String password) async {
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
      storage.setString('user_token',
          responseBody['token']); // save token in shared preference
      final userToken =
          storage.getString('user_token'); // get token from shared preference
      debugPrint(
          'This is debug token: $userToken'); // print token in debug console
      Get.snackbar('Login', 'Successfully login',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => LoadingScreen());
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
      // Save token in shared preference
      final storage = await SharedPreferences.getInstance();
      // endpoint
      final endpoint = Uri.parse('$baseUrl/logout');
      // headers
      final header = {
        'Accept': 'application/json',
        'Authorisation': 'Bearer ${storage.getString('user_token')}'
      };
      // request
      final response = await http.post(endpoint, headers: header);

      // response status code
      final responseCode = response.statusCode;
      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        storage.remove('user_token');
        Get.offAll(() => LoadingScreen());
      } else if (response.statusCode == 401) {
        storage.remove('user_token');
        Get.offAll(() => LoadingScreen());
      } else {
        storage.remove('user_token');
        Get.offAll(() => LoadingScreen());
      }
      return responseBody;
    } catch (e) {
      debugPrint('This is error: $e');
      CheckConnection().checkConnectionState();
    }
  }

  // Future profile() async {
  //   try {
  //     final storage = await SharedPreferences.getInstance();
  //     final userToken = storage.getString('user_token');
  //     final endpoint = Uri.parse('$baseUrl/profile');
  //     final headers = {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $userToken'
  //     };

  //     final response = await http.get(
  //       endpoint,
  //       headers: headers,
  //     );

  //     final responseBody = json.decode(response.body);
  //     final responseBodyData = json.decode(response.body)['data'];
  //     if (kDebugMode) {
  //       print('Status Code profile : ${response.statusCode}');
  //       print('profile responsebody : ${responseBodyData}');
  //     }
  //     if (response.statusCode == 200) {
  //       // showSuccessSnackBarApi('Logout', responseBody['message'] ?? '');
  //       return responseBodyData;
  //     } else if (response.statusCode == 401) {
  //       // showErrorSnackBarApi('Profile', responseBody['message']);
  //       Get.offAll(() => LoadingScreen());
  //     } else {
  //       // showErrorSnackBarApi('Profile', responseBody['message']);
  //       Get.offAll(() => LoadingScreen());
  //     }
  //   } catch (e) {
  //     debugPrint('Profile Error : $e');
  //     // CheckConnection().checkConnectivityState();
  //   }
  // }
  Future fetchPlantation() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final userToken = storage.getString('user_token');
      final endpoint = Uri.parse('$baseUrl/v1/plantations');
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      };

      final response = await http.get(
        endpoint,
        headers: headers,
      );

      final responseBody = json.decode(response.body);
      final responseBodyData = json.decode(response.body)['data'];
      if (kDebugMode) {
        print('Status Code profile : ${response.statusCode}');
        print('profile responsebody : ${responseBodyData}');
      }
      if (response.statusCode == 200) {
        // showSuccessSnackBarApi('Logout', responseBody['message'] ?? '');
        return responseBodyData;
      } else if (response.statusCode == 401) {
        // showErrorSnackBarApi('Profile', responseBody['message']);
        Get.offAll(() => LoadingScreen());
      } else {
        // showErrorSnackBarApi('Profile', responseBody['message']);
        Get.offAll(() => LoadingScreen());
      }
    } catch (e) {
      debugPrint('Profile Error : $e');
      // CheckConnection().checkConnectivityState();
    }
  }

  Future fetchStages(String plantationId) async {
    try {
      final storage = await SharedPreferences.getInstance();
      final userToken = storage.getString('user_token');
      final endpoint =
          Uri.parse('$baseUrl/v1/plantations/$plantationId/stages');
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      };

      final response = await http.get(
        endpoint,
        headers: headers,
      );

      final responseBody = json.decode(response.body);
      final responseBodyData = json.decode(response.body)['data'];
      if (kDebugMode) {
        print('Status Code profile : ${response.statusCode}');
        print('profile responsebody : ${responseBodyData}');
      }
      if (response.statusCode == 200) {
        // showSuccessSnackBarApi('Logout', responseBody['message'] ?? '');
        return responseBodyData;
      } else if (response.statusCode == 401) {
        // showErrorSnackBarApi('Profile', responseBody['message']);
        Get.offAll(() => LoadingScreen());
      } else {
        // showErrorSnackBarApi('Profile', responseBody['message']);
        Get.offAll(() => LoadingScreen());
      }
    } catch (e) {
      debugPrint('Profile Error : $e');
      // CheckConnection().checkConnectivityState();
    }
  }

  Future fetchGradings() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final userToken = storage.getString('user_token');
      final endpoint = Uri.parse('$baseUrl/gradings');
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      };

      final response = await http.get(
        endpoint,
        headers: headers,
      );

      final responseBody = json.decode(response.body);
      final responseBodyData = json.decode(response.body)['data'];
      if (kDebugMode) {
        print('Status Code profile : ${response.statusCode}');
        print('profile responsebody : ${responseBodyData}');
      }
      if (response.statusCode == 200) {
        // showSuccessSnackBarApi('Logout', responseBody['message'] ?? '');
        return responseBodyData;
      } else if (response.statusCode == 401) {
        // showErrorSnackBarApi('Profile', responseBody['message']);
        Get.offAll(() => LoadingScreen());
      } else {
        // showErrorSnackBarApi('Profile', responseBody['message']);
        Get.offAll(() => LoadingScreen());
      }
    } catch (e) {
      debugPrint('Profile Error : $e');
      // CheckConnection().checkConnectivityState();
    }
  }

  Future createGrading(
    String stagesId,
    String block,
    String platform,
    String longitude,
    String latitude,
    String masak,
    String mengkal,
    String muda,
    String kosong,
    String busuk,
    String panjang,
    String kotor,
    String peram,
    String rosak,
    String remark,
    String referenceNum,
    // String harvesters,
  ) async {
    // Save token in shared preference
    final storage = await SharedPreferences.getInstance();
    // endpoint
    final endpoint = Uri.parse('$baseUrl/gradings');
    // headers
    final userToken = storage.getString('user_token');
    final header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    final body = {
      'stage_id': stagesId,
      'block': block,
      'platform': platform,
      'longitude': longitude,
      'latitude': latitude,
      'masak': masak,
      'mengkal': mengkal,
      'muda': muda,
      'kosong': kosong,
      'busuk': busuk,
      'panjang': panjang,
      'kotor': kotor,
      'peram': peram,
      'rosak': rosak,
      'remark': remark,
      'reference_num': referenceNum,
      'harvesters': '[1, 2, 3]',
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
      Get.snackbar('Login', 'Successfully login',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => IndexGrading());
    } else if (responseCode == 401) {
      debugPrint('This is debug token: $responseBody');
      Get.snackbar('Login', 'Not authorised',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
