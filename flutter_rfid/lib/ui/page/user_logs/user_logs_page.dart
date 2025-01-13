import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/ui/common/app_navigator.dart';
import 'package:flutter_rfid/ui/common/widgets/build_pagination_number.dart';
import 'package:flutter_rfid/ui/common/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter_rfid/ui/common/widgets/show_toast.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_cubit.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_state.dart';
import 'package:flutter_rfid/ui/page/user_logs/widgets/form_filter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class UserLogsPage extends StatelessWidget {
  const UserLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<UserLogsCubit>()..getUsers(),
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
    final navigator = AppNavigator(context: context);
    return BlocListener<UserLogsCubit, UserLogsState>(
      listenWhen: (previous, current) =>
          previous.exportStatus != current.exportStatus,
      listener: (context, state) {
        if (state.exportStatus == LoadStatus.loading) {
          navigator.showLoadingOverlay();
        } else {
          navigator.hideLoadingOverlay();
          if (state.exportStatus == LoadStatus.success) {
            showToast(
                title: 'Exported to Excel successfully',
                type: ToastificationType.success);
          } else if (state.exportStatus == LoadStatus.failure) {
            showToast(
                title: 'Failed to export', type: ToastificationType.error);
          }
        }
      },
      child: Scaffold(
        body: EasyRefresh(
          header: const BezierHeader(
            position: IndicatorPosition.above,
          ),
          onRefresh: () => context.read<UserLogsCubit>().getUsers(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text('User Logs'),
                floating: true,
                snap: true,
                actions: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.fileExcel, size: 20),
                    onPressed: () =>
                        context.read<UserLogsCubit>().exportToExcel(),
                  ),
                  // menu to filter
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.bars, size: 20),
                    onPressed: () => _onFilter(context),
                  ),
                ],
              ),
              BlocBuilder<UserLogsCubit, UserLogsState>(
                builder: (context, state) {
                  if (state.loadStatus == LoadStatus.loading) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state.loadStatus == LoadStatus.success) {
                    if (state.users.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(child: Text('No user logs found')),
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
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
                                    2: FixedColumnWidth(120), // Card UID
                                    3: FixedColumnWidth(120), // Department
                                    4: FixedColumnWidth(120), // Date
                                    5: FixedColumnWidth(100), // Time in
                                    6: FixedColumnWidth(100), // Time out
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
                                          child: Text('ID/Username'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Serial Number'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Card UID'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Department'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Date'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Time in'),
                                        )),
                                        TableCell(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Time out'),
                                        )),
                                      ],
                                    ),
                                    ...state.users.map((user) {
                                      return TableRow(
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
                                            child: Text(
                                                user.serialnumber ?? 'None'),
                                          )),
                                          TableCell(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(user.cardUid ?? 'None'),
                                          )),
                                          TableCell(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text(user.deviceDep ?? 'None'),
                                          )),
                                          TableCell(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(DateFormat('dd/MM/yyyy')
                                                .format((user.checkindate ??
                                                        DateTime.now())
                                                    .toLocal())),
                                          )),
                                          TableCell(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(user.timein ?? 'None'),
                                          )),
                                          TableCell(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(user.timeout ?? 'None'),
                                          )),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.chevron_left),
                                      onPressed: state.currentPage > 1
                                          ? () => context
                                              .read<UserLogsCubit>()
                                              .changePage(state.currentPage - 1)
                                          : null,
                                    ),
                                    ...buildPaginationNumbers(
                                      currentPage: state.currentPage,
                                      totalPages: state.totalPages,
                                      onPageSelected: (page) => context
                                          .read<UserLogsCubit>()
                                          .changePage(page),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.chevron_right),
                                      onPressed: state.currentPage <
                                              state.totalPages
                                          ? () => context
                                              .read<UserLogsCubit>()
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
                                          .read<UserLogsCubit>()
                                          .changeItemsPerPage(value!),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
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
      ),
    );
  }

  void _onFilter(BuildContext context) {
    showCustomModalBottomSheet(
      context,
      BlocProvider.value(
        value: context.read<UserLogsCubit>(),
        child: const FormFilter(),
      ),
    );
  }
}
