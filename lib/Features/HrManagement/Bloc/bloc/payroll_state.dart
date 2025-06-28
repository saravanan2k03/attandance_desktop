part of 'payroll_bloc.dart';

sealed class PayrollState extends Equatable {
  const PayrollState();

  @override
  List<Object> get props => [];
}

final class PayrollInitial extends PayrollState {}

class PayrollDataState extends PayrollState {
  final PayrollListModel modelData;

  const PayrollDataState({required this.modelData});
}

class PayrollLoadingState extends PayrollState {}

class PayrollErrorState extends PayrollState {
  final String error;

  const PayrollErrorState({required this.error});
}
