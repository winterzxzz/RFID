import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/models/entities/user_log_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/data/network/repositories/user_logs_repository.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_state.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class UserLogsCubit extends Cubit<UserLogsState> {
  final UserLogsRepository userLogsRepository;

  UserLogsCubit(this.userLogsRepository) : super(UserLogsState.initial());

  Future<void> getUsers() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    log('dateRange: ${state.dateRange}');
    log('deviceDep: ${state.deviceDep}');
    final result = await userLogsRepository.getUsers(
      page: state.currentPage,
      limit: state.itemsPerPage,
      dateStart: state.dateRange?.start.toIso8601String().split('T')[0],
      dateEnd: state.dateRange?.end.toIso8601String().split('T')[0],
      deviceDep: state.deviceDep,
    );
    result.fold((l) {
      emit(state.copyWith(loadStatus: LoadStatus.failure, message: l.message));
    }, (r) {
      final currentPage = r.pagination?.currentPage ?? 1;
      final totalPages = r.pagination?.totalPages ?? 1;
      emit(state.copyWith(
          loadStatus: LoadStatus.success,
          users: r.items,
          currentPage: currentPage,
          totalPages: totalPages));
    });
  }

  void changePage(int page) {
    emit(state.copyWith(currentPage: page));
    getUsers(); // Fetch users for the new page
  }

  void changeItemsPerPage(int itemsPerPage) {
    emit(state.copyWith(
      itemsPerPage: itemsPerPage,
      currentPage: 1, // Reset to first page when changing items per page
    ));
    getUsers(); // Fetch users with new page size
  }

  void applyFilters({
    DateTimeRange? dateRange,
    String? department,
  }) {
    // Update your state and fetch filtered data
    // date format yyyy-MM-dd
    emit(state.copyWith(
      dateRange: dateRange,
      deviceDep: department,
    ));
    getUsers();
  }

  Future<void> clearFilters() async {
    emit(UserLogsState.initial());
    await getUsers();
  }

  Future<void> exportToExcel() async {
    try {
      emit(state.copyWith(exportStatus: LoadStatus.loading));

      // Get all users (not just current page)
      final result = await userLogsRepository.getUsers(
        dateStart: state.dateRange?.start.toIso8601String().split('T')[0],
        dateEnd: state.dateRange?.end.toIso8601String().split('T')[0],
        deviceDep: state.deviceDep,
      );

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
          TextCellValue('ID'),
          TextCellValue('Name'),
          TextCellValue('Serial Number'),
          TextCellValue('Card UID'),
          TextCellValue('Department'),
          TextCellValue('Date'),
          TextCellValue('Time In'),
          TextCellValue('Time Out'),
        ]);

        // Add data rows
        for (final UserLogEntity user in r.items ?? []) {
          sheet.appendRow([
            IntCellValue(user.id ?? 0),
            TextCellValue(user.username ?? ''),
            TextCellValue(user.serialnumber ?? ''),
            TextCellValue(user.cardUid ?? ''),
            TextCellValue(user.deviceDep ?? ''),
            TextCellValue(DateFormat('dd/MM/yyyy')
                .format(user.checkindate ?? DateTime.now())),
            TextCellValue(user.timein ?? ''),
            TextCellValue(user.timeout ?? ''),
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
