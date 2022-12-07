import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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
      print('[ERROR]: Invalid url');
      return false;
    }
    var url = Uri.http(serverAddress, '/ping');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // FIXME Document
  Future<void> connect({String? url}) async {
    final dir = await getApplicationDocumentsDirectory();
    if (url == null) {
      var file = File('${dir.path}/server_url.txt');
      try {
        url = file.readAsStringSync();
        _apiServer = url;
      } on FileSystemException {
        file.create();
        url = '';
        print('[INFO]: Url file created. No url found.');
      }
    }

    if (!await ping(serverAddress: url)) {
      print('[ERROR]: Server does not respond.');
      _isServerAvailable = false;
      _connectionStatus = 'Disconnected';
      notifyListeners();
      return;
    }
    _apiServer = url;
    _connectionStatus = 'Connected';
    _isServerAvailable = true;
    var file = File('${dir.path}/server_url.txt');
    file.writeAsStringSync(url);
    print('[INFO]: Connected to $url');

    notifyListeners();
    return;
  }

  // FIXME Document
  void disconnect() async {
    final dir = await getApplicationDocumentsDirectory();
    _connectionStatus = 'Disconnected';
    _isServerAvailable = false;
    var file = File('${dir.path}/server_url.txt');
    file.delete();
    print('[INFO]: Disconnected from $_apiServer');
    _apiServer = '';
    notifyListeners();
  }
}
