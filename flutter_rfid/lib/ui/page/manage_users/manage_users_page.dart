import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/ui/common/widgets/confirm_dia_log.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_cubit.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';

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
      body: CustomScrollView(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DataTable2(
                        columns: const [
                          DataColumn2(
                            label: Text('ID/Username'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Serial Number'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Gender'),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Text('Card UID'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Department'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Date'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Actions'),
                            size: ColumnSize.S,
                          ),
                        ],
                        rows: state.users.map((user) {
                          return DataRow(
                            color: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                return user.addCard == 0
                                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                                    : null;
                              },
                            ),
                            cells: [
                              DataCell(Text('${user.id} | ${user.username}')),
                              DataCell(Text(user.serialnumber ?? 'None')),
                              DataCell(Text(user.gender ?? 'None')),
                              DataCell(Text(user.cardUid ?? 'None')),
                              DataCell(Text(user.deviceDep ?? 'None')),
                              DataCell(Text(DateFormat('dd/MM/yyyy')
                                  .format(user.userDate ?? DateTime.now()))),
                              DataCell(Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const FaIcon(
                                      FontAwesomeIcons.penToSquare,
                                      size: 16,
                                    ),
                                    onPressed: () => _onEdit(context, user),
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
                        }).toList(),
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
    );
  }

  void _onDelete(BuildContext context, int id) {
    return showConfirmDialog(context, 'Delete User',
        'Are you sure you want to delete this user?', () {
      context.read<ManageUsersCubit>().deleteUser(id);
    });
  }

  void _onEdit(BuildContext context, ManageUserEntity user) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final formKey = GlobalKey<FormState>();
        final usernameController = TextEditingController(
            text: user.username == 'None' ? null : user.username);
        final serialNumberController = TextEditingController(
            text: user.serialnumber == 'None' ? null : user.serialnumber);
        String? selectedGender = user.gender == 'None' ? null : user.gender;
        final departmentController = TextEditingController(
            text: user.deviceDep == 'None' ? null : user.deviceDep);

        return AlertDialog(
          title: const Text('Edit User'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: serialNumberController,
                    decoration: const InputDecoration(labelText: 'Serial Number'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: const InputDecoration(labelText: 'Gender'),
                    items: ['Male', 'Female'].map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedGender = newValue;
                      }
                    },
                  ),
                  TextFormField(
                    controller: departmentController,
                    decoration: const InputDecoration(labelText: 'Department'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  context.read<ManageUsersCubit>().updateUser(
                        id: user.id!,
                        username: usernameController.text,
                        serialnumber: serialNumberController.text,
                        gender: selectedGender!,
                        email: '',
                        deviceDep: departmentController.text,
                      ).then((value) {
                        if(dialogContext.mounted) {
                          GoRouter.of(dialogContext).pop();
                        }
                      });
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
