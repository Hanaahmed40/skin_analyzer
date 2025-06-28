import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon; // إضافة أيقونة اختيارية
  final IconData? suffixIcon;
 final  bool obscureText;
  final bool isPasswordField;


  const CustomTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = true,
    this.isPasswordField = false,
    // التأكد من إضافة الخيار في الـ constructor
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true; // حالة الإخفاء الافتراضية

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField; // إذا كان كلمة مرور، اجعله مخفيًا
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      obscureText: _obscureText,
      obscuringCharacter: '*',
      cursorColor: AppColors.blackColor,
      autocorrect: false, // 👈 يعطل التصحيح التلقائي
      enableSuggestions: false,
      decoration: InputDecoration(
        hintText: widget.hintText,
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
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.isPasswordField
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // تبديل الحالة
            });
          },
        )
            : null, // استخدام الأيقونة إذا كانت موجودة
      ),
    );
  }
}

