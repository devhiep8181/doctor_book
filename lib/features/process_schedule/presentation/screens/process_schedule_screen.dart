import 'dart:developer';

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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:month_year_picker/month_year_picker.dart';

class ProcessScheduleScreen extends StatefulWidget {
  const ProcessScheduleScreen({
    super.key,
    required this.doctor,
  });
  final Doctor doctor;
  @override
  State<ProcessScheduleScreen> createState() => _ProcessScheduleScreenState();
}

class _ProcessScheduleScreenState extends State<ProcessScheduleScreen>
    with TickerProviderStateMixin {
  DateTime? chooseMonth;
  int? amountOfMonth;
  late final TabController _tabController;
  final listShift = ProcessDatetime.generateShifts(
      '17:00', '19:00', const Duration(minutes: 15));

  @override
  void initState() {
    super.initState();
    context.read<InfoPatientBloc>().add(GetInfoPatientEvent());
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200Color,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Đặt lịch khám',
          style: AppStyles.whiteText,
        ),
      ),
      body: Stack(
        children: [
          // CustomImageView(
          //   imagePath: Assets.images.background.path,
          // ),
          SingleChildScrollView(
            child: Column(
              children: [
                ProcessWidget(),
                InfoDoctorWidget(
                  doctor: widget.doctor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                      ),
                      Text('Đặt lịch khám cho:'),
                    ],
                  ),
                ),
                InfoPaitent(),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                      ),
                      Text('Chọn ngày khám:'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          final selected = await showMonthYearPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2050),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor:
                                      Colors.teal, // Màu tiêu đề và màu nhấn
                                  //accentColor: Colors.orange, // Màu chọn
                                  dialogBackgroundColor:
                                      Colors.blueGrey[50], // Màu nền

                                  colorScheme: const ColorScheme.light(
                                    primary: Colors.teal, // Màu chủ đạo
                                    onSurface:
                                        Colors.teal, // Màu của tháng đã chọn
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (selected != null) {
                            setState(() {
                              chooseMonth = selected;
                              log('SELECTED MONTH================> $selected ');
                              log('SELECTED MONTH Now================> ${DateTime.now()} ');
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey200Color,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(ProcessDatetime.formatDateToMonthYear(
                                    chooseMonth ?? DateTime.now())),
                                const Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<ProcessScheduleBloc, ProcessScheduleState>(
                        builder: (context, state) {
                          return SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final dateTime = chooseMonth
                                          ?.add(Duration(days: index)) ??
                                      DateTime.now().add(Duration(days: index));
                                  amountOfMonth =
                                      ProcessDatetime.amountDayInMonth(
                                          chooseMonth ?? DateTime.now());
                                  log('Amount of Month: ==========> $amountOfMonth');
                                  return InkWell(
                                    onTap: () {},
                                    child: ChooseDateWidget(
                                        listShift: listShift,
                                        dateTime: dateTime,
                                        dayOfWeek:
                                            ProcessDatetime.dayOfWeekToString(
                                                dateTime),
                                        day: dateTime.day.toString()),
                                  );
                                },
                                itemCount: amountOfMonth,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                      ),
                      Text('Chọn giờ khám:'),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        TabBar(controller: _tabController, tabs: const [
                          Tab(text: 'Buổi sáng'),
                          Tab(text: 'Buổi chiều'),
                        ]),
                        Container(
                            height: 150.h,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  const Card(
                                    margin: EdgeInsets.all(16.0),
                                    child: Center(
                                        child: Text('Không có lịch làm việc')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10.0,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 4),
                                      itemCount:
                                          listShift.length, // Tổng số phần tử
                                      itemBuilder: (context, index) {
                                        return BlocBuilder<ProcessScheduleBloc,
                                            ProcessScheduleState>(
                                          builder: (context, state) {
                                            return InkWell(
                                              onTap: () {
                                                context
                                                    .read<ProcessScheduleBloc>()
                                                    .add(ChooseTimeEvent(
                                                        chooseTime:
                                                            listShift[index]));
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: state.timeChoose ==
                                                              listShift[index]
                                                          ? AppColors.greenColor
                                                          : AppColors
                                                              .grey200Color,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Center(
                                                      child: Text(
                                                          listShift[index]))),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ])),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<ProcessScheduleBloc, ProcessScheduleState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        onPressed: () {
                          if (state.dayChoose.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Vui lòng chọn ngày khám');
                          } else if (state.timeChoose.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Vui lòng chọn thời gian khám');
                          } else {
                            context.goNamed(confirmSchedule,
                                extra: widget.doctor);
                          }
                        },
                        textBtn: 'Tiếp tục',
                      );
                    },
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

class ChooseDateWidget extends StatefulWidget {
  const ChooseDateWidget({
    super.key,
    required this.dayOfWeek,
    required this.day,
    required this.dateTime,
    required this.listShift,
  });

  final String dayOfWeek;
  final String day;
  final DateTime dateTime;
  final List<String> listShift;

  @override
  State<ChooseDateWidget> createState() => _ChooseDateWidgetState();
}

class _ChooseDateWidgetState extends State<ChooseDateWidget> {
  //final ValueNotifier<bool> _changeColorDay = ValueNotifier<bool>(false);
  bool _changeColorDay = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProcessScheduleBloc, ProcessScheduleState>(
      listener: (context, state) {
        if (state.dayChoose == ProcessDatetime.formatDate(widget.dateTime)) {
          _changeColorDay = true;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              widget.dayOfWeek,
              style: AppStyles.caption2,
            ),
            const SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () {
                context.read<ProcessScheduleBloc>().add(ChooseDateEvent(
                    chooseDate: ProcessDatetime.formatDate(widget.dateTime)));
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: _changeColorDay
                    ? AppColors.greenColor
                    : AppColors.grey200Color,
                child: Text(widget.day),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '${widget.listShift.length} slots',
                  style: AppStyles.whiteText
                      .copyWith(fontSize: 10, fontWeight: FontWeight.w300),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoPaitent extends StatelessWidget {
  const InfoPaitent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: BlocBuilder<InfoPatientBloc, InfoPatientState>(
        builder: (context, state) {
          if (state.infoPatientStatus == InfoPatientStatus.success) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Họ và tên'),
                      Text(state.patientModel.fullName),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Giới tính'),
                      Text(state.patientModel.gender),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ngày sinh'),
                      Text(state.patientModel.birthDay),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Điện thoại'),
                      Text(state.patientModel.phoneNumber),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.grey200Color,
            ),
          );
        },
      ),
    );
  }
}

class InfoDoctorWidget extends StatelessWidget {
  const InfoDoctorWidget({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColors.grey200Color,
                child: CustomImageView(
                  width: 60,
                  radius: BorderRadius.circular(100.r),
                  imagePath: doctor.profilePicture,
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.qualification),
                Text(
                  doctor.fullName,
                  style: AppStyles.caption1,
                ),
                Text('Chuyên khoa: ${doctor.department}')
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProcessWidget extends StatelessWidget {
  const ProcessWidget({
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
                backgroundColor: AppColors.grey400Color,
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
