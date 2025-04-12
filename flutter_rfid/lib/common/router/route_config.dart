import 'package:flutter/material.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/ui/page/device_detail/device_detail_page.dart';
import 'package:flutter_rfid/ui/page/general/general_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rfid/data/database/share_preferences_helper.dart';
import 'package:flutter_rfid/ui/page/login/login_page.dart';

import '../../ui/page/splash/splash_page.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      routes: _routes,
      debugLogDiagnostics: true,
      navigatorKey: navigationKey,
      redirect: (context, state) {
        final isLogin = SharedPreferencesHelper().getApiToken().isNotEmpty;
        if (!isLogin) {
          return login;
        }
        return null;
      },
      initialLocation: splash);

  ///main page
  static const String splash = "/";
  // Auth routes
  static const String login = "/login";
  static const String register = "/register";
  static const String resetPassword = "/reset-password";
  // App routes
  static const String general = '/general';

  static const String deviceDetail = '/device-detail';



  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(
      name: splash,
      path: splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: login,
      path: login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: general,
      path: general,
      builder: (context, state) => const GeneralPage(),
    ),
    GoRoute(
      name: deviceDetail,
      path: deviceDetail,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final device = args['device'] as DeviceEntity;
        return DeviceDetailPage(device: device);
      },
    ),
  ];
}
