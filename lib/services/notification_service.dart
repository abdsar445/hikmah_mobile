import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(initSettings);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'hikmah_notifications',
      'Hikmah Alerts',
      channelDescription: 'Hikmah daily and prayer reminder notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails();

    await _notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
    );
  }

  Future<void> scheduleDailyHadithNotification({
    int hour = 8,
    int minute = 0,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'daily_hadith_channel',
      'Daily Hadith',
      channelDescription: 'Daily Hadith reminder',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails();

    await _notificationsPlugin.zonedSchedule(
      10,
      'Daily Hadith',
      'Open Hikmah AI to read today\'s hadith.',
      scheduledDate,
      const NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelDailyHadithNotification() async {
    await _notificationsPlugin.cancel(10);
  }

  Future<bool> schedulePrayerNotifications() async {
    try {
      final position = await _determinePosition();
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;

      final now = tz.TZDateTime.now(tz.local);
      final today = DateTime.now();
      final tomorrow = today.add(const Duration(days: 1));

      await cancelPrayerNotifications();

      final todayPrayerTimes = PrayerTimes(
        coordinates,
        DateComponents.from(today),
        params,
      );
      final tomorrowPrayerTimes = PrayerTimes(
        coordinates,
        DateComponents.from(tomorrow),
        params,
      );

      final prayerSchedule = <int, Map<String, dynamic>>{
        101: {
          'title': 'Fajr',
          'time': todayPrayerTimes.fajr,
        },
        102: {
          'title': 'Dhuhr',
          'time': todayPrayerTimes.dhuhr,
        },
        103: {
          'title': 'Asr',
          'time': todayPrayerTimes.asr,
        },
        104: {
          'title': 'Maghrib',
          'time': todayPrayerTimes.maghrib,
        },
        105: {
          'title': 'Isha',
          'time': todayPrayerTimes.isha,
        },
        106: {
          'title': 'Fajr',
          'time': tomorrowPrayerTimes.fajr,
        },
        107: {
          'title': 'Dhuhr',
          'time': tomorrowPrayerTimes.dhuhr,
        },
        108: {
          'title': 'Asr',
          'time': tomorrowPrayerTimes.asr,
        },
        109: {
          'title': 'Maghrib',
          'time': tomorrowPrayerTimes.maghrib,
        },
        110: {
          'title': 'Isha',
          'time': tomorrowPrayerTimes.isha,
        },
      };

      for (final entry in prayerSchedule.entries) {
        final id = entry.key;
        final title = entry.value['title'] as String;
        final dateTime = entry.value['time'] as DateTime;
        final scheduledDate = tz.TZDateTime.from(dateTime, tz.local);

        if (scheduledDate.isAfter(now)) {
          await _notificationsPlugin.zonedSchedule(
            id,
            'Prayer Reminder: $title',
            'It\'s time for $title prayer. Stay on track with Hikmah AI.',
            scheduledDate,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'prayer_reminder_channel',
                'Prayer Alerts',
                channelDescription: 'Prayer time reminders',
                importance: Importance.high,
                priority: Priority.high,
                playSound: true,
              ),
              iOS: DarwinNotificationDetails(),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
        }
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> cancelPrayerNotifications() async {
    for (final id in [101, 102, 103, 104, 105, 106, 107, 108, 109, 110]) {
      await _notificationsPlugin.cancel(id);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied forever');
    }

    return Geolocator.getCurrentPosition();
  }
}
