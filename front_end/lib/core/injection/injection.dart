import 'package:front_end/core/injection/auth_injection.dart';
import 'package:front_end/core/injection/book_injection.dart';
import 'package:front_end/core/injection/chat_injection.dart';
import 'package:front_end/core/injection/favorite_injection.dart';
import 'package:front_end/core/network/network.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  AuthInjection().init();
  BookInjection().init();
  ChatInjection().init();
  FavoriteInjection().init();

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => NoParams());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
