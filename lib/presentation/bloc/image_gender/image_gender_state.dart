// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_gender_bloc.dart';

class ImageGenderState {
  String genderUser;
  ImageGenderState({
    required this.genderUser,
  });
}

final class ImageGenderInitial extends ImageGenderState {
  ImageGenderInitial({required super.genderUser});
}
