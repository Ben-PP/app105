import 'package:flutter/material.dart';

import './home_page.dart';
import './settings/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App105',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      routes: {
        '/': (context) => const HomePage(),
        SettingsPage.routeName: ((context) => const SettingsPage()),
      },
    );
  }
}
