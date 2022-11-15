import 'package:flutter/material.dart';

import './home_page.dart';

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
        colorScheme: ColorScheme(
          primary: Colors.white,
          onPrimary: Colors.purple,
          secondary: Colors.teal.shade700,
          onSecondary: Colors.white,
          background: Colors.white,
          onBackground: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.purple,
          onSurface: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
