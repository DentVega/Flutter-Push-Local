import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print('=== FCM TOKEN ===');
      print(token);
      // fVyFUCCs49Q:APA91bE5ZVpWjZoRxJOC2coc1FPt_mgQ-QEL-KOinLMr6NG4brjx6jtXr_AQXGrWdiK_QyObXJBjL4T9y1r67njAKWSXFtQI9VxH05Z4zg2p2G63sDer0s9IVGD_ZwNQIFdyENL1OJSD
    });
    _firebaseMessaging.configure(onMessage: (info) async {
      print('=== On Message ===');
      print(info);
    }, onLaunch: (info) async {
      print('=== On Launch ===');
      print(info);
      final noti = info['data']['comida'];
      print(noti);
    }, onResume: (info) async {
      print('=== On Resume ===');
      print(info);
      final noti = info['data']['comida'];
      print(noti);
    });
  }
}
