import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/settings_page.dart';
import './dialogs/login_dialog.dart';

import '../providers/provider_auth.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  late final ProviderAuth providerAuth;

  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      providerAuth = Provider.of<ProviderAuth>(context);
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  Widget buildButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        child: IconButton(
          iconSize: 60,
          onPressed: onPressed,
          color: Theme.of(context).colorScheme.onPrimary,
          icon: Icon(
            icon,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Login/Logout
            buildButton(
                icon: providerAuth.isAuthenticated
                    ? Icons.logout_rounded
                    : Icons.login_rounded,
                onPressed: providerAuth.isAuthenticated
                    ? () {
                        Navigator.pop(context);
                        providerAuth.logout().then((value) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    children: const [
                                      Text(
                                        // FIXME Localization
                                        'Logged out.',
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        // FIXME Localization
                                        'Close',
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }).catchError((e) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    // FIXME Localization
                                    'Could not logout:\n$e',
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        // FIXME Localization
                                        'Close',
                                      ),
                                    ),
                                  ],
                                );
                              });
                        });
                      }
                    : () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LoginDialog();
                            });
                      }),

            // Settings
            buildButton(
                icon: Icons.settings_rounded,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SettingsPage.routeName);
                }),
          ],
        ),
      ),
    );
  }
}
