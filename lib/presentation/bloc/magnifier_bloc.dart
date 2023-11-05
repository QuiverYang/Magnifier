import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magnifier/domain/entities/circle/circle.dart';

part 'magnifier_event.dart';

part 'magnifier_state.dart';

class MagnifierBloc extends Bloc<MagnifierEvent, MagnifierState> {
  MagnifierBloc({
    Point<double> initialCenter = const Point<double>(200, 200),
    double initialRadius = 100,
  }) : super(
          MagnifierModified(
            newCenter: initialCenter,
            newRadius: initialRadius,
          ),
        ) {
    on<MoveEvent>(_moveHandler);
    on<ScaleEvent>(_scaleHandler);
    on<OnTapDownEvent>(_onTapDownHandler);
    on<OnPanEndEvent>(_onPanCancelHandler);
    on<OnTapUpEvent>(_onTapUpHandler);
  }

  final _kBlurEdgeArea = 20;

  bool _isOnEdge = false;

  bool get isOnEdge => _isOnEdge;

  void _moveHandler(
    MoveEvent event,
    Emitter<MagnifierState> emit,
  ) {
    final newCenter = Point(
      state.circle.center.x + event.deltaX,
      state.circle.center.y + event.deltaY,
    );

    emit(
      MagnifierModified(
        newCenter: newCenter,
        newRadius: state.circle.radius,
      ),
    );
  }

  void _scaleHandler(
    ScaleEvent event,
    Emitter<MagnifierState> emit,
  ) {
    final newRadius = _distance(state.circle.center, event.edgePoint);
    emit(
      MagnifierModified(
        newCenter: state.circle.center,
        newRadius: newRadius,
      ),
    );
  }

  void _onTapDownHandler(
    OnTapDownEvent event,
    Emitter<MagnifierState> emit,
  ) {
    final center = state.circle.center;
    final distance = _distance(event.touchedPoint, center);
    final radius = state.circle.radius;

    if (distance > radius - _kBlurEdgeArea &&
        distance < radius + _kBlurEdgeArea) {
      _isOnEdge = true;
    }
  }

  void _onPanCancelHandler(
    OnPanEndEvent event,
    Emitter<MagnifierState> emit,
  ) {
    _isOnEdge = false;
  }

  void _onTapUpHandler(
    OnTapUpEvent event,
    Emitter<MagnifierState> emit,
  ) {
    _isOnEdge = false;
  }

  double _distance(Point a, Point b) {
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
  }
}
