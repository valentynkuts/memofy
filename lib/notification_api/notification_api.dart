import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi{
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel name',
        importance: Importance.max,
      ),
    );
  }
  static Future init({bool initScheduled = false}) async{
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final setting = InitializationSettings(android: android);
    
    await _notification.initialize(
        setting,
        onSelectNotification: (payload) async{
          onNotifications.add(payload);
        },);
  }


  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async => _notification.show(id, title, body, await _notificationDetails(), payload: payload);

}