import 'package:flutter/foundation.dart';

abstract class VM {
  final state = ValueNotifier<ViewState>(Busy());
  final navigation = ValueNotifier<NavigationEvent>(null);

  void setIdle() => state.value = Idle();
  void setBusy() => state.value = Busy();
  void navigate(NavigationEvent value) => navigation.value = value;
}

abstract class ViewState {}

class Idle extends ViewState {}

class Busy extends ViewState {}

class NavigationEvent {
  final String destination;

  NavigationEvent(this.destination);
}
