import 'package:doctor_book/base/send_notification.dart';
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/features/choose_doctor/data/models/doctor_model.dart';
import 'package:doctor_book/features/info_patient/presentation/blocs/bloc/info_patient_bloc.dart';
import 'package:doctor_book/features/process_schedule/presentation/blocs/bloc/process_schedule_bloc.dart';
import 'package:doctor_book/features/process_schedule/presentation/screens/process_schedule_screen.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../base/notification_service.dart';

class ConfirmScheduleScreen extends StatefulWidget {
  const ConfirmScheduleScreen({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<ConfirmScheduleScreen> createState() => _ConfirmScheduleScreenState();
}

class _ConfirmScheduleScreenState extends State<ConfirmScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProcessScheduleBloc, ProcessScheduleState>(
      listener: (context, state) {
        if (state.message == 'success schedule') {
          NotificationService().showNotification(
            1,
            "Thông báo đặt lịch",
            "Bạn vui lòng chờ xác nhận từ bác sĩ ${widget.doctor.fullName}",
          );
          SendNotification.sendToNotification(
              'Hãy xác nhận lịch hẹn',
              'Bạn nhận được lịch hẹn mới từ ${UserSingleton().name}',
              'dNrqdVrrTuiSZJI5NoRhkF:APA91bFwrfflHxTkBlO4s1aCPELegCXoqPs9fuH64rWcDP-xRHQ5DSH5eybR98u9TPBdT8VMQptnfA_KoutbwLmN3ONmpxS8HTplACj_GjEz2DsKsAuIm2qg-YX6KrCGJzCdIwLSBUJc');

          context.goNamed(receiveSchedule, extra: widget.doctor);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.grey200Color,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: Text(
            'Xác nhận lịch khám',
            style: AppStyles.whiteText,
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<ProcessScheduleBloc, ProcessScheduleState>(
          builder: (context, state) {
            return Container(
              height: 50.h,
              margin: const EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(top: 16, bottom: 8),
              child: CustomElevatedButton(
                onPressed: () {
                  context.read<ProcessScheduleBloc>().add(ScheduleEvent(
                      chooseDate: state.dayChoose,
                      chooseTime: state.timeChoose,
                      uidUser: UserSingleton().email,
                      uidDoctor: widget.doctor.email,
                      ));
                },
                textBtn: 'Xác nhận lịch hẹn',
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProcessConfirmWidget(),
              Text('THÔNG TIN ĐĂNG KÝ'),
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.whiteColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BlocBuilder<ProcessScheduleBloc, ProcessScheduleState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoDoctorWidget(doctor: widget.doctor),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Giờ khám',
                                    style: AppStyles.caption1
                                        .copyWith(fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(state.timeChoose,
                                      style: AppStyles.caption1.copyWith(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Ngày khám',
                                    style: AppStyles.caption1
                                        .copyWith(fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    state.dayChoose,
                                    style: AppStyles.caption1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chuyên khoa',
                                style: AppStyles.caption1
                                    .copyWith(fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                widget.doctor.department,
                                style: AppStyles.caption1
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bác sĩ',
                                style: AppStyles.caption1
                                    .copyWith(fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'Bác sĩ: ${widget.doctor.fullName}',
                                style: AppStyles.caption1
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          const Center(child: Text('THÔNG TIN BỆNH NHÂN')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                BlocBuilder<InfoPatientBloc, InfoPatientState>(
                              builder: (context, state) {
                                if (state.infoPatientStatus ==
                                    InfoPatientStatus.success) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              const Text('Giới tính'),
                                              Text(state.patientModel.gender),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Ngày sinh'),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(state.patientModel.birthDay),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
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
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProcessConfirmWidget extends StatelessWidget {
  const ProcessConfirmWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.primaryColor,
                child: Text(
                  '1',
                  style: AppStyles.caption2,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Chọn lịch khám',
                style: AppStyles.caption2,
              )
            ],
          ),
          const Icon(Icons.chevron_right),
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.blueColor,
                child: Text(
                  '2',
                  style: AppStyles.caption2,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Xác nhận',
                style: AppStyles.caption2,
              )
            ],
          ),
          const Icon(Icons.chevron_right),
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.grey400Color,
                child: Text(
                  '3',
                  style: AppStyles.caption2,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Nhận lịch hẹn',
                style: AppStyles.caption2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
