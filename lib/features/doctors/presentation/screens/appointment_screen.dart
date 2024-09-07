import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/custom_image_view.dart';
import '../../../../gen/assets.gen.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomImageView(
            imagePath: Assets.images.background.path,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 80.h,
                  width: context.isWidthScreen,
                  color: AppColors.primaryColor,
                  child: Center(
                      child: Text(
                    'Lịch hẹn',
                    style: AppStyles.whiteText,
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
