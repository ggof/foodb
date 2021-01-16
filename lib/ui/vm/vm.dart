import 'package:flutter/cupertino.dart';

abstract class VM {
  final state = ValueNotifier<ViewState>(Idle());
  final navigation = ValueNotifier<NavigationEvent>(null);
  final error = ValueNotifier<String>("");

  void setIdle() => state.value = Idle();
  void setBusy() => state.value = Busy();
  void setError(String value) => error.value = value;
  void navigate(NavigationEvent value) => navigation.value = value;
}

abstract class ViewState {}

class Idle extends ViewState {}

class Busy extends ViewState {}

class NavigationEvent {
  final String destination;
  // TODO: add parameters

  NavigationEvent(this.destination);
}
