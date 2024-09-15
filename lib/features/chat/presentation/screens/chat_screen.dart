import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:doctor_book/features/chat/presentation/screens/chat_inside_screen.dart';
import 'package:doctor_book/features/chat/presentation/screens/choose_doctor_chat_screen.dart';
import 'package:doctor_book/features/choose_doctor/data/models/doctor_model.dart';
import 'package:doctor_book/features/choose_doctor/presentation/blocs/get_doctor/get_doctor_bloc.dart';
import 'package:doctor_book/features/choose_doctor/presentation/screens/info_doctor_screen.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

List<String> nameDoctor = ['Hải', 'Lâm', 'Hùng', 'Mai'];
List<String> titleDoctor = [
  'Xin chào tôi có thể giúp gì cho bạn',
  'Xin chào! Chúc bạn một ngày mới tốt lành',
  'Chào bạn tôi giúp gì được cho bạn',
  'Bạn cần sự giúp đỡ gì từ tôi'
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetDoctorBloc>().add(GetDoctorToFirebase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Trò chuyện với bác sĩ',
          style: AppStyles.whiteText,
        ),
      ),
      body: Container(
        width: context.isWidthScreen,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            BlocBuilder<GetDoctorBloc, GetDoctorState>(
              builder: (context, state) {
                if (state is GetDoctorSuccess) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: ListView.separated(
                        itemCount: state.listDoctor.length,
                        itemBuilder: (context, index) {
                          final doctor = state.listDoctor[index];
                          return Slidable(
                            key: Key(index.toString()),
                            endActionPane: ActionPane(
                              dragDismissible: false,
                              extentRatio: 0.25,
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () {}),
                              children: [
                                SlidableAction(
                                  borderRadius: BorderRadius.circular(20.r),
                                  onPressed: (context) {},
                                  backgroundColor: AppColors.redColor,
                                  foregroundColor: AppColors.whiteColor,
                                  icon: Icons.delete,
                                  label: 'Xoá',
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => InfoDoctorScreen(
                                          doctor: doctor,
                                        )));
                              },
                              child: Padding(
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
                                              radius:
                                                  BorderRadius.circular(100.r),
                                              imagePath: doctor.profilePicture,
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
                                                          BorderRadius.circular(
                                                              12.r),
                                                      color: AppColors
                                                          .grey200Color),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        Text(doctor.department),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
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
                                        width: 220.w,
                                        child: CustomElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ChatInsideScreen(
                                                            doctor: doctor)));
                                          },
                                          textBtn: 'Trò chuyện với bác sĩ',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
