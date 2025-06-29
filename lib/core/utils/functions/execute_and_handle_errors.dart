import 'dart:developer' show log;

import '../../../di.dart';
import '../../network/internet_checker.dart';
import '../../supabase/supabase_error_handler.dart';
import '../../supabase/supabase_request_result.dart';

Future<SupabaseRequestResult<T>> executeAndHandleErrors<T>(
  Future<T> Function() function,
) async {
  if (await getIt.get<InternetChecker>().isConnected) {
    try {
      final response = await function();
      return SupabaseRequestResult<T>.success(response);
    } catch (error) {
      log(
        '>>>>>>>>> CATCHED IN executeAndHandleErrors: $error <<<<<<<<<<',
      );
      return SupabaseRequestResult.failure(
          SupabaseErrorHandler.handleError(error));
    }
  } else {
    return SupabaseRequestResult.failure(
      SupabaseErrorHandler.handleError(
          "No internet connection. Please check your connection and try again."),
    );
  }
}
