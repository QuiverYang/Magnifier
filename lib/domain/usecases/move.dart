import 'package:equatable/equatable.dart';
import 'package:magnifier/core/usecases/usecases.dart';
import 'dart:math';
import 'package:magnifier/domain/repos/action_repo.dart';

class Move extends UsecaseWithParams<void, MoveParams> {
  const Move(this._repo);

  final ActionRepo _repo;

  @override
  void call(MoveParams params) => _repo.move(params.from, params.to);
}

class MoveParams extends Equatable {
  const MoveParams({required this.from, required this.to});

  final Point from;
  final Point to;

  @override
  List<Object?> get props => [from, to];
}
