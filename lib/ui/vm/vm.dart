import 'package:flutter/foundation.dart';
import 'package:foodb/core/rxvms/commands/command.dart';
import 'package:foodb/core/rxvms/options/options.dart';

abstract class VM implements CommandPresenter {
  final state = ValueNotifier<ViewState>(Busy());
  final navigation = ValueNotifier<NavigationEvent>(null);

  void setIdle() => state.value = Idle();
  void setBusy() => state.value = Busy();
  void navigate(NavigationEvent value) => navigation.value = value;

  @override
  void onError(String error) => print(error);

  @override
  void onLoading(LoadingOption option) => option(this);

  @override
  void onSuccess(SuccessOption option) => option(this);
}

abstract class ViewState {}

class Idle extends ViewState {}

class Busy extends ViewState {}

class NavigationEvent {
  final String destination;

  NavigationEvent(this.destination);
}
