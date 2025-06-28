part of 'leave_request_filter_bloc.dart';

sealed class LeaveRequestFilterState extends Equatable {
  const LeaveRequestFilterState();

  @override
  List<Object> get props => [];
}

final class LeaveRequestFilterInitial extends LeaveRequestFilterState {}

class LeaveRequestFilterData extends LeaveRequestFilterState {
  final LeaveRequestFilterModel modelData;

  const LeaveRequestFilterData({required this.modelData});
}

class LeaveRequestErrorData extends LeaveRequestFilterState {
  final String error;

  const LeaveRequestErrorData({required this.error});
}

class LeaveRequestLoadingState extends LeaveRequestFilterState {}
