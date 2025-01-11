part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  final Language language;
  final ThemeMode themeMode;
  final Color primaryColor;
  final bool isDynamicColor;
  const AppSettingState({
    this.language = AppConfigs.defaultLanguage,
    this.themeMode = ThemeMode.system,
    this.primaryColor = const Color(0xffEF5350),
    this.isDynamicColor = false,
  });

  @override
  List<Object?> get props => [
        language,
        themeMode,
        primaryColor,
        isDynamicColor,
      ];

  AppSettingState copyWith({
    Language? language,
    ThemeMode? themeMode,
    Color? primaryColor,
    bool? isDynamicColor,
  }) {
    return AppSettingState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      primaryColor: primaryColor ?? this.primaryColor,
      isDynamicColor: isDynamicColor ?? this.isDynamicColor,
    );
  }
}
