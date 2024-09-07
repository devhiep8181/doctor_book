import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/utils/process_datetime.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/features/choose_doctor/data/models/doctor_model.dart';
import 'package:doctor_book/features/info_patient/presentation/blocs/bloc/info_patient_bloc.dart';
import 'package:doctor_book/features/process_schedule/presentation/blocs/bloc/process_schedule_bloc.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ReceiveScheduleScreen extends StatelessWidget {
  const ReceiveScheduleScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200Color,
      bottomNavigationBar: Container(
          height: 50.h,
          margin: const EdgeInsets.symmetric(horizontal: 16)
              .copyWith(top: 16, bottom: 8),
          child: Row(
            children: [
              Expanded(
                  child: CustomElevatedButton(
                onPressed: () {
                  context.goNamed(home);
                },
                backgroundColor: AppColors.whiteColor,
                textBtn: 'Về trang chủ',
                textColor: AppColors.black87Color,
              )),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                  child: CustomElevatedButton(
                onPressed: () {
                  context.goNamed(chat);
                },
                textBtn: 'Chat với bác sĩ',
              ))
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      context.goNamed(home);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.black87Color,
                    )),
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(vertical: 16.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.whiteColor),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Đã đặt lịch',
                        style: AppStyles.body2
                            .copyWith(color: AppColors.greenColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(ProcessDatetime.formatDateTime(DateTime.now())),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.r)),
                child: BlocBuilder<ProcessScheduleBloc, ProcessScheduleState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text('STT'),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  '1',
                                  style: AppStyles.headerLager.copyWith(
                                      color: AppColors.greenColor,
                                      fontSize: 50.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              child: CustomImageView(
                                width: 60.w,
                                imagePath: doctor.profilePicture,
                                radius: BorderRadius.circular(100.r),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Bác sĩ'),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text('Bác sĩ ${doctor.fullName}'),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mã lịch khám'),
                            Text('YMA2408091403'),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ngày khám'),
                            Text(state.dayChoose),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Giờ khám'),
                            Text(state.timeChoose)
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Bác sĩ'),
                            Text('Bác sĩ ${doctor.fullName}'),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Chuyên khoa'),
                            Text(doctor.department),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const Center(child: Text('THÔNG TIN BỆNH NHÂN')),
                        BlocBuilder<InfoPatientBloc, InfoPatientState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Họ và tên'),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(state.patientModel.fullName),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Giới tính'),
                                          Text(state.patientModel.gender),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Ngày sinh'),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(state.patientModel.birthDay),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Điện thoại'),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(state.patientModel.phoneNumber),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
