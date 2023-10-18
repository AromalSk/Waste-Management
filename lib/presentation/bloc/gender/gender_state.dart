// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'gender_bloc.dart';

class GenderState {
  String gender;
  GenderState({
    required this.gender,
  });
}

final class GenderInitial extends GenderState {
  GenderInitial({required super.gender});
}
