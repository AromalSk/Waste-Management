import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:waste_management/infrastucture/authentication/login.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      logIn(event.email, event.password);
      emit(LoginState());
    });
  }
}
