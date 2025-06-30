import 'package:event_planning/core/helpers/cache_helper.dart';
import 'package:event_planning/core/helpers/cache_keys.dart';
import 'package:event_planning/core/utils/app_utils.dart';

Future<void> checkIfOnboardingIsVisited() async {
  final onboarding = await CacheHelper.getBool(CacheKeys.onboarding);
  if (onboarding != null) {
    isOnboardingVisited = onboarding;
  } else {
    isOnboardingVisited = false;
  }
}
