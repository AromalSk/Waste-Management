import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:waste_management/infrastucture/authentication/signup.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {
      signUp(event.email, event.password);
      emit(SignupState());
    });
  }
}
