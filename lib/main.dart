import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/services/notification_service.dart';
import 'app/styles/styles.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';
import 'app/services/firebase_service.dart';
import 'app/utils/localization.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseChatCore.instance.setConfig(const FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        //channelGroupKey: 'basic_tests',
        channelKey: 'call',
        channelName: 'Call',
        channelDescription: 'Notification channel for basic tests',
        //defaultColor: Styles.secondaryColor,
        locked: true,
        //soundSource: 'resource://raw/res_custom_notification',
        defaultPrivacy: NotificationPrivacy.Public,
        enableVibration: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelGroupKey: 'call',
      ),
    ],
  );
  Get.put<NotificationService>(NotificationService());

  await GetStorage.init();
  bool isUserLogin = await FirebaseService().checkUserAlreadyLogin();
  initializeDateFormatting('ar', null);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Teacher",
      initialRoute: isUserLogin ? AppPages.dashboard : AppPages.login,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      localizationsDelegates: [FormBuilderLocalizations.delegate],
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Almarai",
        appBarTheme: AppBarTheme(
          titleTextStyle: Styles.appBarTextStyle,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      locale: LocalizationService.locale,
      translations: LocalizationService(),
    ),
  );
}
