import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShowDialog {
  static void showDialogAwesome(
      BuildContext context,
      DialogType dialogType,
      String title,
      String desc,
      Function()? btnCancelOnPress,
      Function()? btnOkOnPress) {
    AwesomeDialog(
            context: context,
            dialogType: dialogType,
            animType: AnimType.rightSlide,
            title: title,
            desc: desc,
            btnCancelOnPress: btnCancelOnPress,
            btnOkOnPress: btnOkOnPress,
            btnCancelText: 'Huỷ',
            btnOkText: 'Tiếp tục')
        .show();
  }

  static void showDialogLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false,
      builder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(
              height: 4.h,
            ),
            const Text('Vui lòng đợi....'),
          ],
        ),
      ),
    );
  }
}
