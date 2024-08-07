class Utils {
  static String formatDateString(DateTime dateTime) {
    return "${dateTime.year}/${dateTime.month}/${dateTime.day}";
  }

  static bool isToday(DateTime firstDate, DateTime lastDate) {
    if (firstDate.year != lastDate.year) {
      return false;
    }

    if (firstDate.month != lastDate.month) {
      return false;
    }

    if (firstDate.day != lastDate.day) {
      return false;
    }

    return true;
  }
}
