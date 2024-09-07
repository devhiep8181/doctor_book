import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/common/widgets/custom_show_dialog.dart';
import 'package:doctor_book/features/schedule/presentation/blocs/schedule/schedule_bloc.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../base/notification_service.dart';
import '../../../../base/send_notification.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(GetScheduleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomImageView(
            imagePath: Assets.images.background.path,
          ),
          Column(children: [
            Container(
              height: 80,
              width: context.isWidthScreen,
              color: AppColors.primaryColor,
              child: Center(
                  child: Text(
                'Lịch hẹn',
                style: AppStyles.whiteText,
              )),
            ),
            BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state.message == 'success' &&
                    state.listSchedule.isNotEmpty) {
                  if (!UserSingleton().email.contains('doctor')) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: statusColor(state
                                                  .listSchedule[index].status)
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                statusSchedule(state
                                                    .listSchedule[index]
                                                    .status),
                                                style: TextStyle(
                                                    color: statusColor(state
                                                        .listSchedule[index]
                                                        .status)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Text('STT 1'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Bác sĩ: ${state.doctorSchedule[state.listSchedule[index].uidDoctor]?.fullName ?? ''} '),
                                      CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor:
                                            AppColors.salmonPinkColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Giờ khám'),
                                      Text(
                                          '${state.listSchedule[index].timeSchedule} - ${state.listSchedule[index].daySchedule}'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Chuyên khoa'),
                                      Text(state
                                              .doctorSchedule[state
                                                  .listSchedule[index]
                                                  .uidDoctor]
                                              ?.department ??
                                          ''),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Bệnh nhân'),
                                      Text(UserSingleton().name),
                                    ],
                                  ),
                                  if (state.listSchedule[index].status == 2)
                                    BlocListener<ScheduleBloc, ScheduleState>(
                                      listener: (context, state) {
                                        if (state.message ==
                                            'delete schuedule success') {
                                          context
                                              .read<ScheduleBloc>()
                                              .add(GetScheduleEvent());
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 18.h),
                                        child: CustomElevatedButton(
                                          onPressed: () {
                                            CustomShowDialog.showDialogAwesome(
                                                context,
                                                DialogType.warning,
                                                'Xác nhận huỷ lịch hẹn',
                                                'Bạn có chắc chắn muốn huỷ lịch hẹn ',
                                                () {
                                              //context.pop();
                                            }, () {
                                              context.read<ScheduleBloc>().add(
                                                  DeleteScheduleEvent(
                                                      uidSchedule: state
                                                              .listSchedule[
                                                                  index]
                                                              .uidSchedule ??
                                                          ''));
                                            });
                                          },
                                          textBtn: 'Huỷ lịch hẹn',
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: state.listSchedule.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: statusColor(state
                                                  .listSchedule[index].status)
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                statusSchedule(state
                                                    .listSchedule[index]
                                                    .status),
                                                style: TextStyle(
                                                    color: statusColor(state
                                                        .listSchedule[index]
                                                        .status)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Text('STT 1'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Bệnh nhân: ${state.patientSchedule[state.listSchedule[index].uidPatient]?.fullName ?? ''} '),
                                      CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor:
                                            AppColors.salmonPinkColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Giờ khám'),
                                      Text(
                                          '${state.listSchedule[index].timeSchedule} - ${state.listSchedule[index].daySchedule}'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Số điện thoại'),
                                      Text(state
                                              .patientSchedule[state
                                                  .listSchedule[index]
                                                  .uidPatient]
                                              ?.phoneNumber ??
                                          ''),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                foregroundColor:
                                                    AppColors.whiteColor,
                                                backgroundColor:
                                                    AppColors.grey200Color,
                                                disabledForegroundColor:
                                                    AppColors.greyColor,
                                                disabledBackgroundColor:
                                                    AppColors.greyColor,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r)),
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<ScheduleBloc>()
                                                    .add(ProcessScheduleEvent(
                                                        status: 0,
                                                        schedule:
                                                            state.listSchedule[
                                                                index]));
                                                NotificationService()
                                                    .showNotification(
                                                  3,
                                                  "Thông báo đặt lịch",
                                                  "Bạn đã từ chối lịch hẹn với ${state.patientSchedule[state.listSchedule[index].uidPatient]?.fullName ?? ''}",
                                                );

                                                log('doctor name send ========> ${UserSingleton().name}');
                                                final nameDoctor =
                                                    UserSingleton().name;
                                                SendNotification.sendToNotification(
                                                    'Lịch hẹn bị huỷ',
                                                    'Bạn không đặt được lịch với bác sĩ $nameDoctor',
                                                    'ejbYJbaYQNWThowX9XFfUD:APA91bEVIuVCJiDvNV1kKBLTSs0xBbtKYukXwNHQN3Hv_vIzVrB31OFHVOlky1XYY_4RqLFfY75b0-J_jZCFZcCYXK4EQupLdl5U2pJRigcGpeScUQtWvm5MRHLNfaPGcN8x2cd2l1wp');
                                              },
                                              child: Text(
                                                'Huỷ',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.blackColor),
                                              ))),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                foregroundColor:
                                                    AppColors.whiteColor,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 28, 215, 150),
                                                disabledForegroundColor:
                                                    AppColors.greyColor,
                                                disabledBackgroundColor:
                                                    AppColors.greyColor,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r)),
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<ScheduleBloc>()
                                                    .add(ProcessScheduleEvent(
                                                        status: 0,
                                                        schedule:
                                                            state.listSchedule[
                                                                index]));
                                                log('doctor name send ========> ${UserSingleton().name}');

                                                NotificationService()
                                                    .showNotification(
                                                  3,
                                                  "Thông báo đặt lịch",
                                                  "Bạn đã đồng ý lịch hẹn với ${state.patientSchedule[state.listSchedule[index].uidPatient]?.fullName ?? ''}",
                                                );
                                                final nameDoctor =
                                                    UserSingleton().name;
                                                SendNotification.sendToNotification(
                                                    'Đặt lịch hẹn thành công',
                                                    'Bạn đặt lịch thành công với bác sĩ $nameDoctor',
                                                    'ejbYJbaYQNWThowX9XFfUD:APA91bEVIuVCJiDvNV1kKBLTSs0xBbtKYukXwNHQN3Hv_vIzVrB31OFHVOlky1XYY_4RqLFfY75b0-J_jZCFZcCYXK4EQupLdl5U2pJRigcGpeScUQtWvm5MRHLNfaPGcN8x2cd2l1wp');
                                              },
                                              child: const Text('Xác nhận'))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: state.listSchedule.length,
                      ),
                    );
                  }
                } else if (state.message == 'success' &&
                    state.listSchedule.isEmpty) {
                  if (UserSingleton().email.contains('doctor')) {
                    return const Center(
                      child: Text('Bạn chưa có lịch hẹn nào từ bệnh nhân'),
                    );
                  } else {
                    return const Center(
                      child: Text('Bạn chưa đặt lịch khám với bác sĩ nào'),
                    );
                  }
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ])
        ],
      ),
    );
  }

  String statusSchedule(int status) {
    String statusString = '';
    switch (status) {
      case 0:
        statusString = 'Huỷ lịch hẹn';
      case 1:
        statusString = "Đã đặt lịch";
      case 2:
        statusString = "Chờ xác nhận";
    }
    return statusString;
  }

  Color statusColor(int status) {
    Color colorStatus = Colors.red;
    switch (status) {
      case 0:
        colorStatus = AppColors.red600Color;
      case 1:
        colorStatus = AppColors.greenColor;
      case 2:
        colorStatus = AppColors.amberColor;
    }
    return colorStatus;
  }
}
