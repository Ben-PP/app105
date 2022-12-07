import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import './provider_api.dart';

class ProviderAuth with ChangeNotifier {
  String _jwt = '';
  String _uid = '';
  bool _isAuthenticated = false;

  /// Returns true if user is authenticated
  bool get isAuthenticated {
    return _isAuthenticated;
  }

  /// Returns the jwt
  String get jwt {
    return _jwt;
  }

  // Returns the uid
  String get uid {
    return _uid;
  }

  /// Validates if the JWT is still valid
  void validateJWT(ProviderApi providerApi) async {
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/jwt');
    try {
      _jwt = file.readAsStringSync();
    } on FileSystemException {
      _isAuthenticated = false;
      _jwt = '';
      notifyListeners();
      return;
    }
    var url = Uri.http(providerApi.apiServer, '/validate-jwt');
    try {
      var response = await http.get(
        url,
        headers: <String, String>{'Authorization': 'Bearer $_jwt'},
      );
      if (response.statusCode == 200) {
        _isAuthenticated = true;
        notifyListeners();
        return;
      }
    } catch (e) {
      print(e);
    }
    _isAuthenticated = false;
    notifyListeners();
  }

  /// Reads uid from file
  void readUid() async {
    final dir = await getApplicationDocumentsDirectory();
    var uidFile = File('${dir.path}/uid');
    _uid = uidFile.readAsStringSync();
  }

  // FIXME Document
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/server_url.txt');
    var serverUrl = file.readAsStringSync();
    var url = Uri.http(serverUrl, '/user/change-password');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $_jwt',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': _uid,
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );
      if ([401, 403, 500].contains(response.statusCode)) {
        print('ERROOOOOORRR');
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Authenticates user and saves JWT if successful
  ///
  /// Returns true if successful and false if not
  Future<dynamic> login({
    required String uid,
    required String psswd,
    // TODO Maybe not need for whole provider
    required ProviderApi providerApi,
  }) async {
    if (uid.isEmpty) {
      print('[ERROR]<Login>: Uid can not be empty.');
      return false;
    }
    var url = Uri.http(providerApi.apiServer, '/user/loginv2');
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
      if (response.statusCode == 401) {
        return false;
      }
      _jwt = jsonDecode(response.body)['access_token'];
      final dir = await getApplicationDocumentsDirectory();
      var jwt_file = File('${dir.path}/jwt');
      jwt_file.writeAsStringSync(_jwt);
      _isAuthenticated = true;
      var uid_file = File('${dir.path}/uid');
      uid_file.writeAsStringSync(uid);
      _uid = uid;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // FIXME Document
  Future<bool> logout() async {
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/server_url.txt');
    var serverUrl = file.readAsStringSync();
    var url = Uri.http(serverUrl, '/user/logout');
    try {
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'jwt': _jwt,
        }),
      );
    } catch (e) {
      print(e);
      return Future.error('Could not log out');
    }

    file = File('${dir.path}/jwt');
    file.deleteSync();
    _isAuthenticated = false;
    _jwt = '';
    _uid = '';
    notifyListeners();
    return true;
  }
}
