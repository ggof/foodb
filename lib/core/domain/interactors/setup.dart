import 'package:foodb/core/domain/entities/model.dart';
import 'package:foodb/core/domain/helpers/disposable.dart';

abstract class SetupPresenter<M extends Model> {
  void onData(M model);
}

abstract class SetupParams<P extends SetupPresenter<M>, M extends Model> {
  final P presenter;
  SetupParams({this.presenter}) : assert(presenter != null);
}

abstract class Setup<SP extends SetupParams<P, M>, P extends SetupPresenter<M>,
    M extends Model> implements Disposable {
  Future<void> call(SP params);
}
