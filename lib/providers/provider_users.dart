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
    // BUG Unhandled exception if run when not authenticated.
    //     Json is not a list of maps in that case so
    //     [userDataList] is no iterable.
    var userDataList = jsonDecode(response.body);
    _users.clear();
    for (var userData in userDataList) {
      _users.add(User.fromMap(map: userData));
    }
    notifyListeners();
  }

  // FIXME Document
  Future<void> addUser(
      {required String jwt, required User user, required String pwd}) async {
    http.Response response = await functions
        .httpPost(resourcePath: '/user/add-user', headers: <String, String>{
      'Authorization': 'Bearer $jwt',
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: {
      'uid': user.uid,
      'pwd': pwd,
      'can_make_transactions': user.canMakeTransactions,
      'is_admin': user.isAdmin,
    });
    if (response.statusCode != 201) {
      throw Future.error('${response.statusCode}:${response.reasonPhrase}');
    }
    _users.add(user);
    notifyListeners();
  }

  // FIXME Document
  Future<void> deleteUser({
    required String jwt,
    required String uid,
  }) async {
    http.Response response = await functions.httpDelete(
      resourcePath: '/user/remove-user',
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        'uid': uid,
      },
    );
    if (response.statusCode != 204) {
      throw Future.error('${response.statusCode}:${response.reasonPhrase}');
    }
    _users.removeWhere((user) => user.uid == uid);
    notifyListeners();
  }

  // FIXME Document
  Future<void> editUser({
    required String jwt,
    required User user,
  }) async {
    http.Response response = await functions
        .httpPut(resourcePath: '/user/edit-user', headers: <String, String>{
      'Authorization': 'Bearer $jwt',
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: {
      'uid': user.uid,
      'can_make_transactions': user.canMakeTransactions,
      'is_admin': user.isAdmin,
    });
    if (response.statusCode != 204) {
      throw Future.error('${response.statusCode}:${response.reasonPhrase}');
    }
    _users.removeWhere((element) => element.uid == user.uid);
    _users.add(user);
    notifyListeners();
  }
}
