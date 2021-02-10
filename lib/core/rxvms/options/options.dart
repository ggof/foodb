export 'loading_option.dart';
export 'success_option.dart';

import 'package:foodb/ui/vm/vm.dart';

import 'loading_option.dart';
import 'success_option.dart';

class DoNothing implements SuccessOption, LoadingOption  {
  const DoNothing();
  @override
  void call(VM vm) {}
}