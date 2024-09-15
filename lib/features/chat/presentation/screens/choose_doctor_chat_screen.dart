import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:doctor_book/common/widgets/custom_elevated_button.dart';
import 'package:doctor_book/features/chat/presentation/screens/chat_inside_screen.dart';
import 'package:doctor_book/features/choose_doctor/presentation/blocs/get_doctor/get_doctor_bloc.dart';
import 'package:doctor_book/features/choose_doctor/presentation/screens/info_doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/custom_image_view.dart';

class ChooseDoctorChatScreen extends StatefulWidget {
  const ChooseDoctorChatScreen({super.key});

  @override
  State<ChooseDoctorChatScreen> createState() => _ChooseDoctorChatScreenState();
}

class _ChooseDoctorChatScreenState extends State<ChooseDoctorChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetDoctorBloc>().add(GetDoctorToFirebase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
            )),
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Danh sách bác sĩ',
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
                          return InkWell(
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
                                                    color:
                                                        AppColors.grey200Color),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
