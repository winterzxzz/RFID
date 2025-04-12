import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/ui/common/app_navigator.dart';
import 'package:flutter_rfid/ui/common/widgets/confirm_dia_log.dart';
import 'package:flutter_rfid/ui/common/widgets/show_toast.dart';
import 'package:flutter_rfid/ui/page/device_detail/device_detail_cubit.dart';
import 'package:flutter_rfid/ui/page/device_detail/device_detail_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class DeviceDetailPage extends StatelessWidget {
  final DeviceEntity device;
  const DeviceDetailPage({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          injector<DeviceDetailCubit>()..getDeviceDetail(device),
      child: Page(device: device),
    );
  }
}

class Page extends StatelessWidget {
  final DeviceEntity device;
  const Page({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh(
        header: const BezierHeader(
          position: IndicatorPosition.above,
        ),
        onRefresh: () =>
            context.read<DeviceDetailCubit>().getDeviceDetail(device),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: const Text('Manage Users'),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.fileExcel, size: 20),
                  onPressed: () =>
                      context.read<DeviceDetailCubit>().exportToExcel(),
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.circleInfo, size: 20),
                  onPressed: () => _onInfo(context, device),
                ),
              ],
            ),
            BlocConsumer<DeviceDetailCubit, DeviceDetailState>(
              listener: (context, state) {
                if (state.loadStatus == LoadStatus.loading ||
                    state.exportStatus == LoadStatus.loading) {
                  AppNavigator(context: context).showLoadingOverlay();
                } else {
                  AppNavigator(context: context).hideLoadingOverlay();

                  if (state.loadStatus == LoadStatus.failure ||
                      state.exportStatus == LoadStatus.failure) {
                    showToast(
                        title: state.message, type: ToastificationType.error);
                  } else if (state.loadStatus == LoadStatus.success ||
                      state.exportStatus == LoadStatus.success) {
                    showToast(
                        title: state.message, type: ToastificationType.success);
                  }
                }
              },
              builder: (context, state) {
                if (state.loadStatus == LoadStatus.success) {
                  if (state.deviceDetail.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text('No device detail found')),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Table(
                                border: TableBorder.all(),
                                columnWidths: const {
                                  0: FixedColumnWidth(200), // ID/Username
                                  1: FixedColumnWidth(120), // Serial Number
                                  2: FixedColumnWidth(100), // Gender
                                  3: FixedColumnWidth(150), // Card UID
                                  4: FixedColumnWidth(120), // Department
                                  5: FixedColumnWidth(150), // Date
                                  6: FixedColumnWidth(120), // Actions
                                },
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent[100],
                                    ),
                                    children: const [
                                      TableCell(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('ID | Tên'),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('MÃ SINH VIÊN'),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('GIỚI TÍNH'),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('EMAIL'),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Card UID'),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('NGÀY ĐĂNG KÝ'),
                                      )),
                                      TableCell(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('HÀNH ĐỘNG'),
                                      )),
                                    ],
                                  ),
                                  ...state.deviceDetail.map((user) {
                                    return TableRow(
                                      decoration: BoxDecoration(
                                        color: user.addCard == 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5)
                                            : null,
                                      ),
                                      children: [
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              '${user.id} | ${user.username}'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Text(user.serialnumber ?? 'None'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(user.gender ?? 'None'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(user.email ?? 'None'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(user.cardUid ?? 'None'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(DateFormat('dd/MM/yyyy')
                                              .format((user.userDate ??
                                                      DateTime.now())
                                                  .toLocal())),
                                        )),
                                        TableCell(
                                            child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const FaIcon(
                                                FontAwesomeIcons.trash,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                if (user.id != null) {
                                                  _onDelete(context, user.id!,
                                                      device.id!);
                                                }
                                              },
                                            ),
                                          ],
                                        )),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onDelete(BuildContext context, int userId, int deviceId) {
    return showConfirmDialog(
        context, 'Xóa tài khoản', 'Bạn có chắc chắn muốn xóa tài khoản này?',
        () {
      context.read<DeviceDetailCubit>().deleteUserDevice(userId, deviceId);
    });
  }

  Future<void> _onInfo(BuildContext context, DeviceEntity device) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Text(
                  device.deviceName ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  device.deviceDep ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4AF37),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.link, color: Color(0xFFD4AF37)),
                  SizedBox(width: 8),
                  Text(
                    'Trạng thái:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'ĐĂNG KÝ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.email, color: Color(0xFFD4AF37)),
                  const SizedBox(width: 8),
                  const Text(
                    'ID:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${device.id ?? "N/A"}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.devices, color: Color(0xFFD4AF37)),
                  const SizedBox(width: 8),
                  const Text(
                    'Mã thiết bị:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    device.deviceUid ?? "N/A",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.date_range, color: Color(0xFFD4AF37)),
                  const SizedBox(width: 8),
                  const Text(
                    'Ngày cập nhật:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    device.deviceDate != null
                        ? DateFormat('dd/MM/yyyy')
                            .format(device.deviceDate!.toLocal())
                        : "N/A",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
