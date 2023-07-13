import 'package:factor_offset/rotate_scale/RotateScaleBloc.dart';
import 'package:factor_offset/rotate_scale/rotate_scale_helper.dart';
import 'package:factor_offset/utils/drawImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawRotateScaleImagePaint.dart';

class RotateScale extends StatefulWidget {
  const RotateScale({super.key});

  @override
  State<StatefulWidget> createState() => _RotateScale();
}

class _RotateScale extends State<RotateScale> {
  RotateScaleBlocHelper? _rotateScaleBlocHelper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
            create: (BuildContext context) =>
                RotateScaleBloc(RotateScaleBlocState.initialize),
            child: BlocBuilder<RotateScaleBloc, RotateScaleBlocState>(
                buildWhen: (previousState, state) {
              return true;
              // return true/false to determine whether or not
              // to rebuild the widget with state
            }, builder: (context, state) {
              _rotateScaleBlocHelper ??= RotateScaleBlocHelper(context);

              print("state " + state.toString());
              // return widget here based on BlocA's state
              return state == RotateScaleBlocState.doneSet ||
                      state == RotateScaleBlocState.scaleRotate
                  ? Center(
                      child: Column(children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width,
                          child: FittedBox(
                              child: SizedBox(
                                  height: 600,
                                  width: 600,
                                  child: LayoutBuilder(builder:
                                      (BuildContext context,
                                          BoxConstraints constraints) {
                                    return Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: CustomPaint(
                                          painter: state ==
                                                  RotateScaleBlocState.doneSet
                                              ? DrawImage(
                                                  image: _rotateScaleBlocHelper!
                                                      .image!,
                                                )
                                              : DrawImage(
                                                  image: _rotateScaleBlocHelper!
                                                      .rotateScaleImage!,
                                                ),
                                          size: Size(487, 696),
                                        ),
                                      ),
                                    );
                                  })))),
                      ElevatedButton(
                          onPressed: () {
                            _rotateScaleBlocHelper!
                                .setRotateScaleImage(context);
                          },
                          child: Text("change")),
                      ElevatedButton(
                          onPressed: () {
                            _rotateScaleBlocHelper!.setInitialImage(context);
                          },
                          child: Text("initital")),
                    ]))
                  : Container();
            })));
  }
}
