// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

class SignupEvent {
  String email;
  String password;
  SignupEvent({
    required this.email,
    required this.password,
  });
}
