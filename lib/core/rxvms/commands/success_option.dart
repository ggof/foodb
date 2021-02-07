import 'package:foodb/ui/vm/vm.dart';

abstract class SuccessOption {
  const SuccessOption();
  void call(VM vm);
}

class DoNothing extends SuccessOption {
  const DoNothing();
  @override
  void call(VM vm) {}
}

class StopLoading extends SuccessOption {
  const StopLoading();
  @override
  void call(VM vm) => vm.setIdle();
}

class NavigateTo extends SuccessOption {
  final NavigationEvent event;
  const NavigateTo(this.event);

  @override
  void call(VM vm) => vm.navigate(event);
}