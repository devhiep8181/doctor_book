import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileDoctorScreen extends StatelessWidget {
  const ProfileDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomImageView(
            imagePath: Assets.images.background.path,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: context.isWidthScreen,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.whiteColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundColor: AppColors.grey400Color,
                      ),
                      Text('Xin chào ${UserSingleton().name}')
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  child: CustomElevatedButton(
                    onPressed: () {
                      context.pushNamed(signin);
                    },
                    textBtn: 'Đăng xuất',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
