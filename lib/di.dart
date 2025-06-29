import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/login/data/data_source/auth_remote_data_source.dart';
import 'auth/login/data/repository/auth_repo.dart';
import 'core/network/internet_checker.dart';

final getIt = GetIt.instance;

void setupDI() {
  // Registering external dependencies
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<GoTrueClient>(
      () => getIt.get<SupabaseClient>().auth);
  getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());

  // Registering core
  getIt.registerLazySingleton<InternetChecker>(
      () => InternetChecker(getIt.get<InternetConnection>()));

  // Registering Data Sources
  getIt.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSource(getIt.get<GoTrueClient>()));
  getIt.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSource(getIt.get<GoTrueClient>()));

  // Registering Repositories
  getIt.registerLazySingleton<LoginRepo>(
      () => LoginRepo(getIt.get<LoginRemoteDataSource>()));
  getIt.registerLazySingleton<RegisterRepo>(
      () => RegisterRepo(getIt.get<RegisterRemoteDataSource>()));
}
