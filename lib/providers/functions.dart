import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<String> _getApplicationsDirPath() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

Future<String> _getUrl() async {
  final file = File('${await _getApplicationsDirPath()}/server_url');
  return file.readAsStringSync();
}

Future<http.Response> httpGet({
  required String resourcePath,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.http(await _getUrl(), resourcePath);
    return await http.get(
      url,
      headers: headers,
    );
  } catch (e) {
    return Future.error('[CONNECTION_ERROR]: $e');
  }
}

Future<http.Response> httpPost({
  required String resourcePath,
  required Map<String, String> headers,
  Map<String, dynamic>? body,
}) async {
  try {
    final url = Uri.http(await _getUrl(), resourcePath);
    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  } catch (e) {
    return Future.error('[CONNECTION_ERROR]: $e');
  }
}

Future<http.Response> httpPut({
  required String resourcePath,
  required Map<String, String> headers,
  Map<String, dynamic>? body,
}) async {
  try {
    final url = Uri.http(await _getUrl(), resourcePath);
    http.Response response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  } catch (e) {
    return Future.error('[CONNECTION_ERROR]: $e');
  }
}

Future<http.Response> httpDelete({
  required String resourcePath,
  required Map<String, String> headers,
  Map<String, dynamic>? body,
}) async {
  try {
    final url = Uri.http(await _getUrl(), resourcePath);
    http.Response response = await http.delete(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  } catch (e) {
    return Future.error('[CONNECTION_ERROR]: $e');
  }
}

Future<void> writeAppFile({
  required String filePath,
  String? content,
  FileMode? fileMode,
}) async {
  try {
    final file = File('${await _getApplicationsDirPath()}$filePath');
    file.writeAsStringSync(content ?? '', mode: fileMode ?? FileMode.write);
  } catch (e) {
    return Future.error('File could not be written: $e');
  }
}

Future<String> readAppFile({required String filePath}) async {
  try {
    final file = File('${await _getApplicationsDirPath()}$filePath');
    return file.readAsStringSync();
  } catch (e) {
    return Future.error(e);
  }
}

Future<void> deleteAppFiles({required List<String> filePaths}) async {
  final directoryPath = await _getApplicationsDirPath();
  for (String filePath in filePaths) {
    try {
      final file = File('$directoryPath$filePath');
      file.deleteSync();
    } catch (e) {
      return Future.error('File could not be deleted: $e');
    }
  }
}
