

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/network/repositories/device_repository.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_state.dart';

class ManageDevicesCubit extends Cubit<ManageDevicesState> {
  final DeviceRepository deviceRepository;

  ManageDevicesCubit(this.deviceRepository) : super(ManageDevicesState.initial());


  // get all devices
  Future<void> getDevices() async {
    // final response = await deviceRepository.();
    // response.fold((l) => emit(state.copyWith(error: l.message)), (r) => emit(state.copyWith(devices: r)));
  }
}
