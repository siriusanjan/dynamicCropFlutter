import 'package:flutter_bloc/flutter_bloc.dart';

enum RotateScaleBlocState {
  initialize,
  doneSet,
  scaleRotate,
  normalize,
}

class RotateScaleBloc extends Cubit<RotateScaleBlocState> {
  RotateScaleBloc(super.initialState);

  void setState(RotateScaleBlocState state) {
    emit(RotateScaleBlocState.normalize);
    emit(state);
  }
}
