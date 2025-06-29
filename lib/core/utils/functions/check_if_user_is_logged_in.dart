import 'package:event_planning/core/helpers/extensions.dart';

import '../../helpers/cache_keys.dart';
import '../../helpers/secure_storage_helper.dart';
import '../app_utils.dart';

Future<void> checkIfIsUserLoggedIn() async {
  final cachedUserId =
      await SecureStorageHelper.getSecuredString(CacheKeys.userId);
  if (cachedUserId.isNullOrEmpty) {
    isUserLoggedIn = false;
  } else {
    currentUserId = cachedUserId;
    isUserLoggedIn = true;
  }
}
