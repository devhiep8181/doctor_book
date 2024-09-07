// Flutter imports:
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.child,
    this.textBtn,
    this.onPressed,
    this.buttonStyle,
    this.buttonTextStyle,
    this.isDisabled,
    this.focusNode,
    this.height,
    this.width,
    this.margin,
    this.alignment,
    this.backgroundColor,
    this.textColor,
  });
  final String? textBtn;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? buttonTextStyle;
  final bool? isDisabled;
  final FocusNode? focusNode;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Widget? child;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: backgroundColor ?? const Color.fromARGB(255, 28, 215, 150),
                  disabledForegroundColor: AppColors.greyColor,
                  disabledBackgroundColor: AppColors.greyColor,
                  //side: BorderSide(color: AppColors.whiteColor),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                onPressed: onPressed ?? () {},
                child: child ??
                    Text(
                      textBtn ?? '',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.montserrat,
                          color: textColor
                          ),
                    ))),
      ],
    );
  }
}
