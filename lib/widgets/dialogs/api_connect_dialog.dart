import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_api.dart';

/// Dialog for connecting to api server
class ApiConnectDialog extends StatefulWidget {
  const ApiConnectDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ApiConnectDialog> createState() => _ApiConnectDialogState();
}

class _ApiConnectDialogState extends State<ApiConnectDialog> {
  late final ProviderApi providerApi;
  final TextEditingController textController = TextEditingController();
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      providerApi = Provider.of<ProviderApi>(context);
      textController.text = providerApi.apiServer;
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textController.dispose();
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
                  'Server address:',
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
                      TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                            isCollapsed: true,
                            enabledBorder: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                            hintText: 'E.g. 192.168.1.10:8000...'),
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
                              providerApi.connect(
                                  url: textController.text.trim());
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
                            child: const Text('Connect'),
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
