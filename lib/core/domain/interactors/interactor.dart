abstract class Presenter {
  void onBusy();
  void onSuccess();
  void onError(String message);
}

abstract class InteractorParams<P extends Presenter> {
  final P presenter;
  InteractorParams({this.presenter}) : assert(presenter != null);
}

abstract class Interactor<T extends InteractorParams<P>, P extends Presenter> {
  Future<void> call(T params);
}
