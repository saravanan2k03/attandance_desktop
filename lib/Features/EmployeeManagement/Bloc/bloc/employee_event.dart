part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class EmployeeDataEvent extends EmployeeEvent {
  final String? gender;
  final String? department;
  final String? designation;
  final String? workShift;

  const EmployeeDataEvent({
    this.gender,
    this.department,
    this.designation,
    this.workShift,
  });
}

class EmployeeDetail extends EmployeeEvent {
  final int employeeId;

  const EmployeeDetail({required this.employeeId});
}

class EmployeeDashboardEvent extends EmployeeDataEvent {
  final int employeeId;

  const EmployeeDashboardEvent(this.employeeId);
}
