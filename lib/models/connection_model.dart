enum ConnectionStatus {
  disconnected,
  connecting,
  ready,
}

class ConnectionModel {
  final String id;
  String? clientId;
  String name;
  String host;
  String username = 'guest';
  String password = 'guest';
  String port = '5672';
  ConnectionStatus status;

  ConnectionModel({
    required this.id,
    required this.name,
    this.status = ConnectionStatus.connecting,
    this.host = 'localhost',
    this.username = 'guest',
    this.password = 'guest',
    this.port = '5672',
  });
}
