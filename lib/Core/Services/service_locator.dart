import 'package:act/Features/Auth/Bloc/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<LoginBloc>(() => LoginBloc());
}
