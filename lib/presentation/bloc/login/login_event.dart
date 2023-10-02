// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginEvent {
  String email;
  String password;
  LoginEvent({
    required this.email,
    required this.password,
  });
}
