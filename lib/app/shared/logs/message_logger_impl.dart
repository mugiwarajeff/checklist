import 'dart:async';
import 'dart:io';

import 'package:checklist/app/shared/logs/interfaces/message_logger.dart';
import 'package:checklist/app/shared/logs/models/log_message.dart';
import 'package:path_provider/path_provider.dart';

class MessageLoggerImpl implements MessageLogger {
  final String logFolder = "logs";
  final String logFileName = "listinha_log.txt";

  @override
  Future<bool> writeMessage(LogMessage logMessage) async {
    try {
      Directory logFolder = await getApplicationDocumentsDirectory();

      File logFile = File("${logFolder.path}/$logFolder/$logFileName");

      bool existFile = await logFile.exists();
      if (!existFile) {
        await _creatFolder(logFile);
      }

      String message =
          "${logMessage.eventTime.toString()} - ${logMessage.user} - ${logMessage.category}: ${logMessage.message} ${Platform.lineTerminator}";

      await logFile.writeAsString(message, mode: FileMode.append);
    } on FileSystemException {
      return false;
    }

    return true;
  }

  Future<void> _creatFolder(File file) async {
    await file.create(recursive: true, exclusive: true);
  }

  @override
  Future<List<String>> readAllLogs() async {
    Directory logFolder = await getApplicationDocumentsDirectory();

    File logFile = File("${logFolder.path}/$logFolder/$logFileName");

    bool existFile = await logFile.exists();

    if (!existFile) {
      return [];
    }

    List<String> logs = await logFile.readAsLines();

    return logs;
  }

  @override
  Future<List<String>> readLogsBasedOnDateTime(
      DateTime startDate, DateTime endDate) async {
    Directory logFolder = await getApplicationDocumentsDirectory();

    File logFile = File("${logFolder.path}/$logFolder/$logFileName");

    bool existFile = await logFile.exists();

    if (!existFile) {
      return [];
    }

    List<String> logs = await logFile.readAsLines();

    List<String> filteredLogs = logs.where((log) {
      String stringDate = log.split("-").first.trim();

      DateTime logDateTime = DateTime.parse(stringDate);

      return logDateTime.isAfter(startDate) && logDateTime.isBefore(endDate);
    }).toList();

    return filteredLogs;
  }
}
