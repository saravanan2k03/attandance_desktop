part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

class AttendanceDataState extends AttendanceState {
  final AttendanceListModel modelData;

  const AttendanceDataState({required this.modelData});
}

class AttendanceLoadingState extends AttendanceState {}

class AttendanceErrorState extends AttendanceState {
  final String error;

  const AttendanceErrorState({required this.error});
}
