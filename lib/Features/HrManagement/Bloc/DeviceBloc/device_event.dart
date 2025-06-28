part of 'device_bloc.dart';

sealed class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class DeviceListEvent extends DeviceEvent {
  final String licenceKey;

  const DeviceListEvent({required this.licenceKey});
}
