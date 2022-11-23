import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import '../widgets/dialogs/api_connect_dialog.dart';

import '../providers/provider_api.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final ProviderApi providerApi;
  late final double screenHeight;
  late final double screenWidth;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      screenHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top;

      providerApi = Provider.of<ProviderApi>(context);
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * SizesGlobal.appBarHeight,
        // FIXME Localization
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // FIXME Localization
            const Text('Server Info'),
            // FIXME Localization
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Status: ',
                ),
                Text(
                  providerApi.connectionStatus,
                  style: TextStyle(
                    color: providerApi.isServerAvailable
                        ? Colors.green.shade900
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
                const Text(
                  'Server: ',
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
                providerApi.isServerAvailable ? 'Disconnect' : 'Connect Server',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
