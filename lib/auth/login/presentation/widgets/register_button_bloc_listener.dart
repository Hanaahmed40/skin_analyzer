import 'package:event_planning/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/cache_keys.dart';
import '../../../../core/helpers/secure_storage_helper.dart';
import '../../../../core/router/routes.dart';
import '../../../../cubits/register_cubit.dart';
import '../../../../cubits/register_state.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';

class RegisterButtonBlocListener extends StatelessWidget {
  const RegisterButtonBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (_, current) => _listenWhen(current.status),
      listener: (context, state) async => await _listener(state, context),
      child: ElevatedButton(
        onPressed: () => context.read<RegisterCubit>().register(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight, // لون الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // زوايا مستديرة
          ),
          padding: EdgeInsets.symmetric(vertical: 15), // ارتفاع الزر
        ),
        child: Text(
          AppLocalizations.of(context)!.create_account, // ترجمة زر تسجيل الدخول
          style: TextStyle(fontSize: 20, color: AppColors.whiteColor),
        ),
      ),
    );
  }

  Future<void> _listener(RegisterState state, BuildContext context) async {
    switch (state.status) {
      case RegisterStateStatus.loading:
        context.showLoadingDialog();
      case RegisterStateStatus.success:
        await _onRegisterSuccess(state, context);
      case RegisterStateStatus.failure:
        _onRegisterFailure(context, state);
      default:
        break;
    }
  }

  Future<void> _onRegisterSuccess(
      RegisterState state, BuildContext context) async {
    await SecureStorageHelper.setSecuredString(CacheKeys.userId, state.userId!);
    context.popTop();
    await Future.delayed(Duration(milliseconds: 675));
    context.pushReplacementNamed(Routes.home);
  }

  void _onRegisterFailure(BuildContext context, RegisterState state) {
    context.popTop();
    context.showAppDialog(content: state.errorMessage!);
  }

  bool _listenWhen(RegisterStateStatus status) =>
      status == RegisterStateStatus.loading ||
      status == RegisterStateStatus.failure ||
      status == RegisterStateStatus.success;
}
