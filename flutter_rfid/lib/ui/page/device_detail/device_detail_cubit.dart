import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/models/entities/device_detail.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/data/network/repositories/device_repository.dart';
import 'package:flutter_rfid/ui/common/widgets/show_toast.dart';
import 'package:flutter_rfid/ui/page/device_detail/device_detail_state.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';

class DeviceDetailCubit extends Cubit<DeviceDetailState> {
  final DeviceRepository deviceRepository;

  DeviceDetailCubit(this.deviceRepository) : super(DeviceDetailState.initial());

  Future<void> getDeviceDetail(DeviceEntity device) async {
    Future.microtask(() {
      emit(state.copyWith(loadStatus: LoadStatus.loading, device: device));
    });
    final result = await deviceRepository.getDeviceDetail(device.id!);
    result.fold((l) {
      emit(state.copyWith(loadStatus: LoadStatus.failure, message: l.message));
    }, (r) {
      emit(state.copyWith(
        loadStatus: LoadStatus.success,
        deviceDetail: r,
      ));
    });
  }

  Future<void> deleteUserDevice(int userId, int deviceId) async {
    final result = await deviceRepository.deleteUserDevice(userId, deviceId);
    result.fold((error) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: error.message));
    }, (r) {
      final newList = state.deviceDetail
          .where((element) => element.userId != userId)
          .toList();
      emit(state.copyWith(
        loadStatus: LoadStatus.success,
        deviceDetail: newList,
      ));
      showToast(title: r, type: ToastificationType.success);
    });
  }

  Future<void> exportToExcel() async {
    try {
      emit(state.copyWith(exportStatus: LoadStatus.loading));

      // Get all users (not just current page)
      final result = await deviceRepository.getDeviceDetail(state.device!.id!);

      return result.fold((l) {
        emit(state.copyWith(
          exportStatus: LoadStatus.failure,
          message: 'Failed to export: ${l.message}',
        ));
      }, (r) async {
        final excel = Excel.createExcel();
        final sheet = excel['User Logs'];

        // Add headers
        sheet.appendRow([
          TextCellValue('ID | Tên'),
          TextCellValue('Mã sinh viên'),
          TextCellValue('Giới tính'),
          TextCellValue('Card UID'),
          TextCellValue('Ngày đăng ký'),
        ]);

        // Add data rows
        for (final DeviceDetail user in r) {
          sheet.appendRow([
            TextCellValue('${user.id} | ${user.username}'),
            TextCellValue(user.serialnumber ?? ''),
            TextCellValue(user.gender ?? ''),
            TextCellValue(user.cardUid ?? ''),
            TextCellValue(DateFormat('dd/MM/yyyy')
                .format(user.addDate ?? DateTime.now())),
            // Add more fields as needed
          ]);
        }

        // Get Documents directory
        final directory = await getDownloadsDirectory();
        final now =
            DateTime.now().toIso8601String().split('.')[0].replaceAll(':', '-');
        final fileName = 'user_logs_$now.xlsx';
        final filePath = '${directory?.path}/$fileName';

        // Save the file
        final fileBytes = excel.save();
        if (fileBytes != null) {
          File(filePath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(fileBytes);

          log('Excel file exported successfully to: $filePath');

          await OpenFile.open(filePath);

          emit(state.copyWith(
            exportStatus: LoadStatus.success,
            message: 'Excel file exported successfully to: $filePath',
          ));
        }
      });
    } catch (e) {
      emit(state.copyWith(
        exportStatus: LoadStatus.failure,
        message: 'Export failed: ${e.toString()}',
      ));
    }
  }
}
