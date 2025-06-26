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
