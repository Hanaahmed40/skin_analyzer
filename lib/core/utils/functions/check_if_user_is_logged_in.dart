import 'package:event_planning/core/helpers/extensions.dart';

import '../../../models/user_model.dart';
import '../../helpers/cache_keys.dart';
import '../../helpers/secure_storage_helper.dart';
import '../app_utils.dart';

Future<void> checkIfIsUserLoggedIn() async {
  final cachedUser = await SecureStorageHelper.getSecuredString(CacheKeys.user);
  if (cachedUser.isNullOrEmpty) {
    isUserLoggedIn = false;
  } else {
    currentUser = await UserModel.getSecuredUser();
    isUserLoggedIn = true;
  }
}
