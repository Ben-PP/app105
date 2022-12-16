import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'functions.dart' as functions;

class ProviderAuth with ChangeNotifier {
  String _jwt = '';
  bool _isAuthenticated = false;
  bool _isAdmin = false;

  /// Returns true if user is authenticated
  bool get isAuthenticated {
    return _isAuthenticated;
  }

  /// Returns the jwt
  String get jwt {
    return _jwt;
  }

  bool get isAdmin {
    return _isAdmin;
  }

  /// Validates if the JWT is still valid
  void validateJWT() async {
    try {
      _jwt = await functions.readAppFile(filePath: '/jwt');
    } catch (e) {
      _isAuthenticated = false;
      _jwt = '';
      notifyListeners();
      return;
    }
    try {
      http.Response response = await functions.httpGet(
        resourcePath: '/tools/validate-jwt',
        headers: <String, String>{'Authorization': 'Bearer $_jwt'},
      );
      if (response.statusCode != 200) {
        _isAuthenticated = false;
        notifyListeners();
        return Future.error('Invalid response.');
      }
      var body = jsonDecode(response.body);
      _isAdmin = body['is_admin'];
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Changes the password of the account
  ///
  /// Changes the password of the account to which the
  /// jwt belongs to.
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      http.Response response = await functions.httpPost(
        resourcePath: '/user/change-password',
        headers: {
          'Authorization': 'Bearer $_jwt',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
      if (response.statusCode != 204) {
        return Future.error('${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      return Future.error('Something went wrong:\n$e');
    }
  }

  /// Authenticates user and saves JWT if successful
  ///
  /// Returns true if successful and false if not
  Future<void> login({
    required String uid,
    required String psswd,
  }) async {
    if (uid.isEmpty) {
      return Future.error('[LOGIN_ERROR]: Uid can not be empty.');
    }
    try {
      http.Response response = await functions.httpPost(
        resourcePath: '/user/loginv2',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          'username': uid,
          'password': psswd,
        },
      );
      if (response.statusCode != 200) {
        return Future.error('${response.statusCode}: ${response.reasonPhrase}');
      }
      var body = jsonDecode(response.body);
      _jwt = body['access_token'];
      _isAdmin = body['is_admin'];
      await functions.writeAppFile(filePath: '/jwt', content: _jwt);
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Logs out the user
  ///
  /// Logs out the user which is the owner of the jwt.
  Future<void> logout() async {
    try {
      http.Response response = await functions.httpPost(
        resourcePath: '/user/logout',
        headers: {
          'Authorization': 'Bearer $_jwt',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          'jwt': _jwt,
        },
      );
      if (response.statusCode != 204) {
        return Future.error('${response.statusCode}: ${response.reasonPhrase}');
      }
      await functions.deleteAppFiles(filePaths: ['/jwt']);
    } catch (e) {
      return Future.error(e);
    }
    _isAuthenticated = false;
    _jwt = '';
    _isAdmin = false;
    notifyListeners();
  }
}
