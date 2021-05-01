import 'package:flutter/foundation.dart';
import 'package:foodb/core/entities/step.dart';
import 'package:foodb/ui/helpers/text_value.dart';
import 'package:foodb/ui/vm/vm.dart';

class VMStep extends VM {
  final description = ValueNotifier(TextValue());

  VMStep(Step value) {
    description.value = TextValue(value: value.description);
  }

  void setDescription(String value) {
    final error = value.isEmpty ? "this field must not be empty" : "";
    description.value = TextValue(value: value, error: error);
  }

  Step? get value => description.value.error.isNotEmpty
      ? null
      : Step(description: description.value.value);
}
