import 'package:event_planning/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/cache_keys.dart';
import '../../../../core/helpers/secure_storage_helper.dart';
import '../../../../core/router/routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';
import '../cubits/login_cubit.dart';
import '../cubits/login_state.dart';

class LoginButtonBlocListener extends StatelessWidget {
  const LoginButtonBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (_, current) => _listenWhen(current.status),
      listener: (context, state) async => await _listener(state, context),
      child: ElevatedButton(
        onPressed: () => context.read<LoginCubit>().login(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight, // لون الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // زوايا مستديرة
          ),
          padding: EdgeInsets.symmetric(vertical: 15), // ارتفاع الزر
        ),
        child: Text(
          AppLocalizations.of(context)!.login, // ترجمة زر تسجيل الدخول
          style: TextStyle(fontSize: 20, color: AppColors.whiteColor),
        ),
      ),
    );
  }

  Future<void> _listener(LoginState state, BuildContext context) async {
    switch (state.status) {
      case LoginStateStatus.loading:
        context.showLoadingDialog();
      case LoginStateStatus.success:
        await _onLoginSuccess(state, context);
      case LoginStateStatus.failure:
        _onLoginFailure(context, state);
      default:
        break;
    }
  }

  void _onLoginFailure(BuildContext context, LoginState state) {
    context.popTop();
    context.showAppDialog(content: state.errorMessage!);
  }

  Future<void> _onLoginSuccess(LoginState state, BuildContext context) async {
    await SecureStorageHelper.setSecuredString(CacheKeys.userId, state.userId!);
    context.popTop();
    await Future.delayed(Duration(milliseconds: 675));
    context.pushReplacementNamed(Routes.home);
  }

  bool _listenWhen(LoginStateStatus status) =>
      status == LoginStateStatus.failure ||
      status == LoginStateStatus.success ||
      status == LoginStateStatus.loading;
}
