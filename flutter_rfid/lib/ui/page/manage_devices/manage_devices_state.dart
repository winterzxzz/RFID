import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class ManageDevicesState extends Equatable {
  final LoadStatus loadStatus;
  final String message;
  final List<DeviceEntity> devices;
  final int currentPage;
  final int totalPages;
  final int itemsPerPage;

  const ManageDevicesState({
    required this.loadStatus,
    required this.message,
    required this.devices,
    required this.currentPage,
    required this.totalPages,
    required this.itemsPerPage,
  });

  // initial state
  factory ManageDevicesState.initial() => const ManageDevicesState(
        loadStatus: LoadStatus.initial,
        message: '',
        devices: [],
        currentPage: 1,
        totalPages: 1,
        itemsPerPage: 10,
      );

  // copyWith method

  ManageDevicesState copyWith({
    LoadStatus? loadStatus,
    String? message,
    List<DeviceEntity>? devices,
    int? currentPage,
    int? totalPages,
    int? itemsPerPage,
  }) =>
      ManageDevicesState(
        loadStatus: loadStatus ?? this.loadStatus,
        message: message ?? this.message,
        devices: devices ?? this.devices,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      );

  @override
  List<Object?> get props => [
        loadStatus,
        message,
        devices,
        currentPage,
        totalPages,
        itemsPerPage,
      ];
}
