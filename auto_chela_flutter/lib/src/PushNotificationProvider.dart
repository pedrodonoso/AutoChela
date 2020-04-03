import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();

  //https://www.youtube.com/watch?v=pswT-gzRf_o&list=PLCKuOXG0bPi375T5P1UAK1QjYaF6jUKBP&index=7

  initNotifications() {

    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('==== FCM TOKEN ====');
      print(token);
    });
    _firebaseMessaging.configure(
      onMessage: (info) {
        print("==== On Message ===");
        print(info);
        String argumento = 'no-data';
        argumento = info['data']['prueba'] ?? 'no-data';

        _mensajesStreamController.sink.add(argumento);
      },
      onLaunch: (info)  {
        print("==== On Lounch ===");
        print(info);
      
      },
      onResume: (info)  {
        print("==== On Resume ===");
        print(info);
      }
    );
  }

  dispose() {
    _mensajesStreamController.close();
  }
}