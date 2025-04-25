import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/common/global_blocs/user/user_cubit.dart';
import 'package:flutter_rfid/common/router/route_config.dart';
import 'package:flutter_rfid/ui/common/widgets/confirm_dia_log.dart';
import 'package:flutter_rfid/ui/common/widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: context.read<UserCubit>().state.user?.name,
    );
    emailController = TextEditingController(
      text: context.read<UserCubit>().state.user?.email,
    );
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomTextField(
              isEnabled: false,
              label: 'Name',
              hintText: 'Enter your name',
              controller: nameController),
          const SizedBox(height: 16),
          CustomTextField(
            isEnabled: false,
            label: 'Email',
            hintText: 'Enter your email',
            controller: emailController,
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                showConfirmDialog(
                  context,
                  'Logout',
                  'Are you sure you want to logout?',
                  () {
                    injector<UserCubit>().clearUser().then((_) {
                      if (context.mounted) {
                        GoRouter.of(context).go(AppRouter.login);
                      }
                    });
                  },
                );
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
