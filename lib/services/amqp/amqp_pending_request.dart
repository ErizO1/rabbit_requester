import 'dart:async';

import "package:dart_amqp/dart_amqp.dart";

import 'amqp_request.dart';

class AMQPPendingRequest {
  final AMQPRequest request;
  final Completer<AmqpMessage> completer;
  final Timer timeoutTimer;

  AMQPPendingRequest({
    required this.request,
    required this.completer,
    required this.timeoutTimer
  });
}