import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/entities/device_detail.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';

class DeviceDetailState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus exportStatus;
  final String message;
  final DeviceEntity? device;
  final List<DeviceDetail> deviceDetail;

  const DeviceDetailState({
    required this.loadStatus,
    required this.exportStatus,
    required this.message,
    this.device,
    required this.deviceDetail,
  });

  // init state
  factory DeviceDetailState.initial() => const DeviceDetailState(
        loadStatus: LoadStatus.initial,
        exportStatus: LoadStatus.initial,
        message: '',
        device: null,
        deviceDetail: [],
      );

  // copyWith
  DeviceDetailState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? exportStatus,
    String? message,
    DeviceEntity? device,
    List<DeviceDetail>? deviceDetail,
  }) =>
      DeviceDetailState(
        loadStatus: loadStatus ?? this.loadStatus,
        exportStatus: exportStatus ?? this.exportStatus,
        message: message ?? this.message,
        device: device ?? this.device,
        deviceDetail: deviceDetail ?? this.deviceDetail,
      );

  @override
  List<Object?> get props => [
        loadStatus,
        exportStatus,
        message,
        device,
        deviceDetail,
      ];
}
