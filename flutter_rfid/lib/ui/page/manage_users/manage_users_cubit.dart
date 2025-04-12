import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/common/configs/socket_config.dart';
import 'package:flutter_rfid/common/global_blocs/deparments/department_cubit.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/data/models/request/user_update_request.dart';
import 'package:flutter_rfid/data/network/repositories/manage_user_respository.dart';
import 'package:flutter_rfid/ui/common/widgets/show_toast.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_state.dart';
import 'package:toastification/toastification.dart';

class ManageUsersCubit extends Cubit<ManageUsersState> {
  final ManageUserRepository manageUserRepository;

  ManageUsersCubit(this.manageUserRepository)
      : super(ManageUsersState.initial()) {
    SocketConfig.socket.on('add-card', (data) async {
      final newUser = ManageUserEntity.fromJson(data['data']);
      // if user already exist, update it else add it
      if (isUserExist(newUser)) {
        final newList = state.users
            .map((user) => user.id == newUser.id ? newUser : user)
            .toList();
        emit(state.copyWith(users: newList));
      } else {
        final newList = [newUser, ...state.users];
        emit(state.copyWith(users: newList));
      }
    });
  }

  bool isUserExist(ManageUserEntity user) {
    return state.users.any((u) => u.id == user.id);
  }

  Future<void> getUsers() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await manageUserRepository.getUsers(
        page: state.currentPage, limit: state.itemsPerPage);
    result.fold((l) {
      emit(state.copyWith(loadStatus: LoadStatus.failure, message: l.message));
    }, (r) {
      final currentPage = r.pagination?.currentPage ?? 1;
      final totalPage = r.pagination?.totalPages ?? 1;
      injector<DepartmentCubit>()
          .changeDepartments(departments: r.departments ?? []);
      emit(state.copyWith(
        loadStatus: LoadStatus.success,
        users: r.items,
        currentPage: currentPage,
        totalPages: totalPage,
      ));
    });
  }

  Future<void> deleteUser(int id) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await manageUserRepository.deleteUser(id);
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (r) {
      final newUsers = state.users.where((user) => user.id != id).toList();
      showToast(title: r, type: ToastificationType.success);
      emit(state.copyWith(loadStatus: LoadStatus.success, users: newUsers));
    });
  }

  Future<void> updateUser({
    required int id,
    required String username,
    required String serialnumber,
    required String gender,
    required String email,
  }) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await manageUserRepository.updateUser(UserUpdateRequest(
      id: id,
      username: username,
      serialnumber: serialnumber,
      gender: gender,
      email: email,
    ));
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (r) {
      final newUsers = state.users
          .map((user) => user.id == id
              ? user.copyWith(
                  username: username,
                  serialnumber: serialnumber,
                  gender: gender,
                  email: email,
                )
              : user)
          .toList();
      showToast(title: r, type: ToastificationType.success);
      emit(state.copyWith(loadStatus: LoadStatus.success, users: newUsers));
    });
  }

  void changePage(int page) {
    emit(state.copyWith(currentPage: page));
    getUsers(); // Fetch users for the new page
  }

  void changeItemsPerPage(int itemsPerPage) {
    emit(state.copyWith(
      itemsPerPage: itemsPerPage,
      currentPage: 1, // Reset to first page when changing items per page
    ));
    getUsers(); // Fetch users with new page size
  }
}
