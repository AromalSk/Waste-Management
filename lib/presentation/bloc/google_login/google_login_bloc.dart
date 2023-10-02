import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:waste_management/infrastucture/authentication/google_signin.dart';

part 'google_login_event.dart';
part 'google_login_state.dart';

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  GoogleLoginBloc() : super(GoogleLoginInitial()) {
    on<GoogleLoginEvent>((event, emit) {
      googleLogin();
      emit(GoogleLoginState());
    });
  }
}
