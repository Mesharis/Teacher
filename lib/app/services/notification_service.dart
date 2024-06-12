//import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/routes/app_pages.dart';
import 'package:hallo_doctor_doctor_app/app/utils/environment.dart';

import '../styles/styles.dart';

class FirebaseMessagingHelper {
  static Future<String?> getToken() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_important_channel",
  "High Importance Notifications",
  description: 'this channel is used for important notification',
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessaggingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.data);
  NotificationService().listenNotification();
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessaggingBackgroundHandler);
    setupFlutterNotification();
    listenNotification();
  }
  void setupFlutterNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    String? fcmToken = await FirebaseMessagingHelper.getToken();
    log(fcmToken.toString());
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      "testing",
      "How you doing",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Styles.primaryColor,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
    RemoteMessage message,
  ) async {
    if (receivedAction.buttonKeyPressed == 'yes') {
      Get.log('ACCEPTED CALL');
      acceptCall(message.data['token'], message.data['channelName']);
    } else if (receivedAction.buttonKeyPressed == 'no') {
      Get.log('REJECTED CALL');
      rejectCall(message.data['token'], message.data['channelName']);
    }
  }

  void listenNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      Get.log('A new onMessage event was published! ${message.data}');
      if (message.data['token'] != null) {
        try {
          await showCallingNotification(
            message.notification?.title,
            message.notification?.body,
          );
          AwesomeNotifications().setListeners(
            onActionReceivedMethod: (ReceivedAction receivedAction) =>
                onActionReceivedMethod(receivedAction, message),
            onDismissActionReceivedMethod: (ReceivedAction receivedAction) =>
                onActionReceivedMethod(receivedAction, message),
          );

          return;
        } catch (e) {
          print("EXCEPTION::$e");
        }
      }
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Styles.primaryColor,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('a new message opened app are was published');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          Get.defaultDialog(
            title: notification.title!,
            content: Text(notification.body ?? 'body empty'),
          );
        }
      },
    );
  }

  Future<String?> getNotificationToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future notificationStartAppointment(
    String doctorName,
    String userId,
    String roomName,
    String token,
    String timeSlotId,
  ) async {
    try {
      var callable = FirebaseFunctions.instance
          .httpsCallable('notificationStartAppointment');
      await callable({
        'doctorName': doctorName,
        'userId': userId,
        'roomName': roomName,
        'token': token,
        'timeSlotId': timeSlotId
      });
      printInfo(info: 'notification user id : $userId');
      print('Notification start appointment send');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> rejectCall(String token, String channelName) async {
    AwesomeNotifications().cancelNotificationsByChannelKey('basic_channel');
    RtcEngine engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: Environment.agoraAppId));
    await engine.joinChannel(
        token: token,
        channelId: channelName,
        uid: 0,
        options: ChannelMediaOptions(
          enableAudioRecordingOrPlayout: true,
          defaultVideoStreamType: VideoStreamType.videoStreamHigh,
        ));
    Future.delayed(Duration(milliseconds: 500), () {
      engine.leaveChannel();
      engine.release();
    });
  }

  void acceptCall(token, channelName) {
    Get.toNamed(Routes.CALL, arguments: {
      'token': token,
      'room': channelName,
    });
  }
}

Future showCallingNotification(title, body) async {
  //print("Notification json: $json");

  Timer(Duration(seconds: 30), () async {
    await AwesomeNotifications().cancelNotificationsByChannelKey('call');
    //RtcEngine _engine = await RtcEngine.create(Environment.agoraAppId);
    //await _engine.joinChannel(json['token'], json['channelName'], null, 0);
  });
  await AwesomeNotifications().createNotification(
    actionButtons: [
      NotificationActionButton(
        key: 'yes',
        label: 'رد',
        color: Colors.green,
      ),
      NotificationActionButton(
        key: 'no',
        label: 'رفض',
        color: Colors.red,
      ),
    ],
    content: NotificationContent(
      fullScreenIntent: true,
      id: 10,
      channelKey: 'call',
      title: title,
      body: body,
      category: NotificationCategory.Call,
      displayOnBackground: true,
      displayOnForeground: true,
      wakeUpScreen: true,
      locked: true,
      criticalAlert: true,
      color: Styles.secondaryColor,
      actionType: ActionType.SilentBackgroundAction,
      notificationLayout: NotificationLayout.Default,
    ),
  );
  print('end');
}
