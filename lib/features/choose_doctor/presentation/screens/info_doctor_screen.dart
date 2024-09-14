import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/features/choose_doctor/data/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoDoctorScreen extends StatelessWidget {
  const InfoDoctorScreen({super.key, required this.doctor});

  final Doctor doctor;

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
          'Thông tin bác sĩ',
          style: AppStyles.whiteText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 40.r,
                    backgroundColor: AppColors.grey200Color,
                    child: CustomImageView(
                      width: 80,
                      radius: BorderRadius.circular(100.r),
                      imagePath: doctor.profilePicture,
                      fit: BoxFit.fill,
                    )),
                SizedBox(
                  width: 24.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.qualification,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(doctor.fullName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.sp)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('${doctor.yearsOfExperience} năm kinh nghiệm'),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.grey200Color),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(doctor.department),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                child: Text(
                  'Thông tin bác sĩ',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
