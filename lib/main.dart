import 'dart:io';

import 'package:factor_offset/utils/background_task.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _origin = Offset(0.0, 0.0);
  Offset _previousOffset = Offset(0.0, 0.0);
  double? _width;
  double? _height;
  double? imageFittedWidth;
  double? imageFittedHeight;
  bool widthFitted = false;
  double _extraWidth = 0;
  double _extraHeight = 0;

  void calculateFittedHeightWidth() {
    _height = MediaQuery.of(context).size.height * 0.5;
    _width = MediaQuery.of(context).size.width;
    double imageRealWidth = 487;
    double imageRealHeight = 696;
    if (_height! / _width! > imageRealHeight / imageRealWidth) {
      widthFitted = true;
      imageFittedWidth = _width;
      imageFittedHeight = _width! / (imageRealWidth / imageRealHeight);
    } else {
      widthFitted = false;
      imageFittedHeight = _height;
      imageFittedWidth = _height! / (imageRealHeight / imageRealWidth);
      _extraWidth = _width! - imageFittedWidth!;
    }
    print("widthFitted " + widthFitted.toString());
  }

  @override
  Widget build(BuildContext context) {
    calculateFittedHeightWidth();

    return Scaffold(
        appBar: AppBar(
          title: Text('Zoom Crop Image'),
        ),
        body: Center(
            child: Container(
                color: Colors.green,
                child: ClipRect(
                    child: SizedBox(
                  width: imageFittedWidth,
                  height: imageFittedHeight,
                  child: FittedBox(
                      child: SizedBox(
                          width: imageFittedWidth,
                          height: imageFittedHeight,
                          child: LayoutBuilder(builder:
                              (BuildContext ctx, BoxConstraints constraints) {


                            // if the screen width >= 480 i.e Wide Screen
                            return GestureDetector(
                              onScaleStart: (details) {
                                _previousScale = _scale;
                                _previousOffset = details.focalPoint;
                              },
                              onScaleUpdate: (details) {
                                setState(() {
                                  _scale = _previousScale * details.scale;
                                  _scale = _scale.clamp(1.0,
                                      5.0); // Adjust the min and max zoom levels as per your requirement
                                  if (_scale == _previousScale) {
                                    Offset calculatedOrigin = _origin +
                                        (_origin -
                                            (details.focalPoint -
                                                (_previousOffset - _origin) /
                                                    _previousScale *
                                                    _scale));


                                    if (calculatedOrigin.dx > -(imageFittedWidth! / 2) &&
                                        calculatedOrigin.dx < (imageFittedWidth! / 2) && calculatedOrigin.dy > -(imageFittedHeight! / 2) &&
                                  calculatedOrigin.dy < (imageFittedHeight! / 2)) {
                                      _origin = calculatedOrigin;
                                    }

                                  }
                                  if (_scale == 1) {
                                    _origin = Offset.zero;
                                  }
                                });

                                _previousOffset = details.focalPoint;
                              },
                              onScaleEnd: (details) {
                                // Perform any required cleanup or finalization
                              },
                              child: Stack(
                                children: [
                                  Transform.scale(
                                    scale: _scale,
                                    origin: _origin,
                                    child: Image.asset(
                                        'assets/cat.png'), // Replace with your image asset
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 10.0),
                                      ),
                                      margin: EdgeInsets.all(
                                          20.0), // Adjust the margin as per your requirement
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }))),
                )))));
  }
}
