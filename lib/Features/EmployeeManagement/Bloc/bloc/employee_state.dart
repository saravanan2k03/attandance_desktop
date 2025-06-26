part of 'employee_bloc.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

final class EmployeeInitial extends EmployeeState {}

class EmployeeDataState extends EmployeeState {
  final List<SimpleEmployeeModel> modelData;

  const EmployeeDataState({required this.modelData});
}

class EmployeeLoadingState extends EmployeeState {}

class EmployeeError extends EmployeeState {}
