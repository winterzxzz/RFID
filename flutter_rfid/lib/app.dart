import 'package:dio/dio.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rfid/common/global_blocs/deparments/department_cubit.dart';
import 'package:flutter_rfid/common/global_blocs/user/user_cubit.dart';
import 'package:flutter_rfid/data/network/repositories/auth_repository.dart';
import 'package:flutter_rfid/data/network/repositories/device_repository.dart';
import 'package:flutter_rfid/data/network/repositories/manage_user_respository.dart';
import 'package:flutter_rfid/data/network/repositories/user_logs_repository.dart';
import 'package:flutter_rfid/ui/page/device_detail/device_detail_cubit.dart';
import 'package:flutter_rfid/ui/page/general/general_cubit.dart';
import 'package:flutter_rfid/ui/page/login/login_cubit.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_cubit.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_cubit.dart';
import 'package:flutter_rfid/ui/page/splash/splash_cubit.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:toastification/toastification.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'common/configs/app_configs.dart';
import 'common/global_blocs/setting/app_setting_cubit.dart';
import 'common/router/route_config.dart';
import 'data/network/api_config/api_client.dart';
import 'data/network/dio_client.dart';
import 'data/models/enums/language.dart';
import 'language/generated/l10n.dart';
import 'ui/common/app_colors.dart';
import 'ui/common/app_themes.dart';

part 'injector.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => injector<AuthRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppSettingCubit>(
              create: (context) =>
                  injector<AppSettingCubit>()..getInitialSetting()),
          BlocProvider<UserCubit>(
            create: (context) => injector<UserCubit>(),
          ),
          BlocProvider<DepartmentCubit>(
            create: (context) => injector<DepartmentCubit>(),
          ),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (previous, current) {
            return previous.themeMode != current.themeMode ||
                previous.primaryColor != current.primaryColor ||
                previous.isDynamicColor != current.isDynamicColor ||
                previous.language != current.language;
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: GlobalLoaderOverlay(
                overlayWidgetBuilder: (_) {
                  return Center(
                    child: Container(
                      color: AppColors.gray1,
                      width: 40,
                      height: 40,
                      child: Center(
                          child: Container(
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                          ),
                        ),
                      )),
                    ),
                  );
                },
                child: _buildMaterialApp(
                  locale: state.language.local,
                  theme: state.themeMode,
                  primaryColor: state.primaryColor,
                  isDynamicColor: state.isDynamicColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMaterialApp({
    required Locale locale,
    required ThemeMode theme,
    required Color primaryColor,
    required bool isDynamicColor,
  }) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme? lightColorScheme;
      ColorScheme? darkColorScheme;
      if (lightDynamic != null && darkDynamic != null && isDynamicColor) {
        lightColorScheme = lightDynamic;
        darkColorScheme = darkDynamic;
      } else {
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        );
        darkColorScheme = ColorScheme.fromSeed(
            seedColor: primaryColor, brightness: Brightness.dark);
      }
      return ToastificationWrapper(
        child: MaterialApp.router(
          title: AppConfigs.appName,
          debugShowCheckedModeBanner: false,
          theme: AppThemes(
            brightness:
                theme == ThemeMode.dark ? Brightness.dark : Brightness.light,
            primaryColor: theme == ThemeMode.dark
                ? darkColorScheme.primary
                : lightColorScheme.primary,
          ).theme.copyWith(
                colorScheme: theme == ThemeMode.dark
                    ? darkColorScheme
                    : lightColorScheme,
              ),
          routerConfig: AppRouter.router,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          locale: locale,
          supportedLocales: S.delegate.supportedLocales,
        ),
      );
    });
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
