import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/extension/extension_size_screen.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/features/chat/presentation/screens/chat_inside_screen.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  height: 80,
                  width: context.isWidthScreen,
                  color: AppColors.primaryColor,
                  child: Center(
                      child: Text(
                    'Trò chuyện',
                    style: AppStyles.whiteText,
                  )),
                ),
                // const SizedBox(
                //   height: 100,
                // ),
                // Center(
                //         child: Lottie.asset(Assets.animation.notFound),
                //       ),
                Container(
                  //margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  height: context.isHeightScreen - 80.h,
                  decoration: BoxDecoration(
                      //  borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.whiteColor),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const ChatInsideScreen()));
                        },
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              vertical: 16),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.grey200Color))),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.grey200Color,
                              child: Icon(
                                Icons.person,
                                color: AppColors.grey700Color,
                              ),
                            ),
                            title: Text('Bác sĩ ${nameDoctor[index]}'),
                            subtitle: Text(titleDoctor[index]),
                          ),
                        ),
                      );
                    },
                    itemCount: 4,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
