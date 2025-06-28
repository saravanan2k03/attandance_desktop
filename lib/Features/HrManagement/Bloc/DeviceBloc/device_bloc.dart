import 'dart:async';

import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/HrManagement/Models/device_list_model.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc() : super(DeviceInitial()) {
    on<DeviceListEvent>(attendancelistevent);
  }

  FutureOr<void> attendancelistevent(
    DeviceListEvent event,
    Emitter<DeviceState> emit,
  ) async {
    try {
      emit(DeviceLoadingState());
      final session = SessionManagerClass();
      var licencekey = await session.getlicence();
      final HrRepository hrRepository = HrRepository();
      DeviceListModel modelData = await hrRepository.listDevices(licencekey);
      emit(DeviceDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(DeviceErrorState(error: e.toString()));
    }
  }
}
