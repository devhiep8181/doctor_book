import 'dart:async';

import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewHomeWidget extends StatefulWidget {
  const PageViewHomeWidget({super.key});

  @override
  State<PageViewHomeWidget> createState() => _PageViewHomeWidgetState();
}

class _PageViewHomeWidgetState extends State<PageViewHomeWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return CustomImageView(
                radius: BorderRadius.circular(20.r),
                imagePath: imageHome[index],
              );
            },
            itemCount: 3,
          )),
    );
  }
}

List<String> imageHome = [
  Assets.images.pageViewHome1.path,
  Assets.images.pageViewHome2.path,
  Assets.images.pageViewHome3.path,
];
