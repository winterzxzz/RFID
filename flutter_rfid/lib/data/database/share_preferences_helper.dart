
import 'package:flutter/material.dart';
import 'package:flutter_rfid/common/utils/string_ext.dart';
import 'package:flutter_rfid/data/models/enums/language.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper {
  static const _apiToken = 'api_token';
  static const _currentLanguageKey = 'language';
  static const _theme = 'theme';


  SharedPreferencesHelper._();

  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._();

  factory SharedPreferencesHelper() => _instance;

  late SharedPreferences _prefs;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  static Future<Language?> getCurrentLanguage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_currentLanguageKey) ?? "";
      return LanguageExt.languageFromCode(languageCode);
    } catch (e) {
      return null;
    }
  }

  static Future<void> setCurrentLanguage(Language language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentLanguageKey, language.code);
  }

  static Future<ThemeMode> getTheme() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final theme = prefs.getString(_theme) ?? "system";
      return theme.toThemeMode();
    } catch (e) {
      return ThemeMode.system;
    }
  }

  static Future<void> setTheme(ThemeMode theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_theme, theme.name);
  }

  Future<bool> saveApiToken(String apiToken) async {
    return await _prefs.setString(_apiToken, apiToken);
  }

  String getApiToken() {
    return _prefs.getString(_apiToken) ?? '';
  }

  Future<bool> removeApiToken() async {
    return await _prefs.remove(_apiToken);
  }
}
