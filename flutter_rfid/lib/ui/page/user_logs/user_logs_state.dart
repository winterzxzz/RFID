import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rfid/data/models/entities/user_log_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class UserLogsState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus exportStatus;
  final String message;
  final List<UserLogEntity> users;
  final int currentPage;
  final int totalPages;
  final int itemsPerPage;
  final DateTimeRange? dateRange;
  final String? deviceDep;

  const UserLogsState({
    required this.loadStatus,
    required this.exportStatus,
    required this.message,
    required this.users,
    this.currentPage = 1,
    this.totalPages = 1,
    this.itemsPerPage = 20,
    this.dateRange,
    this.deviceDep,
  });

  // init state
  factory UserLogsState.initial() => const UserLogsState(
        loadStatus: LoadStatus.initial,
        exportStatus: LoadStatus.initial,
        message: '',
        users: [],
        dateRange: null,
        deviceDep: null,
      );

  // copyWith
  UserLogsState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? exportStatus,
    String? message,
    List<UserLogEntity>? users,
    int? currentPage,
    int? totalPages,
    int? itemsPerPage,
    DateTimeRange? dateRange,
    String? deviceDep,
  }) =>
      UserLogsState(
        loadStatus: loadStatus ?? this.loadStatus,
        exportStatus: exportStatus ?? this.exportStatus,
        message: message ?? this.message,
        users: users ?? this.users,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        itemsPerPage: itemsPerPage ?? this.itemsPerPage,
        dateRange: dateRange ?? this.dateRange,
        deviceDep: deviceDep ?? this.deviceDep,
      );

  @override
  List<Object?> get props => [
        loadStatus,
        exportStatus,
        message,
        users,
        currentPage,
        totalPages,
        itemsPerPage,
        dateRange,
        deviceDep,
      ];
}
