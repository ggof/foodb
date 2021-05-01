import 'dart:collection';

import 'package:flutter/foundation.dart';

class ListNotifier<T> with ChangeNotifier implements ValueListenable<List<T>> {
  List<T> _value;

  ListNotifier(List<T> value) : _value = value;

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
    _value = _value.map((i) => predicate(i) ? item : i).toList();
    notifyListeners();
  }
}
