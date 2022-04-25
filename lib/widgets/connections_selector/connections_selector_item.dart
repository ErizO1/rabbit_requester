import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_requester/models/connection_model.dart';

import '../../providers/connections_provider.dart';

class ConnectionsSelectorItem {
  const ConnectionsSelectorItem();

  static DropdownMenuItem<String> create({
    Key? key,
    required ConnectionModel connection
  }) => DropdownMenuItem(
      key: key,
      value: connection.id,
      child: _ConnectionsSelectorItem(connection: connection),
    );
}

class _ConnectionsSelectorItem extends StatelessWidget{

  final ConnectionModel connection;

  const _ConnectionsSelectorItem({
    Key? key,
    required this.connection
  }) : super(key: key);

  static _getIcon(ConnectionStatus status) {
    switch(status) {
      case ConnectionStatus.ready:
        return Icons.check;
      case ConnectionStatus.connecting:
        return Icons.watch_later_outlined;
      case ConnectionStatus.disconnected:
        return Icons.close;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(connection.name),
          Icon(
            _getIcon(connection.status),
            color: Colors.black54,
          )
        ],
      );
  }

}