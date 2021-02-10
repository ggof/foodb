import 'package:foodb/ui/vm/vm.dart';

abstract class LoadingOption {
  const LoadingOption();
  void call(VM vm);
}

class SetLoading extends LoadingOption {
  const SetLoading();
  @override
  void call(VM vm) => vm.setBusy();
}
