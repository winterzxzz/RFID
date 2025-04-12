part of 'app.dart';

final injector = GetIt.instance;

Future<void> init() async {
  injector
    ..registerLazySingleton<Dio>(() => DioClient.createNewDio())
    ..registerLazySingleton<ApiClient>(
        () => ApiClient(injector(), baseUrl: AppConfigs.baseUrl))
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(injector()))
    ..registerLazySingleton<UserCubit>(() => UserCubit())
    ..registerLazySingleton<SplashCubit>(() => SplashCubit(injector()))
    ..registerLazySingleton<LoginCubit>(() => LoginCubit(injector()))
    ..registerLazySingleton<GeneralCubit>(() => GeneralCubit())
    ..registerLazySingleton<AppSettingCubit>(() => AppSettingCubit())
    ..registerLazySingleton<DepartmentCubit>(() => DepartmentCubit())
    ..registerLazySingleton<ManageUserRepository>(() => ManageUserRepositoryImpl(injector()))
    ..registerFactory<ManageUsersCubit>(() => ManageUsersCubit(injector()))
    ..registerLazySingleton<UserLogsRepository>(() => UserLogsRepositoryImpl(injector()))
    ..registerFactory<UserLogsCubit>(() => UserLogsCubit(injector()))
    ..registerLazySingleton<DeviceRepository>(() => DeviceRepositoryImpl(injector()))
    ..registerFactory<ManageDevicesCubit>(() => ManageDevicesCubit(injector()))
    ..registerFactory<DeviceDetailCubit>(() => DeviceDetailCubit(injector()));


}
