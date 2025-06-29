import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

extension AppNavigator on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String newRoute, {Object? arguments}) {
    return Navigator.pushReplacementNamed(this, newRoute, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String newRoute, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      this,
      newRoute,
      (Route<dynamic> route) => false, // remove all previous routes
      arguments: arguments,
    );
  }

  void pop() => Navigator.pop(this);

  void popTop() => Navigator.of(this, rootNavigator: true).pop();
}

extension ShowDialog on BuildContext {
  Future<void> showAppDialog({
    required BuildContext context,
    String? title,
    required String content,
    String confirmText = "OK",
    VoidCallback? onConfirm,
    bool dismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              popTop();
              onConfirm?.call();
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}

extension ShowLoadingDialog on BuildContext {
  void showLoadingDialog() {
    showAdaptiveDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => const _LoadingWidget(),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: const CircularProgressIndicator(
          color: AppColors.blueColor,
        ),
      ),
    );
  }
}
