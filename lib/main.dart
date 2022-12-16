import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home_page.dart';
import './settings/settings_page.dart';

import './providers/provider_api.dart';
import './providers/provider_auth.dart';
import './providers/provider_users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderAuth()),
        ChangeNotifierProvider(create: (context) => ProviderApi()),
        ChangeNotifierProvider(create: (context) => ProviderUsers()),
      ],
      child: MaterialApp(
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
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.teal.shade700),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
          textTheme: const TextTheme(
            // Headlines inside the pages
            displayMedium: TextStyle(
              fontSize: 25,
              color: Colors.purple,
            ),
            // Titles in tiles
            titleLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            // titles in body
            titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        routes: {
          '/': (context) => const HomePage(),
          SettingsPage.routeName: ((context) => const SettingsPage()),
        },
      ),
    );
  }
}
