import 'package:get_it/get_it.dart';
import 'package:yess_nutrition/presentation/providers/bottom_navigation_bar_notifier.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton(() => BottomNavigationBarNotifier());
}
