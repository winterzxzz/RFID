import 'package:equatable/equatable.dart';
import 'package:flutter_rfid/data/models/response/manage_user_response.dart';

class DepartmentState extends Equatable {
  final List<Department> departments;

  const DepartmentState({required this.departments});

  // init state
  factory DepartmentState.initial() => const DepartmentState(departments: []);

  // copyWith
  DepartmentState copyWith({List<Department>? departments}) =>
      DepartmentState(departments: departments ?? this.departments);

  @override
  List<Object?> get props => [departments];
}
