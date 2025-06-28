import 'dart:async';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/HrManagement/Models/hr_dashboard_model.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'hrdashboard_event.dart';
part 'hrdashboard_state.dart';

class HrdashboardBloc extends Bloc<HrdashboardEvent, HrdashboardState> {
  HrdashboardBloc() : super(HrdashboardInitial()) {
    on<HrDashboardDataEvent>(hrdashboardevent);
  }

  FutureOr<void> hrdashboardevent(
    HrDashboardDataEvent event,
    Emitter<HrdashboardState> emit,
  ) async {
    try {
      emit(HrDashboardLoadingState());
      final session = SessionManagerClass();
      var licenceKey = await session.getlicence();
      final HrRepository hrRepository = HrRepository();
      HRDashboardModel modelData = await hrRepository.fetchDashboardData(
        licenceKey,
      );
      emit(HrDashboardDataState(modelData: modelData));
    } on Exception catch (e) {
      emit(HrDashboardErrorState(e: e.toString()));
    }
  }
}
