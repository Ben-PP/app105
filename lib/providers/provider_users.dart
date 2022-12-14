import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../objects/user.dart';

class ProviderUsers {
  final List<User> _users = [];

  List<User> get users {
    return _users;
  }

  void fetchUsers() async {
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/server_url');
  }
}
