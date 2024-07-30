import 'package:checklist/app/shared/logs/models/log_message.dart';

abstract class MessageLogger {
  Future<bool> writeMessage(LogMessage logMessage);

  Future<List<String>> readAllLogs();

  Future<List<String>> readLogsBasedOnDateTime(
      DateTime startDate, DateTime endDate);
}
