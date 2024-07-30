class LogMessage {
  final String message;
  final DateTime eventTime;
  final String category;

  final String user;

  LogMessage(
      {required this.category,
      required this.eventTime,
      required this.message,
      required this.user});
}
