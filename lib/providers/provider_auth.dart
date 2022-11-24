import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderAuth with ChangeNotifier {
  String _jwt = '';

  /// Authenticates user and return JWT if successful
  Future<dynamic> login({
    required String uid,
    required String psswd,
    required String apiServer,
  }) async {
    if (uid.isEmpty) {
      print('[ERROR]<Login>: Uid can not be empty.');
      return;
    }
    var url = Uri.http(apiServer, '/user/login');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': uid,
          'password': psswd,
        }),
      );
      _jwt = jsonDecode(response.body)['access_token'];
      print(_jwt);
    } catch (e) {
      print(e);
      return;
    }
  }
}
