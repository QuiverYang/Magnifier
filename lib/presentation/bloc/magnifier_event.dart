part of 'magnifier_bloc.dart';

abstract class MagnifierEvent extends Equatable {
  const MagnifierEvent();
}

class MoveEvent extends MagnifierEvent {

  const MoveEvent({required this.deltaX, required this.deltaY});
  final double deltaX;

  final double deltaY;

  @override
  List<Object?> get props => [deltaX, deltaY];
}

class ScaleEvent extends MagnifierEvent {

  const ScaleEvent({required this.edgePoint});
  final Point<double> edgePoint;

  @override
  List<Object?> get props => [edgePoint];
}

class OnTapDownEvent extends MagnifierEvent {

  const OnTapDownEvent({required this.touchedPoint});
  final Point<double> touchedPoint;

  @override
  List<Object?> get props => [touchedPoint];
}

class OnPanEndEvent extends MagnifierEvent {
  const OnPanEndEvent();

  @override
  List<Object?> get props => [];
}

class OnTapUpEvent extends MagnifierEvent {
  const OnTapUpEvent();

  @override
  List<Object?> get props => [];
}
