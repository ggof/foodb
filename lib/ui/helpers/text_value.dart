class TextValue {
  final String value;
  final String error;

  TextValue({
    this.value = "",
    this.error = "",
  });

  TextValue copyWith({String? value, String? error}) => TextValue(
        value: value ?? this.value,
        error: error ?? this.error,
      );
}
