import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Validator = String? Function(String?)?;

class CustomProfileTextField extends StatelessWidget {
  final String textFieldLabel;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool secureText;
  final String? hintText;
  final int? maxLength;
  final Widget? editIcon;
  final Validator validator;

  const CustomProfileTextField({
    super.key,
    required this.textFieldLabel,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.editIcon,
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
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelSmall,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 2.w,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 2.w,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: BorderSide(width: 2.w, color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 2.w,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.w, color: Colors.red),
              borderRadius: BorderRadius.circular(15.r),
            ),
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
