import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    //Date and Time Format
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecifics = "05:30:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    //today format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecifics";
    var resulToday = completeFormat.parseStrict(todayDateAndTime);

    //tomorrow format
    final formatted = resulToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecifics";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resulToday) ? resultTomorrow : resulToday;
  }
}
