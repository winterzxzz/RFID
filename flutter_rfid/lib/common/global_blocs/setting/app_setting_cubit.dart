import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/app_configs.dart';
import '../../../data/database/share_preferences_helper.dart';
import '../../../data/models/enums/language.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(const AppSettingState());

  Future<void> getInitialSetting() async {
    final currentLanguage = await SharedPreferencesHelper.getCurrentLanguage();
    final themeMode = await SharedPreferencesHelper.getTheme();

    emit(state.copyWith(
      language: currentLanguage,
      themeMode: themeMode,
    ));
  }

  void changeLanguage({required Language language}) async {
    await SharedPreferencesHelper.setCurrentLanguage(language);
    emit(state.copyWith(
      language: language,
    ));
  }

  void changeThemeMode({required ThemeMode themeMode}) async {
    await SharedPreferencesHelper.setTheme(themeMode);
    emit(state.copyWith(themeMode: themeMode));
  }

  void changePrimanyColor({required Color color}) {
    emit(state.copyWith(primaryColor: color));
  }
  
  void changeDynamicColor({required bool isDynamicColor}) {
    emit(state.copyWith(isDynamicColor: isDynamicColor));
  }
}
