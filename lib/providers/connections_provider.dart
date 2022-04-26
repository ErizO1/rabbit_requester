import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:rabbit_requester/models/connection_model.dart';

import '../services/amqp/amqp.dart';

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

  _openConnection(String id) async {
    final targetConn = _connections[id];

    if (targetConn == null) {
      return;
    }

    final clientId = AMQPClientManager.createClient(ConnectionSettings(
      host: targetConn.host,
      // port: int.parse(targetConn.port),
      authProvider:
          PlainAuthenticator(targetConn.username, targetConn.password),
    ));

    final client = AMQPClientManager.getClient(clientId);
    await client.waitForInit();

    targetConn.clientId = clientId;

    setConnectionStatus(id, ConnectionStatus.ready);
  }

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
    _openConnection(newConnection.id);
    notifyListeners();
  }

  setConnectionStatus(String id, ConnectionStatus status) {
    _connections[id]?.status = status;
    notifyListeners();
  }

  sendMessage(String message) async {
    if (_currentConnetion?.clientId == null) {
      return;
    }

    final client = AMQPClientManager.getClient(_currentConnetion!.clientId!);
    final request = AMQPRequest(message: message, queue: 'echo');
    final response = await client.call(request);

    print(response.payloadAsString);
  }
}
