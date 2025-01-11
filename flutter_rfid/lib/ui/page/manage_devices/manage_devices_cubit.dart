import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/data/models/request/create_device_request.dart';
import 'package:flutter_rfid/data/models/request/update_device_request.dart';
import 'package:flutter_rfid/data/network/repositories/device_repository.dart';
import 'package:flutter_rfid/ui/common/widgets/show_toast.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_state.dart';
import 'package:toastification/toastification.dart';

class ManageDevicesCubit extends Cubit<ManageDevicesState> {
  final DeviceRepository deviceRepository;

  ManageDevicesCubit(this.deviceRepository)
      : super(ManageDevicesState.initial());

  // get all devices
  Future<void> getDevices() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await deviceRepository.getDevices(
      page: state.currentPage,
      limit: state.itemsPerPage,
    );
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (devices) {
      emit(state.copyWith(
        loadStatus: LoadStatus.success,
        devices: devices.items ?? [],
        currentPage: devices.pagination?.currentPage ?? 1,
        totalPages: devices.pagination?.totalPages ?? 1,
      ));
    });
  }

  Future<void> deleteDevice(int id) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await deviceRepository.deleteDevice(id);
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (r) {
      final newDevices =
          state.devices.where((device) => device.id != id).toList();
      showToast(title: r, type: ToastificationType.success);
      emit(state.copyWith(loadStatus: LoadStatus.success, devices: newDevices));
    });
  }

  Future<void> addDevice({
    required String deviceName,
    required String deviceDep,
  }) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await deviceRepository.addDevice(CreateDeviceRequest(
      deviceName: deviceName,
      deviceDep: deviceDep,
    ));
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (r) {
      showToast(
          title: 'Thêm thiết bị thành công', type: ToastificationType.success);
      emit(state.copyWith(
          loadStatus: LoadStatus.success, devices: [r, ...state.devices]));
    });
  }

  Future<void> updateDevice({
    required int id,
    required String deviceName,
    required String deviceDep,
    required int deviceMode,
  }) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await deviceRepository.updateDevice(
        id,
        UpdateDeviceRequest(
          deviceName: deviceName,
          deviceDep: deviceDep,
          deviceMode: deviceMode,
        ));
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (r) {
      final newDevices = state.devices
          .map((device) => device.id == id
              ? device.copyWith(
                  deviceName: deviceName,
                  deviceDep: deviceDep,
                  deviceMode: deviceMode,
                )
              : device)
          .toList();
      showToast(title: r, type: ToastificationType.success);
      emit(state.copyWith(loadStatus: LoadStatus.success, devices: newDevices));
    });
  }

  Future<void> changeDeviceMode(DeviceEntity item, int deviceMode) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await deviceRepository.updateDevice(
        item.id!,
        UpdateDeviceRequest(
          deviceName: item.deviceName,
          deviceDep: item.deviceDep,
          deviceMode: deviceMode,
        ));
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (r) {
      final newDevices = state.devices
          .map((device) => device.id == item.id
              ? device.copyWith(
                  deviceMode: deviceMode,
                )
              : device)
          .toList();
      showToast(title: r, type: ToastificationType.success);
      emit(state.copyWith(loadStatus: LoadStatus.success, devices: newDevices));
    });
  }

  void changePage(int page) {
    emit(state.copyWith(currentPage: page));
    getDevices(); // Fetch users for the new page
  }

  void changeItemsPerPage(int itemsPerPage) {
    emit(state.copyWith(
      itemsPerPage: itemsPerPage,
      currentPage: 1, // Reset to first page when changing items per page
    ));
    getDevices(); // Fetch users with new page size
  }
}
