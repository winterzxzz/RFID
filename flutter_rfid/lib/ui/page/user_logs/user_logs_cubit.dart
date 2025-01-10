import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/data/network/repositories/user_logs_repository.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_state.dart';

class UserLogsCubit extends Cubit<UserLogsState> {
  final UserLogsRepository userLogsRepository;

  UserLogsCubit(this.userLogsRepository) : super(UserLogsState.initial());

  Future<void> getUsers() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await userLogsRepository.getUsers();
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (users) {
      emit(state.copyWith(loadStatus: LoadStatus.success, users: users));
    });
  }
}
