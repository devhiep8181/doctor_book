/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAnimationGen {
  const $AssetsAnimationGen();

  /// File path: assets/animation/not_found.json
  String get notFound => 'assets/animation/not_found.json';

  /// List of all assets
  List<String> get values => [notFound];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/baby_0203m.svg
  String get baby0203m => 'assets/icons/baby_0203m.svg';

  /// File path: assets/icons/child_cognition.svg
  String get childCognition => 'assets/icons/child_cognition.svg';

  /// File path: assets/icons/colon.svg
  String get colon => 'assets/icons/colon.svg';

  /// File path: assets/icons/eye.svg
  String get eye => 'assets/icons/eye.svg';

  /// File path: assets/icons/heart_organ.svg
  String get heartOrgan => 'assets/icons/heart_organ.svg';

  /// File path: assets/icons/hospitalized.svg
  String get hospitalized => 'assets/icons/hospitalized.svg';

  /// File path: assets/icons/kidneys.svg
  String get kidneys => 'assets/icons/kidneys.svg';

  /// File path: assets/icons/leg.svg
  String get leg => 'assets/icons/leg.svg';

  /// File path: assets/icons/lungs.svg
  String get lungs => 'assets/icons/lungs.svg';

  /// File path: assets/icons/speech_language_therapy.svg
  String get speechLanguageTherapy =>
      'assets/icons/speech_language_therapy.svg';

  /// File path: assets/icons/tooth.svg
  String get tooth => 'assets/icons/tooth.svg';

  /// File path: assets/icons/xray.svg
  String get xray => 'assets/icons/xray.svg';

  /// List of all assets
  List<String> get values => [
        baby0203m,
        childCognition,
        colon,
        eye,
        heartOrgan,
        hospitalized,
        kidneys,
        leg,
        lungs,
        speechLanguageTherapy,
        tooth,
        xray
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/images/background.png');

  /// File path: assets/images/logo.svg
  String get logo => 'assets/images/logo.svg';

  /// File path: assets/images/love_9062515.png
  AssetGenImage get love9062515 =>
      const AssetGenImage('assets/images/love_9062515.png');

  /// File path: assets/images/mask.png
  AssetGenImage get mask => const AssetGenImage('assets/images/mask.png');

  /// File path: assets/images/medical-report_8125782.png
  AssetGenImage get medicalReport8125782 =>
      const AssetGenImage('assets/images/medical-report_8125782.png');

  /// File path: assets/images/obstetrics_12106197.png
  AssetGenImage get obstetrics12106197 =>
      const AssetGenImage('assets/images/obstetrics_12106197.png');

  /// File path: assets/images/pageViewHome1.jpg
  AssetGenImage get pageViewHome1 =>
      const AssetGenImage('assets/images/pageViewHome1.jpg');

  /// File path: assets/images/pageViewHome2.jpg
  AssetGenImage get pageViewHome2 =>
      const AssetGenImage('assets/images/pageViewHome2.jpg');

  /// File path: assets/images/pageViewHome3.jpg
  AssetGenImage get pageViewHome3 =>
      const AssetGenImage('assets/images/pageViewHome3.jpg');

  /// File path: assets/images/placeholder.png
  AssetGenImage get placeholder =>
      const AssetGenImage('assets/images/placeholder.png');

  /// File path: assets/images/surgery-room.png
  AssetGenImage get surgeryRoom =>
      const AssetGenImage('assets/images/surgery-room.png');

  /// File path: assets/images/x-ray.png
  AssetGenImage get xRay => const AssetGenImage('assets/images/x-ray.png');

  /// List of all assets
  List<dynamic> get values => [
        background,
        logo,
        love9062515,
        mask,
        medicalReport8125782,
        obstetrics12106197,
        pageViewHome1,
        pageViewHome2,
        pageViewHome3,
        placeholder,
        surgeryRoom,
        xRay
      ];
}

class Assets {
  Assets._();

  static const $AssetsAnimationGen animation = $AssetsAnimationGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
