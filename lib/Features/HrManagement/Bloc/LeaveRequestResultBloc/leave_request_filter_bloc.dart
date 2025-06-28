import 'dart:async';

import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/HrManagement/Models/leave_request_filter_model.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'leave_request_filter_event.dart';
part 'leave_request_filter_state.dart';

class LeaveRequestFilterBloc
    extends Bloc<LeaveRequestFilterEvent, LeaveRequestFilterState> {
  LeaveRequestFilterBloc() : super(LeaveRequestFilterInitial()) {
    on<LeaveRequestFilterDataEvent>(leaveRequestFilterevent);
  }

  FutureOr<void> leaveRequestFilterevent(
    LeaveRequestFilterDataEvent event,
    Emitter<LeaveRequestFilterState> emit,
  ) async {
    try {
      emit(LeaveRequestLoadingState());
      final session = SessionManagerClass();
      var licenceKey = await session.getlicence();
      final HrRepository hrRepository = HrRepository();
      LeaveRequestFilterModel modelData = await hrRepository
          .filterLeaveRequests(
            licenseKey: licenceKey,
            employeeId: event.employeeId,
            endDate: event.endDate,
            startDate: event.startDate,
            status: event.status,
          );
      emit(LeaveRequestFilterData(modelData: modelData));
    } on Exception catch (e) {
      emit(LeaveRequestErrorData(error: e.toString()));
    }
  }
}
