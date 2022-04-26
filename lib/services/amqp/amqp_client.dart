import "dart:async";
import "package:dart_amqp/dart_amqp.dart";
import "package:uuid/uuid.dart";

import "amqp_request.dart";
import "amqp_pending_request.dart";

const String _replyToQueue = 'amq.rabbitmq.reply-to';

class AMQPClient {
  Client? _client;
  Channel? _channel;
  Queue? _replyQueue;
  Consumer? _replyConsumer;

  final Completer<void> _initCompleter = Completer();
  final Map<String, AMQPPendingRequest> _pendingExecutions = {};

  AMQPClient(ConnectionSettings settings) {
    _init(settings);
  }

  void _init(ConnectionSettings settings) async {
    _client = Client(settings: settings);
    await _client!.connect();

    _channel = await _client!.channel();
    _replyQueue = await _channel!.queue(_replyToQueue);

    _replyConsumer = await _replyQueue!.consume(noAck: true);
    _replyConsumer!.listen(_onDataHandler);

    _initCompleter.complete();
  }

  void _onDataHandler(AmqpMessage message) {
    final pendingRequest =
        _pendingExecutions[message.properties?.corellationId];

    if (pendingRequest == null) {
      return; // Ignore if the request doesn't have a completer
    }

    pendingRequest.timeoutTimer.cancel();
    pendingRequest.completer.complete(message);
    _pendingExecutions.remove(message.properties!.corellationId);
  }

  Future<void> waitForInit() {
    return _initCompleter.future;
  }

  Future<AmqpMessage> call(AMQPRequest request) async {
    await _initCompleter.future;

    final corellationId = const Uuid().v4();

    final queue = await _channel!.queue(request.queue, durable: true);
    final messageProperties = MessageProperties()
      ..corellationId = corellationId
      ..replyTo = _replyToQueue;

    queue.publish(request.message, properties: messageProperties);

    // Create and sotre the pending request
    final requestCompleter = Completer<AmqpMessage>();
    final timeoutTimer = Timer(const Duration(seconds: 10),
        () => requestCompleter.completeError("Request Timed Out"));

    final pendingRequest = AMQPPendingRequest(
        request: request,
        completer: requestCompleter,
        timeoutTimer: timeoutTimer);

    _pendingExecutions[corellationId] = pendingRequest;

    return requestCompleter.future;
  }
}
