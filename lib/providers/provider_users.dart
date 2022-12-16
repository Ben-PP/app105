import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../objects/user.dart';
import './functions.dart' as functions;

class ProviderUsers with ChangeNotifier {
  final List<User> _users = [];

  List<User> get users {
    return _users;
  }

  Future<void> fetchUsers({required String jwt}) async {
    http.Response response = await functions.httpGet(
      resourcePath: '/user/get-all-users',
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
      },
    );
    var userDataList = jsonDecode(response.body);
    _users.clear();
    for (var userData in userDataList) {
      _users.add(User.fromMap(map: userData));
    }
    notifyListeners();
  }
}
