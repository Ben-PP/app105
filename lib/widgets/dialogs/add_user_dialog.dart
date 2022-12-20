import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../objects/user.dart';
import '../../globals.dart';

import '../../providers/provider_auth.dart';
import '../../providers/provider_users.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});
  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  late final ProviderAuth providerAuth;
  late final ProviderUsers providerUsers;
  var isAdmin = false;
  var canMakeTransactions = false;
  TextEditingController uidTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();
  TextEditingController pwdConfirmTextController = TextEditingController();
  var isInitialized = false;

  // Error flags
  var hasDifferentPasswords = false;
  var isPasswordShort = false;
  var isUidShort = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      providerAuth = Provider.of<ProviderAuth>(context);
      providerUsers = Provider.of<ProviderUsers>(context);
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    uidTextController.dispose();
    pwdTextController.dispose();
    pwdConfirmTextController.dispose();
    super.dispose();
  }

  bool _checkErrors() {
    setState(() {
      pwdTextController.text != pwdConfirmTextController.text
          ? hasDifferentPasswords = true
          : hasDifferentPasswords = false;
      pwdTextController.text.length < GlobalSizes.passwordLength
          ? isPasswordShort = true
          : isPasswordShort = false;
      uidTextController.text.trim().length < GlobalSizes.uidLength
          ? isUidShort = true
          : isUidShort = false;
    });
    if (hasDifferentPasswords || isPasswordShort || isUidShort) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  // FIXME Localization
                  'Add User',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Divider(),
                // Body
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // FIXME Localization
                            'Username:',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: uidTextController,
                                keyboardType: TextInputType.name,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    GlobalTextChecks.allowedUidCharacters,
                                  ),
                                ],
                                maxLength: 15,
                                decoration: const InputDecoration(
                                  // FIXME Localization
                                  hintText: 'Name...',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // FIXME Localization
                              'Password:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: pwdTextController,
                                  obscureText: true,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  enableIMEPersonalizedLearning: false,
                                  keyboardType: TextInputType.name,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      GlobalTextChecks.allowedUidCharacters,
                                    ),
                                  ],
                                  decoration: const InputDecoration(
                                    // FIXME Localization
                                    hintText: 'Password...',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // FIXME Localization
                              'Password:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: pwdConfirmTextController,
                                  obscureText: true,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  enableIMEPersonalizedLearning: false,
                                  keyboardType: TextInputType.name,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      GlobalTextChecks.allowedUidCharacters,
                                    ),
                                  ],
                                  decoration: const InputDecoration(
                                    // FIXME Localization
                                    hintText: 'Retype password...',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // FIXME Localization
                            'Transactions:',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Switch(
                            value: canMakeTransactions,
                            activeColor: Colors.green.shade700,
                            inactiveThumbColor: Colors.red,
                            onChanged: (value) {
                              setState(() {
                                canMakeTransactions = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Admin:',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Switch(
                            value: isAdmin,
                            activeColor: Colors.green.shade700,
                            inactiveThumbColor: Colors.red,
                            onChanged: (value) {
                              setState(() {
                                isAdmin = value;
                              });
                            },
                          ),
                        ],
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
                              if (_checkErrors()) return;
                              final user = User(
                                uid: uidTextController.text.trim(),
                                canMakeTransactions: canMakeTransactions,
                                isAdmin: isAdmin,
                              );
                              final pwd = pwdTextController.text;
                              providerUsers
                                  .addUser(
                                    jwt: providerAuth.jwt,
                                    user: user,
                                    pwd: pwd,
                                  )
                                  .then((value) => Navigator.pop(context));
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
                            child: const Text('Add User'),
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
    return [
      if (hasDifferentPasswords)
        Text(
          'Passwords don\'t match.',
          style: style,
        ),
      if (isPasswordShort)
        Text(
          'Passwords must be at least ${GlobalSizes.passwordLength} characters.',
          style: style,
        ),
      if (isUidShort)
        Text(
          'Name must be at least ${GlobalSizes.uidLength} characters.',
          style: style,
        ),
    ];
  }
}
