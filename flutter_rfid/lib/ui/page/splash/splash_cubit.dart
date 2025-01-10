import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/common/global_blocs/user/user_cubit.dart';
import 'package:flutter_rfid/data/database/share_preferences_helper.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/data/network/repositories/auth_repository.dart';
import 'package:flutter_rfid/ui/page/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepo;

  SplashCubit(this.authRepo) : super(SplashState.initial());

  Future<void> getUser() async {
    final isLogin = SharedPreferencesHelper().getApiToken().isNotEmpty;
    if (!isLogin) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(loadStatus: LoadStatus.success));
      return;
    }
    final result = await authRepo.getUserInfo();
    result.fold(
        (error) => emit(state.copyWith(
            loadStatus: LoadStatus.failure,
            message: error.message ?? 'Unexpected error occurred')),
        (response) {
      injector<UserCubit>().setUser(response);
      emit(state.copyWith(loadStatus: LoadStatus.success));
    });
  }
}
