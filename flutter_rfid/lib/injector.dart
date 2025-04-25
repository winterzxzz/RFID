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
    ..registerFactory<SplashCubit>(() => SplashCubit(injector()))
    ..registerFactory<LoginCubit>(() => LoginCubit(injector()))
    ..registerFactory<GeneralCubit>(() => GeneralCubit())
    ..registerFactory<AppSettingCubit>(() => AppSettingCubit())
    ..registerLazySingleton<DepartmentCubit>(() => DepartmentCubit())
    ..registerLazySingleton<ManageUserRepository>(() => ManageUserRepositoryImpl(injector()))
    ..registerFactory<ManageUsersCubit>(() => ManageUsersCubit(injector()))
    ..registerLazySingleton<UserLogsRepository>(() => UserLogsRepositoryImpl(injector()))
    ..registerFactory<UserLogsCubit>(() => UserLogsCubit(injector()))
    ..registerLazySingleton<DeviceRepository>(() => DeviceRepositoryImpl(injector()))
    ..registerFactory<ManageDevicesCubit>(() => ManageDevicesCubit(injector()))
    ..registerFactory<DeviceDetailCubit>(() => DeviceDetailCubit(injector()));


}
