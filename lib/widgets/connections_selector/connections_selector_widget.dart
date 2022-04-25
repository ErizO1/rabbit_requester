import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_requester/models/connection_model.dart';
import 'package:rabbit_requester/providers/connections_provider.dart';

import 'connections_selector_item.dart';
import 'connections_selector_add.dart';
import 'package:uuid/uuid.dart';


class ConnectionsSelector extends StatelessWidget {
  const ConnectionsSelector({Key? key}) : super(key: key);

  _onChangedHandler(ConnectionsProvider connectionsState, String? newValue) {
    if (newValue != null) {
      String id;
      if (newValue == '') {
        id = const Uuid().v4();
        final newConnection = ConnectionModel(
          id: id,
          name: 'New Connection',
          status: ConnectionStatus.ready
        );
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

    return Container(
      child: DropdownButton<String>(
        value: connectionsState.currentConnection?.id ?? '',
        items: connectionsState.connections.values
            .map((conn) => ConnectionsSelectorItem.create(
              key: Key(conn.id),
              connection: conn
            ))
            .toList()..add(
            ConnectionsSelectorAdd.create(
              key: const Key(''),
            ),
          ),
        onChanged: (String? newValue) => _onChangedHandler(connectionsState, newValue),
      ),
    );
  }
}
