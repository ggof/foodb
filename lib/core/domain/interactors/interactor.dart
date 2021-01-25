import '../helpers/disposable.dart';

abstract class Params<T> {
  final T presenter;
  Params(this.presenter);
}

abstract class UseCase<T , P extends Params<T>> {
  Future<void> call(T params);
}

abstract class SetupParams<T> {
  final T presenter;
  SetupParams(this.presenter);
}

abstract class Setup<T, SP extends SetupParams<T>> implements Disposable {
  Future<void> call(SP params);
}

/// blanket interface for default `Presenter`
abstract class IPresenter {
  void onBusy();
  void onSuccess();
  void onError(String error);
}

/// blanket interface for default `SetupPresenter`
abstract class ISetupPresenter<T> {
  void onData(T data);
}