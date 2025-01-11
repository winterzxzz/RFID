import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class ManageUsersState extends Equatable {
  final LoadStatus loadStatus;
  final String message;
  final List<ManageUserEntity> users;
  final int currentPage;
  final int totalPages;
  final int itemsPerPage;

  const ManageUsersState({
    required this.loadStatus,
    required this.message,
    required this.users,
    this.currentPage = 1,
    this.totalPages = 1,
    this.itemsPerPage = 20,
  });

  // init state
  factory ManageUsersState.initial() => const ManageUsersState(
        loadStatus: LoadStatus.initial,
        message: '',
        users: [],
        currentPage: 1,
        totalPages: 1,
        itemsPerPage: 20,
      );

  // copyWith
  ManageUsersState copyWith({
    LoadStatus? loadStatus,
    String? message,
    List<ManageUserEntity>? users,
    int? currentPage,
    int? totalPages,
    int? itemsPerPage,
  }) =>
      ManageUsersState(
        loadStatus: loadStatus ?? this.loadStatus,
        message: message ?? this.message,
        users: users ?? this.users,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      );

  @override
  List<Object?> get props => [
        loadStatus,
        message,
        users,
        currentPage,
        totalPages,
        itemsPerPage,
      ];
}
