

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/common/global_blocs/user/user_state.dart';
import 'package:flutter_rfid/data/models/entities/user_entity.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(user: UserEntity()));

  void setUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  void clearUser() {
    emit(UserState.initial());
  }
}
