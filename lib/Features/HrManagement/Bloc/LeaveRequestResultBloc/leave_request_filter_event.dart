part of 'leave_request_filter_bloc.dart';

sealed class LeaveRequestFilterEvent extends Equatable {
  const LeaveRequestFilterEvent();

  @override
  List<Object> get props => [];
}

class LeaveRequestFilterDataEvent extends LeaveRequestFilterEvent {
  final int? employeeId;
  final String? status;
  final String? startDate;
  final String? endDate;

  const LeaveRequestFilterDataEvent({
    this.employeeId,
    this.status,
    this.startDate,
    this.endDate,
  });
}
