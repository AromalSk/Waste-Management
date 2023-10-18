import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'full_bin_image_event.dart';
part 'full_bin_image_state.dart';

class FullBinImageBloc extends Bloc<FullBinImageEvent, FullBinImageState> {
  FullBinImageBloc() : super(FullBinImageInitial()) {
    on<FullBinImageEvent>((event, emit) {
      emit(FullBinImageState(mainImage: event.imageFile!));
    });
  }
}
