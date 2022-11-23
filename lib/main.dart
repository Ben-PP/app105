import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home_page.dart';
import './settings/settings_page.dart';

import './providers/provider_api.dart';

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
        ChangeNotifierProvider(create: (context) => ProviderApi()),
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
        ),
        routes: {
          '/': (context) => const HomePage(),
          SettingsPage.routeName: ((context) => const SettingsPage()),
        },
      ),
    );
  }
}
