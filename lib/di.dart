import 'package:event_planning/cubits/diagnosis_cubit.dart';
import 'package:event_planning/data_source/main_remote_data_source.dart';
import 'package:event_planning/cubits/main_cubit.dart';
import 'package:event_planning/repositories/main_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/login/presentation/cubits/login_cubit.dart';

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
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());

  // Registering core
  getIt.registerLazySingleton<InternetChecker>(
      () => InternetChecker(getIt.get<InternetConnection>()));

  // Registering Data Sources
  getIt.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSource(getIt.get<GoTrueClient>()));
  getIt.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSource(getIt.get<GoTrueClient>()));
  getIt.registerLazySingleton<MainRemoteDataSource>(
      () => MainRemoteDataSource(getIt.get<SupabaseClient>()));

  // Registering Repositories
  getIt.registerLazySingleton<LoginRepo>(
      () => LoginRepo(getIt.get<LoginRemoteDataSource>()));
  getIt.registerLazySingleton<RegisterRepo>(
      () => RegisterRepo(getIt.get<RegisterRemoteDataSource>()));
  getIt.registerLazySingleton<MainRepo>(
      () => MainRepo(getIt.get<MainRemoteDataSource>()));

  // Registering Cubits
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt.get<LoginRepo>()));
  getIt.registerFactory<MainCubit>(() => MainCubit(getIt.get<MainRepo>()));
  getIt.registerFactory<DiagnosisCubit>(
      () => DiagnosisCubit(getIt.get<MainRepo>()));
}
