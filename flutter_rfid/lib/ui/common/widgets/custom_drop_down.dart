import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rfid/ui/common/app_colors.dart';

class CustomDropdownExample<T> extends StatefulWidget {
  const CustomDropdownExample({
    super.key,
    required this.data,
    required this.dataString,
    required this.onChanged,
  });

  final List<T> data;
  final List<String> dataString;
  final Function(T) onChanged;

  @override
  State<CustomDropdownExample<T>> createState() =>
      _CustomDropdownExampleState<T>();
}

class _CustomDropdownExampleState<T> extends State<CustomDropdownExample<T>> {
  late SingleSelectController<T> jobRoleCtrl;

  @override
  void initState() {
    super.initState();
    jobRoleCtrl = SingleSelectController(widget.data.first);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    return CustomDropdown<T>(
      items: widget.data,
      hintText: widget.dataString.first,
      decoration: CustomDropdownDecoration(
        closedBorder: Border.all(color: Colors.grey.shade300),
        closedFillColor: color,
        expandedFillColor: color,
      ),
      hintBuilder: (context, hint, enabled) {
        final index = widget.data.indexOf(jobRoleCtrl.value as T);
        return Text(
          widget.dataString[index],
        );
      },
      onChanged: (value) {
        if (value == null) return;
        widget.onChanged(value);
      },
      controller: jobRoleCtrl,
    );
  }
}
