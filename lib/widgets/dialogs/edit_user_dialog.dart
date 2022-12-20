import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../objects/user.dart';

import '../../providers/provider_auth.dart';
import '../../providers/provider_users.dart';

class EditUserDialog extends StatefulWidget {
  const EditUserDialog({required this.user, super.key});
  final User user;
  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  late final ProviderAuth providerAuth;
  late final ProviderUsers providerUsers;
  late bool isAdmin;
  late bool canMakeTransactions;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      providerAuth = Provider.of<ProviderAuth>(context);
      providerUsers = Provider.of<ProviderUsers>(context);
      isAdmin = widget.user.isAdmin;
      canMakeTransactions = widget.user.canMakeTransactions;
      isInitialized = true;
    }
    super.didChangeDependencies();
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
                  widget.user.uid,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
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
                              final user = User(
                                uid: widget.user.uid,
                                canMakeTransactions: canMakeTransactions,
                                isAdmin: isAdmin,
                              );
                              providerUsers.editUser(
                                jwt: providerAuth.jwt,
                                user: user,
                              );
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
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          providerUsers
                              .deleteUser(
                                jwt: providerAuth.jwt,
                                uid: widget.user.uid,
                              )
                              .then((value) => Navigator.pop(context));
                        },
                        child: Text(
                          // FIXME Localization
                          'Delete user',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.red,
                                  ),
                        ),
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
