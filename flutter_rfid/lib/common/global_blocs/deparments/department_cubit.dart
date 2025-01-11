
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rfid/common/global_blocs/deparments/department_state.dart';
import 'package:flutter_rfid/data/models/response/manage_user_response.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentState.initial());

  void changeDepartments({required List<Department> departments}) {
    emit(state.copyWith(departments: departments));
  }
}
