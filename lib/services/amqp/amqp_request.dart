class AMQPRequest {
  final String queue;
  final String message;

  AMQPRequest({
    required this.queue,
    required this.message
  });
}