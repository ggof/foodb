import 'dart:async';

import 'package:foodb/core/rxvms/commands/command.dart';
import 'package:foodb/core/rxvms/options/options.dart';
import 'package:rxdart/subjects.dart';

typedef UpdateCallback<T> = void Function(T value);

abstract class Manager<T> {
  StreamSubscription<T> subscribe(UpdateCallback<T> callback);
  Future<void> execute(
    CommandPresenter presenter,
    Command<T> command, {
    Option onLoading,
    Option onSuccess,
  });
}

abstract class BaseManager<T> implements Manager<T> {
  final BehaviorSubject<T> _subject;

  BaseManager(T initialState)
      : this._subject = BehaviorSubject.seeded(initialState);

  StreamSubscription<T> subscribe(UpdateCallback<T> callback) =>
      _subject.listen(callback);

  Future<void> execute(
    CommandPresenter presenter,
    Command<T> command, {
    Option onSuccess = const Option.doNothing(),
    Option onLoading = const Option.doNothing(),
  }) async {
    try {
      presenter.onLoading(onLoading);

      final state = await command(_subject.valueWrapper!.value);
      if (state != null) {
        _emit(state);
      }

      presenter.onSuccess(onSuccess);
    } catch (e) {
      presenter.onError(e.toString());
    }
  }

  void _emit(T value) => _subject.sink.add(value);
}