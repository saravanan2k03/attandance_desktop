import 'dart:async';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/Configuration/Models/configuration_list_model.dart';
import 'package:act/Features/Configuration/Models/designation_list_model.dart';
import 'package:act/Features/Configuration/Models/holiday_list_model.dart';
import 'package:act/Features/Configuration/Models/leave_type_list_model.dart';
import 'package:act/Features/Configuration/Models/list_department_model.dart';
import 'package:act/Features/Configuration/Repository/configuration_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc() : super(ConfigurationInitial()) {
    on<ConfigurationSettingEventFetch>(fetchConfigurationSettingvent);
    on<ListDesignation>(fetchDesignationSettingvent);
    on<ListDepartment>(fetchDepartmentSettingvent);
    on<Listleavetype>(fetchLeaveTypevent);
    on<ListHoliday>(fetchHolidayevent);
  }

  FutureOr<void> fetchConfigurationSettingvent(
    ConfigurationSettingEventFetch event,
    Emitter<ConfigurationState> emit,
  ) async {
    try {
      emit(ConfigurationLoadingState());
      final session = SessionManagerClass();
      var licenceKey = await session.getlicence();
      final ConfigurationRepo configurationRepo = ConfigurationRepo();
      ConfigurationListModel modelData = await configurationRepo
          .listConfiguration(licenceKey, workshift: event.workshift);
      emit(ConfigurationDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(ConfigurationErrorState(error: e.toString()));
    }
  }

  FutureOr<void> fetchDesignationSettingvent(
    ListDesignation event,
    Emitter<ConfigurationState> emit,
  ) async {
    try {
      emit(DesigantionLoadingState());
      final session = SessionManagerClass();
      var licenceKey = await session.getlicence();
      final ConfigurationRepo configurationRepo = ConfigurationRepo();
      DesingantionListModel modelData = await configurationRepo
          .listDesignationApi(licenceKey);
      emit(DesigantionDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(DesigantionErrorState(error: e.toString()));
    }
  }

  FutureOr<void> fetchDepartmentSettingvent(
    ListDepartment event,
    Emitter<ConfigurationState> emit,
  ) async {
    try {
      emit(DepartmentListLoadingState());
      final session = SessionManagerClass();
      var licenceKey = await session.getlicence();
      final ConfigurationRepo configurationRepo = ConfigurationRepo();
      DepartmentListModel modelData = await configurationRepo.listDeparmentApi(
        licenceKey,
      );
      emit(DepartmentListDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(DepartmentListErrorState(error: e.toString()));
    }
  }

  FutureOr<void> fetchLeaveTypevent(
    Listleavetype event,
    Emitter<ConfigurationState> emit,
  ) async {
    try {
      emit(LeaveTypeLoadingState());
      final session = SessionManagerClass();
      var licenceKey = await session.getlicence();
      final ConfigurationRepo configurationRepo = ConfigurationRepo();
      LeaveTypeListModel modelData = await configurationRepo.listLeaveTypes(
        licenceKey,
      );
      emit(LeaveTypeListDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(LeaveTypeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> fetchHolidayevent(
    ListHoliday event,
    Emitter<ConfigurationState> emit,
  ) async {
    try {
      emit(HolidayListLoadingState());
      final session = SessionManagerClass();
      var licenceKey = await session.getlicence();
      final ConfigurationRepo configurationRepo = ConfigurationRepo();
      HolidayListModel modelData = await configurationRepo.listHolidays(
        licenceKey,
      );
      emit(HolidayListDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(HolidayListErrortate(error: e.toString()));
    }
  }
}
