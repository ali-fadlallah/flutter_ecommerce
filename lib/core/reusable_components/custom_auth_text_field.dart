import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Validator = String? Function(String?)?;

class CustomAuthTextField extends StatelessWidget {
  final String textFieldLabel;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool secureText;
  final String hintText;
  final Widget? passwordIconVisibility;
  final int? maxLength;

  final Validator validator;

  const CustomAuthTextField({
    super.key,
    required this.textFieldLabel,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.passwordIconVisibility,
    this.maxLength,
    required this.validator,
    this.secureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textFieldLabel,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            suffixIcon: passwordIconVisibility,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.black.withOpacity(0.70),
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.r),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: BorderSide(width: 1.w, color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.r),
            ),
            fillColor: Colors.white,
            filled: true,
            counterText: '',
          ),
          controller: controller,
          keyboardType: keyboardType,
          obscureText: secureText,
          maxLength: maxLength,
          validator: validator,
        ),
      ],
    );
  }
}
