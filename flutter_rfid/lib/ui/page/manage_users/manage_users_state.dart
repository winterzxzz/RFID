import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class ManageUsersState extends Equatable {
  final LoadStatus loadStatus;
  final String message;
  final List<ManageUserEntity> users;

  const ManageUsersState({
    required this.loadStatus,
    required this.message,
    required this.users,
  });

  // init state
  factory ManageUsersState.initial() => const ManageUsersState(
    loadStatus: LoadStatus.initial,
    message: '',
    users: [],
  );

  // copyWith
  ManageUsersState copyWith({
    LoadStatus? loadStatus,
    String? message,
    List<ManageUserEntity>? users,
  }) => ManageUsersState(
    loadStatus: loadStatus ?? this.loadStatus,
    message: message ?? this.message,
    users: users ?? this.users,
  );

  @override
  List<Object?> get props => [loadStatus, message, users];
}
