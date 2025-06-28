part of 'hrdashboard_bloc.dart';

sealed class HrdashboardEvent extends Equatable {
  const HrdashboardEvent();

  @override
  List<Object> get props => [];
}

class HrDashboardDataEvent extends HrdashboardEvent {}
