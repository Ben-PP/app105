import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import '../widgets/dialogs/api_connect_dialog.dart';
import '../widgets/dialogs/change_pwd_dialog.dart';
import '../widgets/dialogs/add_user_dialog.dart';
import '../widgets/user_tile.dart';

import '../providers/provider_api.dart';
import '../providers/provider_auth.dart';
import '../providers/provider_users.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final ProviderApi providerApi;
  late final ProviderAuth providerAuth;
  late final ProviderUsers providerUsers;
  late final double screenHeight;
  late final double screenWidth;
  var isInitialized = false;

  @override
  void didChangeDependencies() async {
    if (!isInitialized) {
      screenHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top;
      screenWidth = MediaQuery.of(context).size.width;

      providerApi = Provider.of<ProviderApi>(context);
      providerAuth = Provider.of<ProviderAuth>(context);
      providerUsers = Provider.of<ProviderUsers>(context);
      await providerUsers.fetchUsers(jwt: providerAuth.jwt);
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  Widget userListItemBuilder(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: UserTile(
        user: providerUsers.users[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * GlobalSizes.appBarHeight,
        // FIXME Localization
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: screenHeight - screenHeight * GlobalSizes.appBarHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Server Settings
                // FIXME Localization
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Server Info',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
                const Divider(),
                // FIXME Localization
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Status: ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      providerApi.connectionStatus,
                      style: TextStyle(
                        color: providerApi.isServerAvailable
                            ? Colors.green.shade700
                            : Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Server: ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      providerApi.apiServer,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    providerApi.isServerAvailable
                        ? providerApi.disconnect()
                        : showDialog(
                            context: context,
                            builder: (context) {
                              return const ApiConnectDialog();
                            });
                  },
                  // FIXME Localization
                  child: Text(
                    providerApi.isServerAvailable ? 'Forget' : 'Add Server',
                  ),
                ),

                // User management
                if (providerAuth.isAdmin)
                  Column(
                    children: [
                      SizedBox(
                        width: screenWidth,
                        child: Text(
                          // FIXME Localization
                          'User Management',
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Divider(),
                      if (providerUsers.users.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: providerUsers.users.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: userListItemBuilder,
                            ),
                          ),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AddUserDialog();
                              });
                        },
                        child: const Text(
                          // FIXME Localization
                          'Add User',
                        ),
                      ),
                    ],
                  ),

                // Account management
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    // FIXME Localization
                    'Account',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
                const Divider(),
                ElevatedButton(
                  style: !providerApi.isServerAvailable ||
                          !providerAuth.isAuthenticated
                      ? Theme.of(context).elevatedButtonTheme.style!.copyWith(
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5),
                            ),
                          )
                      : null,
                  onPressed: !providerApi.isServerAvailable ||
                          !providerAuth.isAuthenticated
                      ? () {}
                      : () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const ChangePwdDialog();
                              });
                        },
                  // FIXME Localization
                  child: const Text(
                    'Change Password',
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
