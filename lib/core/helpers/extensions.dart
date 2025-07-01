import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

extension IsNullOrEmpty on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

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
    String? title,
    String? content,
    Widget? contentWidget,
    String confirmText = "OK",
    VoidCallback? onConfirm,
    bool dismissible = true,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: dismissible,
      builder: (context) => AlertDialog(
        title: title != null
            ? Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        content: contentWidget ?? (content != null ? Text(content) : null),
        actions: [
          TextButton(
            onPressed: () {
              pop();
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
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: const CircularProgressIndicator(
          color: AppColors.blueColor,
        ),
      ),
    );
  }
}

extension FirstLetterCapitalization on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase();
  }
}

extension ShowToast on BuildContext {
  void showToast(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
