import 'package:foodb/ui/vm/vm_favorites.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;

void initLocator() {
  _setupBlocs(locator);
}

void _setupBlocs(GetIt locator) {
  locator.registerFactory(() => VMFavorites());
}
