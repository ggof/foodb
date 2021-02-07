import 'dart:math';

class IDGenerator {
  static Random _random = Random.secure();
  static String randomID([int len = 32]) {
    final values = List<int>.generate(len, (i) => _random.nextInt(33) + 89);
    return String.fromCharCodes(values);
  }
}
