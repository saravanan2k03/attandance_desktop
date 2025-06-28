import 'dart:async';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_dashboard.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_detail_reponse.dart';
import 'package:act/Features/EmployeeManagement/Models/simple_employee_list.dart';
import 'package:act/Features/EmployeeManagement/Repository/employee_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeDataEvent>(employeeevent);
    on<EmployeeDashboardEvent>(fetchEmployeeDetailhrData);
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
          .getSimpleEmployeeList(
            licenseKey: licenceKey,
            department: event.department,
            designation: event.designation,
            gender: event.gender,
            workShift: event.workShift,
          )
          .whenComplete(() {
            emit(EmployeeDataState(modelData: employeeData));
          });
    } catch (e) {
      emit(EmployeeError());
    }
  }

  FutureOr<void> fetchEmployeeDetailData(
    EmployeeDetail event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(EmployeeDetailLoadingState());
      final EmployeeRepo employeeRepo = EmployeeRepo();
      await employeeRepo.getEmployeeDetails(event.employeeId).then((value) {
        emit(EmployeeDetailDataState(modelData: value));
      });
    } catch (e) {
      emit(EmployeeDetailErrorState(e: e.toString()));
    }
  }

  FutureOr<void> fetchEmployeeDetailhrData(
    EmployeeDashboardEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(EmployeehrDashboardLoading());
      final EmployeeRepo employeeRepo = EmployeeRepo();
      await employeeRepo
          .fetchEmployeeDashboard(employeeId: event.employeeId.toString())
          .then((value) {
            emit(EmployeehrDashboardDatastate(modelData: value));
          });
    } catch (e) {
      emit(EmployeeDetailErrorState(e: e.toString()));
    }
  }
}
