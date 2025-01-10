import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/entities/user_log_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class UserLogsState extends Equatable {
  final LoadStatus loadStatus;
  final String message;
  final List<UserLogEntity> users;

  const UserLogsState({
    required this.loadStatus,
    required this.message,
    required this.users,
  });

  // init state
  factory UserLogsState.initial() => const UserLogsState(
    loadStatus: LoadStatus.initial,
    message: '',
    users: [],
  );

  // copyWith
  UserLogsState copyWith({
    LoadStatus? loadStatus,
    String? message,
    List<UserLogEntity>? users,
  }) => UserLogsState(
    loadStatus: loadStatus ?? this.loadStatus,
    message: message ?? this.message,
    users: users ?? this.users,
  );

  @override
  List<Object?> get props => [loadStatus, message, users];
}
