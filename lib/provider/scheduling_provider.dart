import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/utils/background_service.dart';
import 'package:news_app/utils/date_time_helper.dart';

class SchedullingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;

    if (_isScheduled) {
      print('Scheduling News is Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(minutes: 1),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News is Deactivated');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
