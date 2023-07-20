import 'dart:convert';

import 'package:flutter/material.dart';
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
  }
}
