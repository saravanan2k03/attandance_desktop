part of 'hrdashboard_bloc.dart';

sealed class HrdashboardState extends Equatable {
  const HrdashboardState();

  @override
  List<Object> get props => [];
}

final class HrdashboardInitial extends HrdashboardState {}

class HrDashboardDataState extends HrdashboardState {
  final HRDashboardModel modelData;

  const HrDashboardDataState({required this.modelData});
}

class HrDashboardLoadingState extends HrdashboardState {}

class HrDashboardErrorState extends HrdashboardState {
  final String e;

  const HrDashboardErrorState({required this.e});
}
