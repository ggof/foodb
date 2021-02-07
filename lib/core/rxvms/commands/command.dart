import 'dart:async';

import 'package:foodb/core/rxvms/commands/success_option.dart';
import 'package:meta/meta.dart';


abstract class CommandPresenter {
  void onLoading();
  void onSuccess(SuccessOption option);
  void onError(String error);
}

/// `Command` is an action to change the state.
/// A `Command` can either return null or a new state.
/// If null is returned, then the state is not altered.
@immutable
abstract class Command<T> {
  Future<T> call(T state);
}
