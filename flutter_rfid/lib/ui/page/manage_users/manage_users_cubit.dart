
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/data/models/request/user_update_request.dart';
import 'package:flutter_rfid/data/network/repositories/manage_user_respository.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_state.dart';

class ManageUsersCubit extends Cubit<ManageUsersState> {
  final ManageUserRepository manageUserRepository;

  ManageUsersCubit(this.manageUserRepository) : super(ManageUsersState.initial());

  Future<void> getUsers() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await manageUserRepository.getUsers();
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failure, message: error.message));
    }, (users) {
      emit(state.copyWith(loadStatus: LoadStatus.success, users: users));
    });
  }

  Future<void> deleteUser(int id) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await manageUserRepository.deleteUser(id);
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failure, message: error.message));
    }, (users) {
      final newUsers = state.users.where((user) => user.id != id).toList();
      emit(state.copyWith(loadStatus: LoadStatus.success, users: newUsers));
    });
  }

  Future<void> updateUser({
    required int id,
    required String username,
    required String serialnumber,
    required String gender,
    required String email,
    required String deviceDep,
  }) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await manageUserRepository.updateUser(UserUpdateRequest(
      id: id,
      username: username,
      serialnumber: serialnumber,
      gender: gender,
      email: email,
      deviceDep: deviceDep,
    ));
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failure, message: error.message));
    }, (users) {
      final newUsers = state.users.map((user) => user.id == id ? user.copyWith(
        username: username,
        serialnumber: serialnumber,
        gender: gender,
        email: email,
        deviceDep: deviceDep,
      ) : user).toList();
      emit(state.copyWith(loadStatus: LoadStatus.success, users: newUsers));
    });
  }
}
