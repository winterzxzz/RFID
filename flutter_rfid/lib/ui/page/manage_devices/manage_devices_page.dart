import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/common/router/route_config.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/ui/common/widgets/build_pagination_number.dart';
import 'package:flutter_rfid/ui/common/widgets/confirm_dia_log.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_cubit.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ManageDevicesPage extends StatelessWidget {
  const ManageDevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ManageDevicesCubit>()..getDevices(),
      child: const Page(),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh(
        header: const BezierHeader(
          position: IndicatorPosition.above,
        ),
        onRefresh: () => context.read<ManageDevicesCubit>().getDevices(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: const Text('QUẢN LÝ THIẾT BỊ'),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.plus),
                  onPressed: () => _onAdd(context),
                ),
              ],
            ),
            BlocBuilder<ManageDevicesCubit, ManageDevicesState>(
              builder: (context, state) {
                if (state.loadStatus == LoadStatus.loading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state.loadStatus == LoadStatus.success) {
                  if (state.devices.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text('Không có dữ liệu')),
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
                                  0: FixedColumnWidth(100), // Device Name
                                  1: FixedColumnWidth(100), // Room
                                  // 2: FixedColumnWidth(150), // Device UID
                                  2: FixedColumnWidth(100), // Date
                                  3: FixedColumnWidth(250), // Status
                                  4: FixedColumnWidth(200), // Actions
                                },
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent[100],
                                    ),
                                    children: const [
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('ID | TÊN'),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('PHÒNG'),
                                          )),

                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('NGÀY TẠO'),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('TRẠNG THÁI'),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('HÀNH ĐỘNG'),
                                          )),
                                    ],
                                  ),
                                  ...state.devices.map((user) {
                                    return TableRow(
                                      children: [
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${user.id} | ${user.deviceName}'),
                                            )),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  user.deviceDep ?? 'None'),
                                            )),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  DateFormat('dd/MM/yyyy')
                                                      .format((user
                                                                  .deviceDate ??
                                                              DateTime.now())
                                                          .toLocal())),
                                            )),
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 33,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 0,
                                                        horizontal: 12),
                                                    backgroundColor:
                                                        user.deviceMode == 0
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            ManageDevicesCubit>()
                                                        .changeDeviceMode(
                                                            user, 0);
                                                  },
                                                  child: const Text(
                                                    'ĐĂNG KÝ',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              SizedBox(
                                                height: 33,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 0,
                                                        horizontal: 12),
                                                    backgroundColor:
                                                        user.deviceMode == 1
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            ManageDevicesCubit>()
                                                        .changeDeviceMode(
                                                            user, 1);
                                                  },
                                                  child: const Text(
                                                    'ĐIỂM DANH',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.eye,
                                                    size: 16,
                                                  ),
                                                  onPressed: () =>
                                                      _onViewDetail(
                                                          context, user),
                                                ),
                                                IconButton(
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons
                                                        .penToSquare,
                                                    size: 16,
                                                  ),
                                                  onPressed: () =>
                                                      _onEdit(context, user),
                                                ),
                                                IconButton(
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.trash,
                                                    size: 16,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    if (user.id != null) {
                                                      _onDelete(
                                                          context, user.id!);
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.chevron_left),
                                    onPressed: state.currentPage > 1
                                        ? () => context
                                            .read<ManageDevicesCubit>()
                                            .changePage(state.currentPage - 1)
                                        : null,
                                  ),
                                  ...buildPaginationNumbers(
                                    currentPage: state.currentPage,
                                    totalPages: state.totalPages,
                                    onPageSelected: (page) => context
                                        .read<ManageDevicesCubit>()
                                        .changePage(page),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.chevron_right),
                                    onPressed: state.currentPage <
                                            state.totalPages
                                        ? () => context
                                            .read<ManageDevicesCubit>()
                                            .changePage(state.currentPage + 1)
                                        : null,
                                  ),
                                  const SizedBox(width: 16),
                                  DropdownButton<int>(
                                    alignment: Alignment.center,
                                    value: state.itemsPerPage,
                                    items: [10, 20, 30, 40, 50, 70, 100]
                                        .map((value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('$value / page'),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) => context
                                        .read<ManageDevicesCubit>()
                                        .changeItemsPerPage(value!),
                                  ),
                                ],
                              )
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

  void _onDelete(BuildContext context, int id) {
    return showConfirmDialog(context, 'Xóa thiết bị',
        'Bạn có chắc chắn muốn xóa thiết bị này?', () {
      context.read<ManageDevicesCubit>().deleteDevice(id);
    });
  }

  void _onAdd(BuildContext context) {
    // showCustomModalBottomSheet(
    //     context,
    //     BlocProvider.value(
    //       value: context.read<ManageDevicesCubit>(),
    //       child: const FormUpdateDevice(device: null),
    //     ));
    GoRouter.of(context).pushNamed(AppRouter.updateDevice, extra: {
      'device': null,
      'cubit': context.read<ManageDevicesCubit>(),
    });
  }

  void _onEdit(BuildContext context, DeviceEntity device) {
    // showCustomModalBottomSheet(
    //     context,
    //     BlocProvider.value(
    //       value: context.read<ManageDevicesCubit>(),
    //       child: FormUpdateDevice(device: device),
    //     ));
    GoRouter.of(context).pushNamed(AppRouter.updateDevice, extra: {
      'device': device,
      'cubit': context.read<ManageDevicesCubit>(),
    });
  }

  void _onViewDetail(BuildContext context, DeviceEntity device) {
    GoRouter.of(context).pushNamed(AppRouter.deviceDetail, extra: {
      'device': device,
    });
  }
}
