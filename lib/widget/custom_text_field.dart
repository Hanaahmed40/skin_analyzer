import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.label,
    this.hintText,
    this.initialValue,
    this.onSubmit,
    this.borderRadius,
    this.onSaved,
    this.autofillHints,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.onChanged,
    this.contentPadding,
    this.onTap,
    this.focusNode,
    this.onEditingComplete,
    this.textCapitalization = TextCapitalization.none,
    this.validating,
    this.enabledBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.errorBorder,
    this.border,
    this.fillColor,
    this.hintStyle,
    this.autofocus = false,
    this.disabledBorder,
    this.maxLines = 1,
    this.minLines,
    this.enableSuggestions = true,
    this.filled = true,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final bool? enabled;
  final String? label;
  final List<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final Function(String submittedText)? onSubmit;
  final Function(String? value)? onSaved;
  final void Function()? onTap;
  final String? hintText, initialValue;
  final TextAlign textAlign;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validating;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? border;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final bool enableSuggestions;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: autofocus,
      enableSuggestions: enableSuggestions,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      onSaved: onSaved,
      onTap: onTap,
      autofillHints: autofillHints,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      style: TextStyle(
        color: AppColors.blackColor,
        fontSize: 14,
      ),
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
      validator: validating,
      onEditingComplete: onEditingComplete,
    );
  }
}
