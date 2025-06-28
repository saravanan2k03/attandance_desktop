import 'dart:async';

import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/HrManagement/Models/payroll_list_model.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payroll_event.dart';
part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  PayrollBloc() : super(PayrollInitial()) {
    on<PayrollListEvent>(attendancelistevent);
  }

  FutureOr<void> attendancelistevent(
    PayrollListEvent event,
    Emitter<PayrollState> emit,
  ) async {
    try {
      emit(PayrollLoadingState());
      final session = SessionManagerClass();
      var licencekey = await session.getlicence();
      final HrRepository hrRepository = HrRepository();
      PayrollListModel modelData = await hrRepository.listPayrollRecords(
        licenseKey: licencekey,
        departmentId: event.departmentId,
        fromDate: event.fromDate,
        toDate: event.toDate,
        workShift: event.workShift,
      );
      emit(PayrollDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(PayrollErrorState(error: e.toString()));
    }
  }
}
