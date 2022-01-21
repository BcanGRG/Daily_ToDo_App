import 'package:get_it/get_it.dart';
import 'package:todo_app_demo/core/data/local_storage.dart';

class Locator {
  static final locator = GetIt.instance;
  static void setup() {
    locator.registerSingleton<LocalStorage>(HiveLocalStorage());
  }
}
