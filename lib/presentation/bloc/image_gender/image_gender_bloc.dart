import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_gender_event.dart';
part 'image_gender_state.dart';

class ImageGenderBloc extends Bloc<ImageGenderEvent, ImageGenderState> {
  ImageGenderBloc() : super(ImageGenderInitial(genderUser: '')) {
    on<ImageGenderEvent>((event, emit) {
      emit(ImageGenderState(genderUser: event.gender));
    });
  }
}
