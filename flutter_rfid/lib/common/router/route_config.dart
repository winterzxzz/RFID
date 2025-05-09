import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/ui/page/device_detail/device_detail_page.dart';
import 'package:flutter_rfid/ui/page/general/general_page.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_cubit.dart';
import 'package:flutter_rfid/ui/page/manage_devices/widgets/form_update_device.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_cubit.dart';
import 'package:flutter_rfid/ui/page/manage_users/widgets/form_update_user.dart';
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

  static const String updateUser = '/update-user';

  static const String updateDevice = '/add-update-device';

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
    GoRoute(
      name: updateUser,
      path: updateUser,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final user = args['user'] as ManageUserEntity;
        final cubit = args['cubit'] as ManageUsersCubit;
        return BlocProvider.value(
          value: cubit,
          child: FormUpdateUser(user: user),
        );
      },
    ),
    GoRoute(
      name: updateDevice,
      path: updateDevice,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final device = args['device'] as DeviceEntity?;
        final cubit = args['cubit'] as ManageDevicesCubit;
        return BlocProvider.value(
          value: cubit,
          child: FormUpdateDevice(device: device),
        );
      },
    ),
  ];
}
