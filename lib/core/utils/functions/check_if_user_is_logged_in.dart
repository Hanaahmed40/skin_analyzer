import 'package:event_planning/core/helpers/extensions.dart';
 import '../../../models/user_model.dart';
 import '../../helpers/cache_keys.dart';
  import '../../helpers/secure_storage_helper.dart'; 
  import 'package:supabase_flutter/supabase_flutter.dart';
import '../app_utils.dart';
Future checkIfIsUserLoggedIn() 
async { final cachedUser = await SecureStorageHelper.getSecuredString(CacheKeys.user); 
final supabaseUser = Supabase.instance.client.auth.currentUser;
if (supabaseUser == null || cachedUser.isNullOrEmpty) { isUserLoggedIn = false;
 currentUser = null; } 
 else { currentUser = await UserModel.getSecuredUser(); 
 isUserLoggedIn = true; } }
