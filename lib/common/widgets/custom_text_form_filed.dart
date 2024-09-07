// Flutter imports:
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.label,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.autofocus,
    this.textStyle,
    this.obscureText,
    this.textInputType,
    this.maxLine,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled,
    this.validator,
    this.textInputAction,
    this.hintStyle,
    this.onChanged,
    this.readOnly, this.errorText,
  });

  final Alignment? alignment;
  final double? width;
  final String? label;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLine;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormField(context),
          )
        : textFormField(context);
  }

  Widget textFormField(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLine ?? 1,
      validator: validator,
      decoration: decoration(context),
      onChanged: onChanged,
    );
  }

  InputDecoration decoration(BuildContext context) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.grey200Color)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.grey200Color)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.red600Color)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.red600Color)),
      labelText: label,
      labelStyle: AppStyles.body2,
      fillColor: fillColor ?? AppColors.whiteColor,
      filled: true,
      isDense: true,
      hintText: hintText,
      hintStyle: hintStyle,
      errorText: errorText,
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
    );
  }
}
