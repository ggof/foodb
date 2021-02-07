import 'dart:async';

import 'package:foodb/core/rxvms/commands/command.dart';
import 'package:rxdart/subjects.dart';

typedef UpdateCallback<T> = void Function(T value);

abstract class Manager<T> {
  final BehaviorSubject<T> _subject; 

  Manager(T initialState)
      : this._subject = BehaviorSubject.seeded(initialState);

  StreamSubscription<T> subscribe(UpdateCallback<T> callback) =>
      _subject.listen(callback);

  Future<void> execute(CommandPresenter presenter, Command<T> command) async {
    try {
      presenter.onLoading();

      final state = await command(_subject.value);
      if (state != null) {
        _emit(state);
        presenter.onSuccess();
      }

    } catch (e) {
      presenter.onError(e.toString());
    }
  }

  void _emit(T value) => _subject.sink.add(value);
}