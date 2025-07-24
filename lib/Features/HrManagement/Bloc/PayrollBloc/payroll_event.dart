part of 'payroll_bloc.dart';

sealed class PayrollEvent extends Equatable {
  const PayrollEvent();

  @override
  List<Object> get props => [];
}

class PayrollListEvent extends PayrollEvent {
  final String? fromDate;
  final String? toDate;
  final String? workShift;
  final int? departmentId;

  const PayrollListEvent({
    this.fromDate,
    this.toDate,
    this.workShift,
    this.departmentId,
  });
}
