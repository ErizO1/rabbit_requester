import "dart:async";
import "package:dart_amqp/dart_amqp.dart";
import "package:uuid/uuid.dart";

import 'amqp_client.dart';

class AMQPClientManager {

  static final Map<String, AMQPClient> _clients = {};

  static String createClient(ConnectionSettings settings) {

    final client = AMQPClient(settings);
    final String clientId = const Uuid().v4();

    _clients[clientId] = client;

    return clientId;
  }

  static AMQPClient getClient(String clientId) {
    final client = _clients[clientId];

    if (client == null) {
      throw Exception("Client does not exist");
    }

    return client;
  }

}