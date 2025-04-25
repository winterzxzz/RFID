import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/ui/common/widgets/custom_text_field.dart';
import 'package:flutter_rfid/ui/page/manage_devices/manage_devices_cubit.dart';
import 'package:go_router/go_router.dart';

class FormUpdateDevice extends StatefulWidget {
  const FormUpdateDevice({super.key, required this.device});

  final DeviceEntity? device;

  @override
  State<FormUpdateDevice> createState() => _FormUpdateDeviceState();
}

class _FormUpdateDeviceState extends State<FormUpdateDevice> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController deviceNameController;
  late final TextEditingController deviceRoomController;

  @override
  void initState() {
    super.initState();
    deviceNameController = TextEditingController(
        text: widget.device?.deviceName == 'None'
            ? null
            : widget.device?.deviceName);
    deviceRoomController = TextEditingController(
        text: widget.device?.deviceDep == 'None'
            ? null
            : widget.device?.deviceDep);
  }

  @override
  void dispose() {
    deviceNameController.dispose();
    deviceRoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device == null ? 'Add Device' : 'Update Device'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: deviceNameController,
                    label: 'Device Name',
                    hintText: 'Enter your device name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter device name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: deviceRoomController,
                    label: 'Device Room',
                    hintText: 'Enter your device room',
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          if (widget.device == null) {
                            context
                                .read<ManageDevicesCubit>()
                                .addDevice(
                                  deviceName: deviceNameController.text,
                                  deviceDep: deviceRoomController.text,
                                )
                                .then((value) {
                              if (context.mounted) {
                                GoRouter.of(context).pop();
                              }
                            });
                          } else {
                            context
                                .read<ManageDevicesCubit>()
                                .updateDevice(
                                  id: widget.device!.id!,
                                  deviceName: deviceNameController.text,
                                  deviceDep: deviceRoomController.text,
                                  deviceMode: 1,
                                )
                                .then((value) {
                              if (context.mounted) {
                                GoRouter.of(context).pop();
                              }
                            });
                          }
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
      ),
    );
  }
}
