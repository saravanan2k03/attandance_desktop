part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class AttendanceListEvent extends AttendanceEvent {
  final String? fromDate;
  final String? toDate;
  final String? departmentId;
  final String? workShift;

  const AttendanceListEvent({
    this.fromDate,
    this.toDate,
    this.departmentId,
    this.workShift,
  });
}
