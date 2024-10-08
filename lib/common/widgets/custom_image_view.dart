// Flutter imports:

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:doctor_book/common/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/image_constants.dart';

// Project imports:

// ignore: must_be_immutable
class CustomImageView extends StatelessWidget {
  CustomImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.placeHolder = 'assets/images/placeholder.png',
    this.alignment,
    this.onTap,
    this.margin,
    this.radius,
    this.border,
  });
  String? imagePath;
  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  Widget _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath?.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath ?? ImageConstant.imagePlaceHolder,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              color: color,
            ),
          );
        case ImageType.file:
          return Image.file(
            File(
              imagePath ?? ImageConstant.imagePlaceHolder,
            ),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        case ImageType.network:
          return CachedNetworkImage(
            imageUrl: imagePath!,
            height: height,
            width: width,
            fit: fit,
            color: color,
            placeholder: (context, url) => SizedBox(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: AppColors.grey200Color,
                backgroundColor: AppColors.grey100Color,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              placeHolder,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
            ),
          );
        case ImageType.png:
        case ImageType.unknow:
          return Image.asset(
            imagePath ?? ImageConstant.imagePlaceHolder,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        case null:
          return const SizedBox();
        //TODO: lý do không dùng default: https://dart.dev/tools/linter-rules/no_default_cases
      }
    }
    return const SizedBox();
  }
}

//TODO: cho gọn vào 1 file
extension ImgeTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('/')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknow }
