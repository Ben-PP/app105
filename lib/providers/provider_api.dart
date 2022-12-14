import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import './functions.dart' as functions;

class ProviderApi with ChangeNotifier {
  var _apiServer = '';
  var _connectionStatus = 'Not Responding';
  var _isServerAvailable = false;

  /// Returns the saved api server
  String get apiServer {
    return _apiServer;
  }

  /// Returns the connection status of the server
  String get connectionStatus {
    return _connectionStatus;
  }

  /// Returns the status of the server
  bool get isServerAvailable {
    return _isServerAvailable;
  }

  /// Pings the api server
  ///
  /// Returns true if response was 200 OK
  /// Else return false
  // TODO Authenticate that there is correct backend behind url.
  Future<bool> ping({required String serverAddress}) async {
    if (serverAddress == '') {
      return Future.error('[CONNECTION_ERROR]: Invalid url');
    }
    var url = Uri.http(serverAddress, '/tools/ping');
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        return Future.error('${response.statusCode}: ${response.reasonPhrase}');
      }
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Saves the servers connection info
  ///
  /// If [url] is not given, it will be tried to read from a file.
  Future<void> connect({String? url}) async {
    if (url == null) {
      try {
        url = await functions.readAppFile(filePath: '/server_url');
      } on FileSystemException {
        _apiServer = '';
        await functions.writeAppFile(
            filePath: '/server_url', content: _apiServer);
        return Future.error(
            '[CONNECTION_ERROR]: Could not read url from file.');
      }
    }

    if (!await ping(serverAddress: url).catchError((e) => false)) {
      _isServerAvailable = false;
      _connectionStatus = 'Disconnected';
      _apiServer = url;
      await functions.writeAppFile(
          filePath: '/server_url', content: _apiServer);
      notifyListeners();
      return Future.error('[CONNECTION_ERROR]: Could not connect to $url');
    }
    _connectionStatus = 'Connected';
    _isServerAvailable = true;
    _apiServer = url;
    await functions.writeAppFile(filePath: '/server_url', content: _apiServer);
    notifyListeners();
    return;
  }

  /// Deletes all server connection info
  void disconnect() async {
    final dir = await getApplicationDocumentsDirectory();
    _connectionStatus = 'Disconnected';
    _isServerAvailable = false;
    var file = File('${dir.path}/server_url');
    file.delete();
    _apiServer = '';
    notifyListeners();
  }
}
