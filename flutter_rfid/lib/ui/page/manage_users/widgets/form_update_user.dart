import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/ui/common/widgets/custom_text_field.dart';
import 'package:flutter_rfid/ui/page/manage_users/manage_users_cubit.dart';
import 'package:go_router/go_router.dart';

class FormUpdateUser extends StatefulWidget {
  const FormUpdateUser({super.key, required this.user});

  final ManageUserEntity user;

  @override
  State<FormUpdateUser> createState() => _FormUpdateUserState();
}

class _FormUpdateUserState extends State<FormUpdateUser> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController usernameController;
  late final TextEditingController serialNumberController;
  late String? selectedGender;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    widget.user.deviceDep == 'None' ? null : widget.user.deviceDep;
    selectedGender = widget.user.gender == 'None' ? null : widget.user.gender;
    usernameController = TextEditingController(
        text: widget.user.username == 'None' ? null : widget.user.username);
    serialNumberController = TextEditingController(
        text: widget.user.serialnumber == 'None'
            ? null
            : widget.user.serialnumber);
    emailController = TextEditingController(
        text: widget.user.email == 'None' ? null : widget.user.email);
  }

  @override
  void dispose() {
    usernameController.dispose();
    serialNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: usernameController,
                  label: 'Username',
                  hintText: 'Enter your username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: serialNumberController,
                  label: 'Serial Number',
                  hintText: 'Enter your serial number',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Male', 'Female'].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context
                            .read<ManageUsersCubit>()
                            .updateUser(
                              id: widget.user.id!,
                              username: usernameController.text,
                              serialnumber: serialNumberController.text,
                              gender: selectedGender ?? '',
                              email: emailController.text,
                            )
                            .then((value) {
                          if (context.mounted) {
                            GoRouter.of(context).pop();
                          }
                        });
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
