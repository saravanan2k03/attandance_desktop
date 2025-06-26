import 'dart:async';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/EmployeeManagement/Models/simple_employee_list.dart';
import 'package:act/Features/EmployeeManagement/Repository/employee_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeDataEvent>(employeeevent);
  }

  FutureOr<void> employeeevent(
    EmployeeDataEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    final EmployeeRepo employeeRepo = EmployeeRepo();
    emit(EmployeeLoadingState());

    try {
      final session = SessionManagerClass();
      var licenceKey = await session.getlicence();
      List<SimpleEmployeeModel> employeeData = [];
      employeeData = await employeeRepo
          .getSimpleEmployeeList(licenseKey: licenceKey)
          .whenComplete(() {
            emit(EmployeeDataState(modelData: employeeData));
          });
    } catch (e) {
      emit(EmployeeError());
    }
  }
}
