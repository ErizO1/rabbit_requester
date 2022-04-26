import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_requester/providers/connections_provider.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key? key}) : super(key: key);

  _onPressedHandler(BuildContext context) {
    final connectionsState = context.read<ConnectionsProvider>();

    connectionsState.sendMessage('Test message');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => _onPressedHandler(context),
        child: const Text('Click me'));
  }
}
