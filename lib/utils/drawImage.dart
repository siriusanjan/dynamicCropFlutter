import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class DrawImage extends CustomPainter {
  final ui.Image image;

  DrawImage({required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw image
    final imageOffset = Offset(size.width/2, size.height/2); // Adjust the offset as needed
    canvas.drawImage(image, Offset.zero, Paint());

    // Add additional custom drawings here if needed
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // Set to true if you want the painter to repaint on changes
  }
}
