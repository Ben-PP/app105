import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_auth.dart';
import '../../providers/provider_api.dart';

class ChangePwdDialog extends StatefulWidget {
  const ChangePwdDialog({super.key});

  @override
  State<ChangePwdDialog> createState() => _ChangePwdDialogState();
}

class _ChangePwdDialogState extends State<ChangePwdDialog> {
  late final ProviderAuth providerAuth;
  late final ProviderApi providerApi;
  final TextEditingController oldPsswdController = TextEditingController();
  final TextEditingController newPsswdController = TextEditingController();
  var isInitialized = false;

  // Error flags
  var isOldPasswordEmpty = false;
  var isNewPasswordEmpty = false;
  var isCredentialsDenied = false;

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
    oldPsswdController.dispose();
    newPsswdController.dispose();
    super.dispose();
  }

  void _checkErrors() {
    setState(() {
      // TODO Change to min 8 characters
      if (newPsswdController.text.length < 3) {
        isNewPasswordEmpty = true;
      } else {
        isNewPasswordEmpty = false;
      }
    });
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
                  'Change Password',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Divider(),
                // Body
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: oldPsswdController,
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
                              hintText: 'Old Password...'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: newPsswdController,
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
                              hintText: 'New Password...'),
                        ),
                      ),
                      ..._showErrors(),
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
                              isCredentialsDenied = false;
                              _checkErrors();
                              if (isNewPasswordEmpty) return;
                              providerAuth
                                  .changePassword(
                                oldPassword: oldPsswdController.text,
                                newPassword: newPsswdController.text,
                              )
                                  .then((value) {
                                Navigator.pop(context);
                              }).catchError((e) {
                                if (e.toString().contains(RegExp('401|403'))) {
                                  setState(() {
                                    isCredentialsDenied = true;
                                  });
                                  return;
                                }
                              });
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
                            child: const Text('Apply'),
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

  List<Widget> _showErrors() {
    TextStyle style = const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );
    return isCredentialsDenied || isNewPasswordEmpty
        ? [
            if (isOldPasswordEmpty || isNewPasswordEmpty)
              Text(
                // FIXME Localizaton
                'Password must be at least 8 characters.',
                style: style,
              ),
            if (isCredentialsDenied)
              Text(
                'Invalid Credentials',
                style: style,
              ),
          ]
        : [];
  }
}
