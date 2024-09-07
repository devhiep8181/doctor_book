import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/features/info_patient/presentation/blocs/bloc/info_patient_bloc.dart';
import 'package:doctor_book/features/info_patient/presentation/screens/edit_patient_screen.dart';
import 'package:doctor_book/features/info_patient/presentation/screens/info_patient_screen.dart';
import 'package:doctor_book/features/process_schedule/presentation/screens/process_schedule_screen.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomImageView(
            imagePath: Assets.images.background.path,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: context.isWidthScreen,
                    padding: EdgeInsets.only(top: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.r,
                          backgroundColor: AppColors.grey200Color,
                          child: Center(
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 60.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          'Xin chào ${UserSingleton().name}',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.whiteColor),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<InfoPatientBloc>()
                                .add(GetInfoPatientEvent());
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const EditPatientScreen()));
                          },
                          child: Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                                vertical: 16),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.grey400Color))),
                            child: ListTile(
                              leading: Icon(
                                Icons.gamepad,
                                color: AppColors.blueColor,
                              ),
                              title: const Text('Hồ sơ bệnh nhân'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              vertical: 16),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.grey400Color))),
                          child: ListTile(
                            leading: Icon(
                              Icons.person_2_outlined,
                              color: AppColors.redAccentColor,
                            ),
                            title: const Text('Thay đổi thông tin tài khoản'),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              vertical: 16),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.grey400Color))),
                          child: ListTile(
                            leading: Icon(
                              Icons.share,
                              color: AppColors.amberColor,
                            ),
                            title: const Text('Phản hồi ứng dụng'),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      context.pushNamed(signin);
                    },
                    textBtn: 'Đăng xuất',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
