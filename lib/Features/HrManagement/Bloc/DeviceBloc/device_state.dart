part of 'device_bloc.dart';

sealed class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object> get props => [];
}

final class DeviceInitial extends DeviceState {}

class DeviceDataState extends DeviceState {
  final DeviceListModel modelData;

  const DeviceDataState({required this.modelData});
}

class DeviceLoadingState extends DeviceState {}

class DeviceErrorState extends DeviceState {
  final String error;

  const DeviceErrorState({required this.error});
}
