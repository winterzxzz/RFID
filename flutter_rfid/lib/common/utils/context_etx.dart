import 'package:flutter/material.dart';

import '../../ui/common/app_colors.dart';

extension ContextEtx on BuildContext {
  void showSnackBar(String msg){
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        content: Text(msg, style: const TextStyle(color: AppColors.textWhite)),
      ),
    );
  }
}

extension MessageEtx on String {
  Future<String> validateMsg(List<String> badWords) async {
    String msg = this;
    for (var badWord in badWords) {
      var regExp = RegExp(badWord, caseSensitive: false, multiLine: true);
      if (regExp.hasMatch(msg)) {
        msg = msg.replaceAll(regExp, "****");
      }
    }
    return msg;
  }
}