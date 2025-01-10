import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/common/router/route_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_rfid/app.dart';
import 'package:flutter_rfid/data/models/enums/load_status.dart';
import 'package:flutter_rfid/ui/common/app_colors.dart';
import 'package:flutter_rfid/ui/common/widgets/show_toast.dart';
import 'package:flutter_rfid/ui/page/login/login_cubit.dart';
import 'package:flutter_rfid/ui/page/login/login_navigator.dart';
import 'package:flutter_rfid/ui/page/login/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<LoginCubit>(),
      child: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({
    super.key,
  });

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final navigator = LoginNavigator(context: context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.loadStatus == LoadStatus.loading) {
          navigator.showLoadingOverlay();
        } else {
          navigator.hideLoadingOverlay();
        if (state.loadStatus == LoadStatus.failure) {
          showToast(title: state.errorMessage, type: ToastificationType.error);
        }else if (state.loadStatus == LoadStatus.success) {
          GoRouter.of(context).goNamed(AppRouter.general);
            showToast(title: 'Welcome back!', type: ToastificationType.success);
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('LOGIN', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 32),
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(
                            color: AppColors.textGray,
                            fontWeight: FontWeight.w400,
                          ),
                          labelStyle: const TextStyle(color: AppColors.textGray),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.primary
                                  : AppColors.textWhite,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(
                            color: AppColors.textGray,
                            fontWeight: FontWeight.w400,
                          ),
                          labelStyle: const TextStyle(color: AppColors.textGray),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.primary
                                  : AppColors.textWhite,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<LoginCubit>().login(
                                  emailController.text,
                                  passwordController.text,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Login',
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.facebook,
                    color: AppColors.textWhite,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Facebook',
                    style: TextStyle(color: AppColors.textWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.google,
                    color: AppColors.textWhite,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Google',
                    style: TextStyle(color: AppColors.textWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
