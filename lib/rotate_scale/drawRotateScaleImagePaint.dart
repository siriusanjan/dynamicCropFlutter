import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class ImageCanvasPainter extends CustomPainter {
  ui.Image image;

  ImageCanvasPainter({required this.image});

  @override
  void paint(Canvas canvas, Size size) async {
    // Replace with your image asset
    final double scale = 1.5; // Scale factor
    final double rotation = 45; // Rotation angle in degrees
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Offset topLeft = Offset(
      center.dx - (image.width / 2 * scale),
      center.dy - (image.height / 2 * scale),
    );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.blue);

    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * (3.1415927 / 180));
    canvas.translate(-center.dx, -center.dy);
    canvas.scale(scale, scale);
    canvas.drawImage(
        image, topLeft / scale, Paint()..color = Colors.blueAccent);
  }

  Future<ui.Image> loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
