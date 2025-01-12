import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/common/configs/noti_config.dart';
import 'package:flutter_rfid/common/global_blocs/app_bloc_observer.dart';
import 'package:flutter_rfid/common/configs/socket_config.dart';
import 'common/configs/app_configs.dart';
import 'common/configs/app_env_config.dart';
import 'data/database/share_preferences_helper.dart';

void main() async {
  AppConfigs.env = Environment.dev;
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesHelper().initialize();
  await init();
  Bloc.observer = AppBlocObserver();
  SocketConfig.socket.connect();
  await NotificationService().initialize();
  if (Platform.isAndroid) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Set status bar to transparent
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  runApp(const MyApp());
}
