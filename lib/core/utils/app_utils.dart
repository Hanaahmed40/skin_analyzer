import '../../models/user_model.dart';

String? currentUserId;
UserModel? currentUser;
bool isUserLoggedIn = false;
bool isOnboardingVisited = false;

class AppUtils {
  AppUtils._();

  static const int remoteTableId = 2025;
  static const String remoteTableIdColumnName = 'id';
  static const String remoteTableName = 'data';
  static const String profilesTable = 'profiles';
  static const String imagesStorage = 'images';
}
