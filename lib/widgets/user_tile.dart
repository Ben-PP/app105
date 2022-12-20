import 'package:flutter/material.dart';
import '../objects/user.dart';
import './dialogs/edit_user_dialog.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.user,
    super.key,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return EditUserDialog(
                user: user,
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          //height: 100,
          //width: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5,
                blurStyle: BlurStyle.normal,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Name
                Text(
                  user.uid,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    Text(
                      'Transactions:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Icon(
                      user.canMakeTransactions
                          ? Icons.check_circle_outline_rounded
                          : Icons.cancel_outlined,
                      color: user.canMakeTransactions
                          ? Colors.green.shade700
                          : Colors.red,
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      // FIXME Localization
                      'Admin:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Icon(
                      user.isAdmin
                          ? Icons.check_circle_outline_rounded
                          : Icons.cancel_outlined,
                      color: user.isAdmin ? Colors.green.shade700 : Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
