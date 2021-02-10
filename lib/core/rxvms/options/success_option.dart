import 'package:foodb/ui/vm/vm.dart';

abstract class SuccessOption {
  const SuccessOption();
  void call(VM vm);

  factory SuccessOption.stopLoading() => StopLoading();
  factory SuccessOption.navigateTo(NavigationEvent event) => NavigateTo(event);
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
