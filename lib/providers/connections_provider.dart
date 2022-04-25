import 'package:flutter/material.dart';
import 'package:rabbit_requester/models/connection_model.dart';

// final _mockConnections = {
//   'id1': const ConnectionModel(id: 'id1', name: 'Connection 1', status: ConnectionStatus.ready),
//   'id2': const ConnectionModel(id: 'id2', name: 'Connection 2', status: ConnectionStatus.connecting),
//   'id3': const ConnectionModel(id: 'id3', name: 'Connection 3', status: ConnectionStatus.disconnected),
// };

class ConnectionsProvider extends ChangeNotifier {

  final Map<String, ConnectionModel> _connections = {};
  ConnectionModel? _currentConnetion;

  ConnectionModel? get currentConnection => _currentConnetion;
  Map<String, ConnectionModel> get connections => _connections;

  setCurrentConnection(String id) {
    final targetConn = _connections[id];

    if (targetConn == null) {
      return;
    }

    _currentConnetion = targetConn;
    notifyListeners();
  }

  addNewConnection(ConnectionModel newConnection) {
    _connections[newConnection.id] = newConnection;
    notifyListeners();
  }
}