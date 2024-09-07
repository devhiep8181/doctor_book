import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';

import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/common/widgets/custom_text_form_filed.dart';
import 'package:doctor_book/features/home/data/datasource/department_data.dart';
import 'package:doctor_book/features/home/presentation/blocs/search/search_bloc.dart';
import 'package:doctor_book/features/home/presentation/screens/all_department_screen.dart';
import 'package:doctor_book/features/home/presentation/screens/search_doctor_screen.dart';
import 'package:doctor_book/features/home/presentation/widgets/pageView_home_widget.dart';
import 'package:doctor_book/features/search_doctor/presentation/screens/search_doctor_screen.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../base/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(SearchInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomImageView(
            imagePath: Assets.images.background.path,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 140.h,
                  decoration: BoxDecoration(
                      gradient: AppColors.linearGradient,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.r),
                          bottomRight: Radius.circular(20.r))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.whiteColor,
                            radius: 20,
                            child: const Icon(Icons.person),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  titleAppBarHome(),
                                  style: AppStyles.whiteText.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(UserSingleton().name,
                                    style: AppStyles.whiteText.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                color: AppColors.whiteColor,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const SearchDoctorScreen()));
                          },
                          child: Container(
                            width: context.isWidthScreen,
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Tìm kiếm bác sĩ'),
                            ),
                          )),
                    ],
                  ),
                ),
                const PageViewHomeWidget(),
                ServiceWidget(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Khám theo khoa',
                            style: AppStyles.body22
                                .copyWith(color: AppColors.grey700Color),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Xem tất cả',
                                style: AppStyles.subtitle3
                                    .copyWith(color: AppColors.blueVioletColor),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16)
                            .copyWith(top: 16),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: 6, // Tổng số phần tử
                          itemBuilder: (context, index) {
                            return BlocListener<SearchBloc, SearchState>(
                              listener: (context, state) {
                                if (state.message == 'search suceess') {}
                              },
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          const AllDepartmentScreen()));
                                  context.read<SearchBloc>().add(
                                      SearchDepartment(
                                          textSeatch: department[index]));
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 25,
                                        backgroundColor: AppColors.grey200Color,
                                        child: CustomImageView(
                                          imagePath: imagePath[index],
                                        )),
                                    Text(department[index])
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String titleAppBarHome() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 'Buổi sáng hứng khởi!';
    } else if (hour >= 12 && hour <= 18) {
      return 'Buổi chiều rực rỡ!';
    } else {
      return 'Buổi tối tốt lành!';
    }
  }
}

List<String> imagePath = [
  Assets.images.love9062515.path,
  Assets.images.medicalReport8125782.path,
  Assets.images.obstetrics12106197.path,
  Assets.images.medicalReport8125782.path,
  Assets.images.love9062515.path,
  Assets.images.obstetrics12106197.path,
];

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      //height: 200,
      decoration: BoxDecoration(
        //color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Dịch vụ',
              style: AppStyles.body22.copyWith(color: AppColors.grey700Color),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => context.goNamed(chooseDoctor),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppColors.blueAccentColor,
                      child: Icon(
                        Icons.domain,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Đặt khám \n bác sĩ',
                      textAlign: TextAlign.center,
                      style: AppStyles.caption1
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  NotificationService().showNotification(
                    0,
                    "Chưa có kết quả khám",
                    "Bác sĩ sẽ phản hồi bạn sớm nhất",
                  );
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppColors.orangeColor,
                      child: Icon(
                        Icons.work,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Xem kết \n quả khám',
                      textAlign: TextAlign.center,
                      style: AppStyles.caption1
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  context.goNamed(chat);
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppColors.pinkColor,
                      child: Icon(
                        Icons.chat,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Trò chuyện \n với bác sĩ',
                      textAlign: TextAlign.center,
                      style: AppStyles.caption1
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
