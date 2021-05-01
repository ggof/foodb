import 'package:foodb/ui/vm/vm.dart';

abstract class Option {
  const Option();
  void call(VM vm);

  const factory Option.startLoading() = _StartLoading;

  const factory Option.stopLoading() = _StopLoading;

  const factory Option.navigateTo(NavigationEvent event) = _NavigateTo;

  const factory Option.doNothing() = _DoNothing;
}

class _StartLoading extends Option {
  const _StartLoading();

  @override
  void call(VM vm) => vm.setBusy();
}

class _StopLoading extends Option {
  const _StopLoading();

  @override
  void call(VM vm) => vm.setIdle();
}

class _NavigateTo extends Option {
  final NavigationEvent event;

  const _NavigateTo(this.event);

  @override
  void call(VM vm) => vm.navigate(event);
}

class _DoNothing extends Option {
  const _DoNothing();

  @override
  void call(VM vm) {}
}
