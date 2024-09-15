import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_book/base/base_remote_data.dart';
import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/features/choose_doctor/data/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/app_theme/app_colors.dart';

class ChatInsideScreen extends StatefulWidget {
  const ChatInsideScreen({super.key, required this.doctor});

  final Doctor doctor;
  @override
  State<ChatInsideScreen> createState() => _ChatInsideScreenState();
}

class _ChatInsideScreenState extends State<ChatInsideScreen> {
  final TextEditingController _messageController = TextEditingController();
  final baseRemoteData = BaseRemoteData();

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await baseRemoteData.sendMessage(
          widget.doctor.email, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.primaryColor,
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          centerTitle: true,
          title: Text(
            'Bác sĩ ${widget.doctor.fullName}',
            style: AppStyles.whiteText,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildUserInput(),
            SizedBox(
              height: 6.h,
            ),
          ],
        ));
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: baseRemoteData.getMessage(widget.doctor.email),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  //TODO: CODE not ui
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['emailPaitent'] == UserSingleton().email;

    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
                color: AppColors.blueColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24.r)),
            child: Text(data['content'])),
      ],
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: _messageController,
          decoration: InputDecoration(
            hintText: 'Vui lòng nhập tin nhắn',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.grey200Color)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.grey200Color)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.red600Color)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.red600Color)),
          ),
        )),
        IconButton(
            onPressed: _sendMessage, icon: const Icon(Icons.arrow_upward))
      ],
    );
  }
}
