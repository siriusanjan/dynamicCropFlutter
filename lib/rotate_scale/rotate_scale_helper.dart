import 'dart:ui' as ui;

import 'package:factor_offset/rotate_scale/RotateScaleBloc.dart';
import 'package:factor_offset/rotate_scale/drawRotateScaleImagePaint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RotateScaleBlocHelper {
  ui.Image? image;
  ui.Image? rotateScaleImage;
  String assertPath = "assets/cat.png";

  RotateScaleBlocHelper(BuildContext context) {
    getUiImage(context);
  }

  Future<void> getUiImage(BuildContext context) async {
    final bytes = await rootBundle.load(assertPath);
    final codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    image = frame.image;
    BlocProvider.of<RotateScaleBloc>(context)
        .setState(RotateScaleBlocState.doneSet);
  }

  void setRotateScaleImage(BuildContext context) {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    CustomPainter customPaint = ImageCanvasPainter(image: image!);
    customPaint.paint(
        canvas, Size(image!.width.toDouble(), image!.height.toDouble()));
    recorder
        .endRecording()
        .toImage(image!.width.floor(), image!.height.floor())
        .then((value) {
      rotateScaleImage = value;
      BlocProvider.of<RotateScaleBloc>(context)
          .setState(RotateScaleBlocState.scaleRotate);
    });
  }

  void setInitialImage(BuildContext context) {
    BlocProvider.of<RotateScaleBloc>(context)
        .setState(RotateScaleBlocState.doneSet);
  }
}
