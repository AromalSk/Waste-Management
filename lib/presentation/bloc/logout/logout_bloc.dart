import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:waste_management/infrastucture/authentication/google_signin.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      await logout();
      emit(LogoutState());
    });
  }
}
