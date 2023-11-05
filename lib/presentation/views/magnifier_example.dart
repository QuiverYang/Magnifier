import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnifier/presentation/bloc/magnifier_bloc.dart';

class MagnifierExample extends StatelessWidget {
  const MagnifierExample({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MagnifierBloc>();
    return BlocConsumer<MagnifierBloc, MagnifierState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: Stack(
            children: [
              const Positioned(left: 100, top: 100, child: Text('LEFT')),
              RepaintBoundary(
                child: Stack(
                  children: <Widget>[
                    const Positioned(left: 500, top: 0, child: Text('HELoL')),
                    Positioned(
                      left: state.circle.left,
                      top: state.circle.top,
                      child: RawMagnifier(
                        decoration: MagnifierDecoration(
                          shape: const CircleBorder(),
                          shadows: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 3,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        size: Size(
                          state.circle.radius * 2,
                          state.circle.radius * 2,
                        ),
                        magnificationScale: 2,
                        child: CustomPaint(
                          size: Size(state.circle.radius, state.circle.radius),
                          painter: DonutPainter(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      // whiteboard
                      // onPanUpdate: (details) {
                      //   bloc.add(
                      //     MoveEvent(
                      //       deltaX: details.delta.dx,
                      //       deltaY: details.delta.dy,
                      //     ),
                      //   );
                      // },
                      onPanUpdate: (details) {
                        if (bloc.isOnEdge) {
                          final edgePoint = Point<double>(
                            details.localPosition.dx,
                            details.localPosition.dy,
                          );
                          bloc.add(ScaleEvent(edgePoint: edgePoint));
                        } else {
                          bloc.add(
                            MoveEvent(
                              deltaX: details.delta.dx,
                              deltaY: details.delta.dy,
                            ),
                          );
                        }
                      },
                      onPanEnd: (detail) {
                        bloc.add(const OnPanEndEvent());
                      },
                      onTapUp: (detail) {
                        bloc.add(const OnTapUpEvent());
                      },
                      onTapDown: (details) {
                        bloc.add(
                          OnTapDownEvent(
                            touchedPoint: Point(
                              details.localPosition.dx,
                              details.localPosition.dy,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DonutPainter extends CustomPainter {
  static const _kStrokeWith = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    final outerRadius = size.width / 2 - _kStrokeWith;
    final innerRadius = outerRadius - 8;

    final center = Offset(size.width / 2, size.height / 2);

    final outerPaint = Paint()
      ..color = Colors.grey // 外圓顏色
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3 * _kStrokeWith; // 外圓寬度

    final innerPaint = Paint()
      ..color = Colors.grey // 內圓顏色
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kStrokeWith; // 內圓寬度

    final outerPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: outerRadius));
    final innerPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: innerRadius));

    canvas
      ..drawPath(outerPath, outerPaint)
      ..drawPath(innerPath, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
