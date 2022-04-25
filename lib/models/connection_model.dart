enum ConnectionStatus {
  disconnected,
  connecting,
  ready,
}

class ConnectionModel {
  final String id;
  final String name;
  final ConnectionStatus status;

  const ConnectionModel({
    required this.id,
    required this.name,
    required this.status
  });
}