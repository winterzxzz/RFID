import 'package:flutter/material.dart';
import 'package:flutter_rfid/ui/common/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isEnabled = true,
    required this.controller,
    this.validator,
  });

  final String label;
  final bool isEnabled;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 50,
          child: TextFormField(
            enabled: widget.isEnabled,
            validator: widget.validator,
            obscureText: widget.label.contains('Password') && !isPasswordVisible,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ) ,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.backgroundDark),
              ),
              hintStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                    color: Colors.grey,
                  ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              suffixIcon: widget.label.contains('Password')
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
