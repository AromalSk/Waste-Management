import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_show_event.dart';
part 'image_show_state.dart';

class ImageShowBloc extends Bloc<ImageShowEvent, ImageShowState> {
  ImageShowBloc() : super(ImageShowInitial()) {
    on<ImageShowEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
