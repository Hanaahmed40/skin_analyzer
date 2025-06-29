import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/utils/app_utils.dart';

class MainRemoteDataSource {
  final SupabaseClient _supabaseClient;

  MainRemoteDataSource(this._supabaseClient);

  Future<Map<String, dynamic>> fetchRemoteData() async {
    return await _supabaseClient
        .from(AppUtils.remoteTableName)
        .select()
        .eq(AppUtils.remoteTableIdColumnName, AppUtils.remoteTableId)
        .single();
  }
}
