import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class ManageDevicesState extends Equatable {
  final LoadStatus loadStatus;
  final String message;
  final List<DeviceEntity> devices;

  const ManageDevicesState({
    required this.loadStatus,
    required this.message,
    required this.devices,
  });

  // initial state
  factory ManageDevicesState.initial() => const ManageDevicesState(
        loadStatus: LoadStatus.initial,
        message: '',
        devices: [],
      );

  // copyWith method

  ManageDevicesState copyWith({
    LoadStatus? loadStatus,
    String? message,
    List<DeviceEntity>? devices,
  }) =>
      ManageDevicesState(
        loadStatus: loadStatus ?? this.loadStatus,
        message: message ?? this.message,
        devices: devices ?? this.devices,
      );

  @override
  List<Object?> get props => [loadStatus, message, devices];
}
