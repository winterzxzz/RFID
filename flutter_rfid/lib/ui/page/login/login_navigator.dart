import 'package:go_router/go_router.dart';
import 'package:flutter_rfid/common/router/route_config.dart';
import 'package:flutter_rfid/ui/common/app_navigator.dart';

class LoginNavigator extends AppNavigator {
  LoginNavigator({required super.context});

  void navigateToRegister() {
    GoRouter.of(context).pushNamed(AppRouter.register);
  }

  void navigateToResetPassword() {
    GoRouter.of(context).pushNamed(AppRouter.resetPassword);
  }
}
