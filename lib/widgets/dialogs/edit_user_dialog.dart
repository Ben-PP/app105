import 'package:flutter/material.dart';
import '../../objects/user.dart';

class EditUserDialog extends StatefulWidget {
  const EditUserDialog({required this.user, super.key});
  final User user;
  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  late bool isAdmin;
  late bool canMakeTransactions;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      isAdmin = widget.user.isAdmin;
      canMakeTransactions = widget.user.canMakeTransactions;
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
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
                Text(
                  widget.user.uid,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.teal.shade700,
                                  ),
                                ),
                            onPressed: () {
                              // TODO Delete user
                            },
                            child: const Text(
                              'Delete',
                            ),
                          ),
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
                              // TODO Save all data
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
