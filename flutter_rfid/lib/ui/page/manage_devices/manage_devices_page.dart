import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/ui/common/widgets/build_pagination_number.dart';
import 'package:flutter_rfid/ui/common/widgets/confirm_dia_log.dart';
import 'package:flutter_rfid/ui/common/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_cubit.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_state.dart';
import 'package:flutter_rfid/ui/page/manage_devices/widgets/form_update_device.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              title: const Text('Manage Devices'),
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
                      child: Center(child: Text('No users found')),
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
                                  1: FixedColumnWidth(80), // Room
                                  2: FixedColumnWidth(150), // Device UID
                                  3: FixedColumnWidth(100), // Date
                                  4: FixedColumnWidth(150), // Status
                                  5: FixedColumnWidth(100), // Actions
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
                                            child: Text('Device Name'),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Room'),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Device UID'),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Date'),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Status'),
                                          )),
                                      TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Actions'),
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
                                                  user.deviceName ?? 'None'),
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
                                                  user.deviceUid ?? 'None'),
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
                                                      .format(user.deviceDate ??
                                                          DateTime.now())),
                                            )),
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        user.deviceMode == 0
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            ManageDevicesCubit>()
                                                        .changeDeviceMode(
                                                            user, 0);
                                                  },
                                                  child:
                                                      const Text('Enrollment'),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                width: 120,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        user.deviceMode == 1
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            ManageDevicesCubit>()
                                                        .changeDeviceMode(
                                                            user, 1);
                                                  },
                                                  child:
                                                      const Text('Attendance'),
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
    return showConfirmDialog(context, 'Delete Device',
        'Are you sure you want to delete this device?', () {
      context.read<ManageDevicesCubit>().deleteDevice(id);
    });
  }

  void _onAdd(BuildContext context) {
    showCustomModalBottomSheet(
        context,
        BlocProvider.value(
          value: context.read<ManageDevicesCubit>(),
          child: const FormUpdateDevice(device: null),
        ));
  }

  void _onEdit(BuildContext context, DeviceEntity device) {
    showCustomModalBottomSheet(
        context,
        BlocProvider.value(
          value: context.read<ManageDevicesCubit>(),
          child: FormUpdateDevice(device: device),
        ));
  }
}