import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:doctor_book/common/widgets/custom_image_view.dart';
import 'package:doctor_book/gen/assets.gen.dart';
import 'package:doctor_book/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      context.pushReplacementNamed(signin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: Assets.images.logo,
          ),
          Text(
            'WECARE',
            style: AppStyles.titleAutio,
          )
        ],
      ),
    );
  }
}
