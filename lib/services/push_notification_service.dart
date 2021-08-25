// SHA1: 76:73:96:8D:7B:7A:30:03:16:8A:CF:51:94:A5:56:85:F5:08:B5:E5


 //SHA256: 9E:D9:11:85:16:2E:8F:5E:29:67:20:C5:93:11:DC:5B:EE:22:E6:76:46:03:DA:AB:3A:23:1C:ED:76:A3:6A:3F



 import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

   static FirebaseMessaging messaging = FirebaseMessaging.instance;
   static String? token;
   static StreamController<String> _messageStream = StreamController.broadcast();
   static Stream<String> get messagesStream => _messageStream.stream;

   static Future _backgroundHandler(RemoteMessage message)async {
     //print('background handler ${message.messageId}');
     print(message.data);
     _messageStream.sink.add(message.data['product'] ?? 'No data');
   }

   static Future _onMessageHandler(RemoteMessage message)async {
     //print('background handler ${message.messageId}');
     print(message.data);
     _messageStream.sink.add(message.data['product'] ?? 'No data');
   }

   static Future _onMessageOpenApp(RemoteMessage message)async {
     //print('background handler ${message.messageId}');
     print(message.data);
     _messageStream.sink.add(message.data['product'] ?? 'No data');
   }

   static Future initializeApp () async {
 
    //push notificaciones

    await Firebase.initializeApp();
    token = await  FirebaseMessaging.instance.getToken();
    print('token:  $token');


    //handlers

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //local notificaciones
   }

   static closeStream(){
     _messageStream.close();
   }

 }