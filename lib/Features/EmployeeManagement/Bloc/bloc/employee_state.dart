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

class EmployeeDetailDataState extends EmployeeState {
  final EmployeeDetailResponse modelData;

  const EmployeeDetailDataState({required this.modelData});
}

class EmployeeDetailLoadingState extends EmployeeState {}

class EmployeeDetailErrorState extends EmployeeState {
  final String e;

  const EmployeeDetailErrorState({required this.e});
}

class EmployeehrDashboardDatastate extends EmployeeState {
  final EmployeeDashboardModel modelData;

  const EmployeehrDashboardDatastate({required this.modelData});
}

class EmployeehrDashboardLoading extends EmployeeState {}

class EmployeehrDashboardError extends EmployeeState {
  final String e;

  const EmployeehrDashboardError({required this.e});
}
