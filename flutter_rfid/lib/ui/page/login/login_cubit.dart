import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/common/global_blocs/user/user_cubit.dart';
import 'package:flutter_rfid/common/utils/app_validartor.dart';
import 'package:flutter_rfid/data/database/share_preferences_helper.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/data/models/request/login_request.dart';
import 'package:flutter_rfid/data/network/repositories/auth_repository.dart';
import 'package:flutter_rfid/language/generated/l10n.dart';
import 'package:flutter_rfid/ui/page/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepo;

  LoginCubit(this.authRepo) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      if (!AppValidator.validateEmpty(email)) {
        throw (S.current.empty_email_error);
      }
      if (!AppValidator.validateEmpty(password)) {
        throw (S.current.empty_password_error);
      }


      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final result = await authRepo.login(LoginRequest(adminEmail: email, adminPwd: password));
      result.fold(
          (error) => emit(state.copyWith(
              loadStatus: LoadStatus.failure,
              errorMessage: error.message)), (response) async{
        injector<UserCubit>().setUser(response.data!);
        await SharedPreferencesHelper().saveApiToken(response.token ?? '');
        emit(state.copyWith(loadStatus: LoadStatus.success));
      });
    } catch (e) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, errorMessage: e.toString()));
    }
  }
}
