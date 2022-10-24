
import 'package:get_it/get_it.dart';
import 'package:sk/core/services/auth_Services.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  print("AuthServices calling");
  locator.registerSingleton(AuthServices());
  // deviceLocator.registerSingleton(DeviceType());
  // locator.registerSingleton(DatabaseServices());
  print("AuthServices registered");
}
