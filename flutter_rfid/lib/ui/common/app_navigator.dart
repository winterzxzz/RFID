import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rfid/ui/common/app_images.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppNavigator {
  BuildContext context;

  AppNavigator({required this.context});

  void pop<T extends Object?>([T? result]) {
    GoRouter.of(context).pop(result);
  }

  void popUntilNamed(String name) {
    Navigator.popUntil(context, ModalRoute.withName(name));
  }

  Future<dynamic> pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<dynamic> pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushReplacementNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void showLoadingOverlay({String? message}) {
    context.loaderOverlay.show(widgetBuilder: (dynamic) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.backgroundOverlay,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.textWhite),
            if (message != null) const SizedBox(height: 16),
            if (message != null)
              Text(
                message,
                style: TextStyle(color: AppColors.textWhite),
              ),
          ],
        ),
      );
    });
  }

  void showScanningOverlay() {
    context.loaderOverlay.show(widgetBuilder: (dynamic) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.backgroundOverlay,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.scanning,
                fit: BoxFit.contain, width: 200, height: 200)
          ],
        ),
      );
    });
  }

  void hideLoadingOverlay() {
    context.loaderOverlay.hide();
  }

  /// Show dialog
  Future<void> showSimpleDialog({
    String message = "",
    String? textConfirm = "OK",
    String? textCancel,
    barrierDismissible = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          insetPadding: const EdgeInsets.all(0),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.sizeOf(context).width - 32,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 20, bottom: 30),
                  child: Text(message, style: AppTextStyle.blackS14),
                ),
                Container(
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.gray2,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (textConfirm != null)
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              onConfirm?.call();
                            },
                            style: TextButton.styleFrom(
                              side: BorderSide.none,
                              padding: EdgeInsets.zero,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
                            ),
                            child: Text(
                              textConfirm,
                              style: AppTextStyle.blueS14Bold,
                            ),
                          ),
                        ),
                      if (textCancel != null)
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              onCancel?.call();
                            },
                            style: TextButton.styleFrom(
                              side: BorderSide.none,
                              padding: EdgeInsets.zero,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
                            ),
                            child: Text(
                              textCancel,
                              style: AppTextStyle.blackS14Bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ScaffoldFeatureController success(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.success,
          content:
              Text(message, style: const TextStyle(color: AppColors.textWhite)),
        ),
      );

  ScaffoldFeatureController error(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.error,
          content:
              Text(message, style: const TextStyle(color: AppColors.textWhite)),
        ),
      );
}
