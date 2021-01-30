
import 'dart:collection';

import 'package:flutter/foundation.dart';

class ValueListNotifier<T> implements ChangeNotifier, ValueListenable<List<T>> {
  final List<VoidCallback> _listeners = [];
  List<T> _value;

  ValueListNotifier(List<T> value) : _value = value;

  List<T> get value => UnmodifiableListView(_value);
  set value(List<T> list) {
    _value = list;
    notifyListeners();
  }

  void add(T item) {
    _value.add(item);
    notifyListeners();
  }

  void remove(T item) {
    _value.remove(item);
    notifyListeners();
  }

  void replaceWhere(T item, bool Function(T item) predicate) {
    _value = _value.map((i) => predicate(i) ? item : i);
    notifyListeners();
  }

  @override
  void addListener(listener) => _listeners.add(listener);

  @override
  void dispose() => _listeners.clear();

  @override
  bool get hasListeners => _listeners.isNotEmpty;

  @override
  void notifyListeners() => _listeners.forEach((callback) => callback());

  @override
  void removeListener(listener) => _listeners.remove(listener);
}