import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_requester/models/connection_model.dart';
import 'package:rabbit_requester/providers/connections_provider.dart';

import 'connections_selector_add_form.dart';
import 'connections_selector_item.dart';
import 'connections_selector_add.dart';

class ConnectionsSelector extends StatelessWidget {
  const ConnectionsSelector({Key? key}) : super(key: key);

  Future<ConnectionModel> _createNewConnection(BuildContext context) {
    final completer = Completer<ConnectionModel>();

    showDialog(
        context: context,
        builder: (_) =>
            ConnectionsSelectorAddForm(completerCallback: completer));
    return completer.future;
  }

  _onChangedHandler(BuildContext context, String? newValue) async {
    final connectionsState = context.read<ConnectionsProvider>();

    if (newValue != null) {
      String id;
      if (newValue == '') {
        final newConnection = await _createNewConnection(context);
        id = newConnection.id;
        connectionsState.addNewConnection(newConnection);
      } else {
        id = newValue;
      }

      connectionsState.setCurrentConnection(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectionsState = Provider.of<ConnectionsProvider>(context);

    return DropdownButton<String>(
      value: connectionsState.currentConnection?.id ?? '',
      items: connectionsState.connections.values
          .map((conn) => ConnectionsSelectorItem.create(
              key: Key(conn.id), connection: conn))
          .toList()
        ..add(
          ConnectionsSelectorAdd.create(
            key: const Key(''),
          ),
        ),
      onChanged: (String? newValue) => _onChangedHandler(context, newValue),
    );
  }
}
