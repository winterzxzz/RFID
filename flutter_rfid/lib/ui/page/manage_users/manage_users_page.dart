import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/common/router/route_config.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/ui/common/widgets/build_pagination_number.dart';
import 'package:flutter_rfid/ui/common/widgets/confirm_dia_log.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_cubit.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ManageUsersPage extends StatelessWidget {
  const ManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ManageUsersCubit>()..getUsers(),
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
        onRefresh: () => context.read<ManageUsersCubit>().getUsers(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const SliverAppBar(
              title: Text('Manage Users'),
              floating: true,
              snap: true,
            ),
            BlocBuilder<ManageUsersCubit, ManageUsersState>(
              builder: (context, state) {
                if (state.loadStatus == LoadStatus.loading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state.loadStatus == LoadStatus.success) {
                  if (state.users.isEmpty) {
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
                                  0: FixedColumnWidth(200), // ID/Username
                                  1: FixedColumnWidth(150), // Serial Number
                                  2: FixedColumnWidth(100), // Gender
                                  3: FixedColumnWidth(250), // Email
                                  4: FixedColumnWidth(150), // Card UID
                                  5: FixedColumnWidth(150), // Date
                                  6: FixedColumnWidth(150), // Actions
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
                                  ...state.users.map((user) {
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
                                                FontAwesomeIcons.penToSquare,
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
                                                  _onDelete(context, user.id!);
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
                                            .read<ManageUsersCubit>()
                                            .changePage(state.currentPage - 1)
                                        : null,
                                  ),
                                  ...buildPaginationNumbers(
                                    currentPage: state.currentPage,
                                    totalPages: state.totalPages,
                                    onPageSelected: (page) => context
                                        .read<ManageUsersCubit>()
                                        .changePage(page),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.chevron_right),
                                    onPressed: state.currentPage <
                                            state.totalPages
                                        ? () => context
                                            .read<ManageUsersCubit>()
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
                                        .read<ManageUsersCubit>()
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
    return showConfirmDialog(
        context, 'Xóa tài khoản', 'Bạn có chắc chắn muốn xóa tài khoản này?',
        () {
      context.read<ManageUsersCubit>().deleteUser(id);
    });
  }

  void _onEdit(BuildContext context, ManageUserEntity user) {
    GoRouter.of(context).pushNamed(AppRouter.updateUser, extra: {
      'user': user,
      'cubit': context.read<ManageUsersCubit>(),
    });
  }
}
