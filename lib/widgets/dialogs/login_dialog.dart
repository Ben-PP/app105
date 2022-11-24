import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_auth.dart';
import '../../providers/provider_api.dart';

/// Dialog for connecting to api server
class LoginDialog extends StatefulWidget {
  const LoginDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  late final ProviderAuth providerAuth;
  late final ProviderApi providerApi;
  final TextEditingController uidController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      providerAuth = Provider.of<ProviderAuth>(context);
      providerApi = Provider.of<ProviderApi>(context);
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    uidController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  // FIXME Localization
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                // Body
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: uidController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              isCollapsed: true,
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              hintText: 'E.g. user.fun@example.com...'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: pwdController,
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          enableIMEPersonalizedLearning: false,
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 12, 12, 0),
                              isCollapsed: true,
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              hintText: 'password...'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            // FIXME Localization
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              providerAuth.login(
                                uid: uidController.text.trim(),
                                psswd: pwdController.text,
                                apiServer: providerApi.apiServer,
                              );
                              Navigator.pop(context);
                            },
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary)),
                            // FIXME Localization
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
