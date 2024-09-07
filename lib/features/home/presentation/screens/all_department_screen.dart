import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_elevated_button.dart';
import '../blocs/search/search_bloc.dart';

class AllDepartmentScreen extends StatelessWidget {
  const AllDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomImageView(
            imagePath: Assets.images.background.path,
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    height: 80.h,
                    padding: EdgeInsets.all(8.h),
                    width: context.isWidthScreen,
                    color: AppColors.primaryColor,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.whiteColor,
                            )),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            'Danh sách bác sĩ theo khoa',
                            style: AppStyles.whiteText,
                          )),
                        ),
                      ],
                    ),
                  ),
                  if (state.listDoctor.isNotEmpty &&
                      state.message == 'search suceess')
                    state.listDoctorSearch.isNotEmpty
                        ? Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: ListView.separated(
                                itemCount: state.listDoctorSearch.length,
                                itemBuilder: (context, index) {
                                  final doctor = state.listDoctorSearch[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 40.r,
                                                backgroundColor:
                                                    AppColors.grey200Color,
                                                child: CustomImageView(
                                                  width: 80,
                                                  radius: BorderRadius.circular(
                                                      100.r),
                                                  imagePath:
                                                      doctor.profilePicture,
                                                  fit: BoxFit.fill,
                                                )),
                                            SizedBox(
                                              width: 24.h,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(doctor.qualification),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(doctor.fullName),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                    '${doctor.yearsOfExperience} năm kinh nghiệm'),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r),
                                                          color: AppColors
                                                              .grey200Color),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                            doctor.department),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r),
                                                          color: AppColors
                                                              .grey200Color),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                            doctor.department),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on),
                                            Expanded(
                                              child: Text(
                                                'Nơi công tác: ${doctor.hospital}',
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on),
                                            Expanded(
                                              child: Text(
                                                'Địa chỉ phòng khám: ${doctor.workAddress}',
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            width: 200.w,
                                            child: CustomElevatedButton(
                                              onPressed: () => context.goNamed(
                                                  processSchedule,
                                                  extra: doctor),
                                              textBtn: 'Đặt lịch ngay',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Container(
                                    height: 24,
                                    color: AppColors.grey200Color,
                                  );
                                },
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(32.h),
                            child: const Center(
                              child: Text('Không tìm thấy bác sĩ'),
                            ),
                          )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
