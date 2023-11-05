import 'package:magnifier/core/usecases/usecases.dart';
import 'package:magnifier/domain/repos/action_repo.dart';

class Zoom extends UsecaseWithParams<void, double> {
  const Zoom(this._repo);

  final ActionRepo _repo;

  @override
  void call(double params) => _repo.zoom(params);
}
