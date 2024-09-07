import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static FToast fToast = FToast();

  static void initFToast(BuildContext context) {
    fToast.init(context);
  }

  static void showToastNoInternet(BuildContext context,
      {ToastGravity? gravity, String? msg}) {
    initFToast(context);
    fToast.showToast(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(30.r)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                msg ?? 'Vui lòng kiểm tra kết nối internet',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )),
        gravity: gravity ?? ToastGravity.TOP,
        toastDuration: const Duration(seconds: 3));
  }

  static void showToast(BuildContext context, String msg,
      {ToastGravity? gravity}) {
    initFToast(context);
    fToast.showToast(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(30.r)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            )),
        gravity: gravity ?? ToastGravity.TOP,
        toastDuration: const Duration(seconds: 3));
  }
}
