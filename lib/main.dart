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
        colorScheme: const ColorScheme(
          primary: Colors.pink,
          onPrimary: Colors.white,
          secondary: Colors.purple,
          onSecondary: Colors.white,
          background: Colors.grey,
          onBackground: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.green,
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
