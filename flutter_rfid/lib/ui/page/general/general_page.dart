import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/common/utils/constants.dart';
import 'package:flutter_rfid/ui/common/app_colors.dart';
import 'package:flutter_rfid/ui/page/general/general_cubit.dart';
import 'package:flutter_rfid/ui/page/general/general_state.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_page.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_page.dart';
import 'package:flutter_rfid/ui/page/profile/profile_page.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<GeneralCubit>(),
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
    return BlocBuilder<GeneralCubit, GeneralState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: AppColors.gray3,
            selectedLabelStyle: const TextStyle(fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            showUnselectedLabels: true,
            iconSize: 20,
            currentIndex: state.currentIndex,
            onTap: (index) =>
                context.read<GeneralCubit>().changeCurrentIndex(index),
            items: Constants.homeItems
                .map((item) => BottomNavigationBarItem(
                    icon: FaIcon(item.icon), label: item.title))
                .toList(),
          ),
          body: PageView(
            controller: context.read<GeneralCubit>().pageController,
            onPageChanged: (index) =>
                context.read<GeneralCubit>().changeCurrentIndex(index),
            children: const [
              KeepAlivePage(child: ManageUsersPage()),
              KeepAlivePage(child: UserLogsPage()),
              KeepAlivePage(child: ManageDevicesPage()),
              KeepAlivePage(child: ProfilePage()),
            ],
          ),
        );
      },
    );
  }
}



class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage({
    super.key,
    required this.child,
  });

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}