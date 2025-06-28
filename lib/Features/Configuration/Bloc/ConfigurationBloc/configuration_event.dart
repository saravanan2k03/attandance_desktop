part of 'configuration_bloc.dart';

sealed class ConfigurationEvent extends Equatable {
  const ConfigurationEvent();

  @override
  List<Object> get props => [];
}

class ConfigurationSettingEventFetch extends ConfigurationEvent {
  final String? workshift;

  const ConfigurationSettingEventFetch({this.workshift});
}

class ListDesignation extends ConfigurationEvent {}

class ListDepartment extends ConfigurationEvent {}

class Listleavetype extends ConfigurationEvent {}

class ListHoliday extends ConfigurationEvent {}
