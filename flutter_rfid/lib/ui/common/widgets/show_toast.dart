import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast({
  required String title,
  String? description,
  required ToastificationType type,
}) {
  toastification.show(
    type: type,
    title: Text(title),
    description: description != null ? Text(description) : null,
    primaryColor: Colors.white,
    autoCloseDuration: const Duration(seconds: 3),
    progressBarTheme: ProgressIndicatorThemeData(
      color: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.info
              ? Colors.blue
              : type == ToastificationType.warning
                  ? Colors.orange
                  : Colors.red,
    ),
    showProgressBar: true,
    backgroundColor: type == ToastificationType.success
        ? Colors.green
        : type == ToastificationType.info
            ? Colors.blue
            : type == ToastificationType.warning
                ? Colors.orange
                : Colors.red,
    foregroundColor: Colors.white,
  );
}
