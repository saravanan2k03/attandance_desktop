part of 'configuration_bloc.dart';

sealed class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  List<Object> get props => [];
}

final class ConfigurationInitial extends ConfigurationState {}

class ConfigurationDataState extends ConfigurationState {
  final ConfigurationListModel modelData;

  const ConfigurationDataState({required this.modelData});
}

class ConfigurationLoadingState extends ConfigurationState {}

class ConfigurationErrorState extends ConfigurationState {
  final String error;

  const ConfigurationErrorState({required this.error});
}

class DesigantionDataState extends ConfigurationState {
  final DesingantionListModel modelData;

  const DesigantionDataState({required this.modelData});
}

class DesigantionLoadingState extends ConfigurationState {}

class DesigantionErrorState extends ConfigurationState {
  final String error;

  const DesigantionErrorState({required this.error});
}

class DepartmentListDataState extends ConfigurationState {
  final DepartmentListModel modelData;

  const DepartmentListDataState({required this.modelData});
}

class DepartmentListLoadingState extends ConfigurationState {}

class DepartmentListErrorState extends ConfigurationState {
  final String error;

  const DepartmentListErrorState({required this.error});
}

class LeaveTypeListDataState extends ConfigurationState {
  final LeaveTypeListModel modelData;

  const LeaveTypeListDataState({required this.modelData});
}

class LeaveTypeLoadingState extends ConfigurationState {}

class LeaveTypeErrorState extends ConfigurationState {
  final String error;

  const LeaveTypeErrorState({required this.error});
}

class HolidayListDataState extends ConfigurationState {
  final HolidayListModel modelData;

  const HolidayListDataState({required this.modelData});
}

class HolidayListLoadingState extends ConfigurationState {}

class HolidayListErrortate extends ConfigurationState {
  final String error;

  const HolidayListErrortate({required this.error});
}
