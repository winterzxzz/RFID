import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_cubit.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_state.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('User Logs'),
            floating: true,
            snap: true,
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
                    child: Center(child: Text('No users found')),
                  );
                } else {
                  return SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    sliver: SliverList.separated(
                      itemCount: state.users.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              '${user.id} | ${user.username}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Serial Number: ${user.serialnumber ?? 'None'}'),
                                Text('Card UID: ${user.cardUid ?? 'None'}'),
                                Text('Department: ${user.deviceDep ?? 'None'}'),
                                Text(
                                    'Date: ${DateFormat('dd/MM/yyyy').format(user.checkindate ?? DateTime.now())}'),
                                Text('Check In: ${user.timein ?? 'None'}'),
                                Text('Check Out: ${user.timeout ?? 'None'}'),
                              ],
                            ),
                          ),
                        );
                      },
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
}
