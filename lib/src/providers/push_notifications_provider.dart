import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print('=== FCM TOKEN ===');
      print(token);
      //Android:
      // fVyFUCCs49Q:APA91bE5ZVpWjZoRxJOC2coc1FPt_mgQ-QEL-KOinLMr6NG4brjx6jtXr_AQXGrWdiK_QyObXJBjL4T9y1r67njAKWSXFtQI9VxH05Z4zg2p2G63sDer0s9IVGD_ZwNQIFdyENL1OJSD
      //Ios:
      // eDQCpdi7gZQ:APA91bE3F4OBb6lbGFi4IdQ0O2dnXJJl8NW6BEiKQb_lQ5BNEPfSVBM9siBMwY6a0yRL0dHHzjyObXHfPGPO-tbMesO30ZbwXpwrTjvCn5K_MCqMKYGriJ8cGgfBhzvi6RDrb2SqfNYw
    });
    _firebaseMessaging.configure(onMessage: (info) async {
      print('=== On Message ===');
      print(info);
      var argument = 'no-data';
      if (Platform.isAndroid) {
        argument = info['data']['comida'] ?? 'no-data';
      } else {
        argument = info['comida'] ?? 'no-data-ios';
      }

      _mensajesStreamController.sink.add(argument);
    }, onLaunch: (info) async {
      print('=== On Launch ===');
      print(info);
      final noti = info['data']['comida'];
      print(noti);
    }, onResume: (info) async {
      print('=== On Resume ===');
      print(info);
      var argument = 'no-data';
      if (Platform.isAndroid) {
        argument = info['data']['comida'] ?? 'no-data';
      } else {
        argument = info['comida'] ?? 'no-data-ios';
      }

        _mensajesStreamController.sink.add(argument);
    });
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
