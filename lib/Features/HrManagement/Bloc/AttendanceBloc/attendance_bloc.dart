import 'dart:async';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/HrManagement/Models/attendance_list_model.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    on<AttendanceListEvent>(attendancelistevent);
  }

  FutureOr<void> attendancelistevent(
    AttendanceListEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    try {
      emit(AttendanceLoadingState());
      final session = SessionManagerClass();
      var licencekey = await session.getlicence();
      final HrRepository hrRepository = HrRepository();
      AttendanceListModel modelData = await hrRepository.fetchAttendanceList(
        licenseKey: licencekey,
        departmentId: event.departmentId,
        fromDate: event.fromDate,
        toDate: event.toDate,
        workShift: event.workShift,
      );
      emit(AttendanceDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(AttendanceErrorState(error: e.toString()));
    }
  }
}
