import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/common/global_blocs/deparments/department_cubit.dart';
import 'package:flutter_rfid/common/global_blocs/deparments/department_state.dart';
import 'package:flutter_rfid/ui/page/user_logs/user_logs_cubit.dart';
import 'package:intl/intl.dart';

class FormFilter extends StatefulWidget {
  const FormFilter({super.key});

  @override
  State<FormFilter> createState() => _FormFilterState();
}

class _FormFilterState extends State<FormFilter> {
  DateTimeRange? _dateRange;
  String? _selectedDepartment;

  @override
  void initState() {
    super.initState();
    _dateRange = context.read<UserLogsCubit>().state.dateRange;
    _selectedDepartment = context.read<UserLogsCubit>().state.deviceDep;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.65,
      maxChildSize: 0.8,
      expand: false,
      builder: (_, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Filter Logs',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  color: Colors.greenAccent[100],
                  child: ListTile(
                    title: Text(_dateRange == null
                        ? 'Select Date Range'
                        : '${DateFormat('dd/MM/yyyy').format(_dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_dateRange!.end)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTimeRange? result = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        currentDate: DateTime.now(),
                        builder: (context, child) => Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: Colors.green,
                                ),
                          ),
                          child: child!,
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          _dateRange = result;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                BlocBuilder<DepartmentCubit, DepartmentState>(
                  builder: (context, state) {
                    return DropdownButtonFormField<String>(
                      value: _selectedDepartment,
                      decoration: const InputDecoration(
                        labelText: 'Department',
                        border: OutlineInputBorder(),
                      ),
                      items: state.departments.map((department) {
                        return DropdownMenuItem<String>(
                          value: department.deviceDep,
                          child: Text(department.deviceDep ?? ''),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _selectedDepartment = newValue;
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.filter_alt),
                        label: const Text('Apply Filter'),
                        onPressed: () {
                          context.read<UserLogsCubit>().applyFilters(
                                dateRange: _dateRange,
                                department: _selectedDepartment,
                              );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.filter_alt),
                        label: const Text('Clear Filter'),
                        onPressed: () {
                          setState(() {
                            _dateRange = null;
                            _selectedDepartment = null;
                          });
                          context.read<UserLogsCubit>().clearFilters();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
