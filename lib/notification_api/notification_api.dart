import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationApi{
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'channelDescription',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }
  static Future init({bool initScheduled = false}) async{
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final setting = InitializationSettings(android: android);

    //when app is closed
    final details = await _notification.getNotificationAppLaunchDetails();
    if(details != null && details.didNotificationLaunchApp){
      onNotifications.add(details.payload);
    }
    await _notification.initialize(
        setting,
        onSelectNotification: (payload) async{
          onNotifications.add(payload);
        },);

    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async => _notification.show(id, title, body, await _notificationDetails(), payload: payload);

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async => _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,

  );

  static void cancel(int id) => _notification.cancel(id);

  static void cancelAll() => _notification.cancelAll();

}