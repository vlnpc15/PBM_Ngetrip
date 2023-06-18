import 'package:flutter/material.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:ngetrip/core/themes.dart';

/// Mask untuk membuat widget memiliki warna gradient secara linear
class LinearGradientMask extends StatelessWidget {
  const LinearGradientMask({
    Key? key,
    required this.child,
    this.colors = const [Color(0xffFF844B), Color(0xffFA5622)],
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  }) : super(key: key);

  /// Widget bisa beruba icon
  final Widget? child;

  /// Daftar warna gradient yang diberikan
  final List<Color> colors;

  /// Posisi awal gradient
  final AlignmentGeometry begin;

  /// Posisi akhir gradient
  final AlignmentGeometry end;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: begin,
        end: end,
        colors: colors,
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}

/// Teks berwarna gradient secara linear
class TextGradient extends StatelessWidget {
  const TextGradient(
    this.text, {
    Key? key,
    this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.textStyle,
  }) : super(key: key);

  /// Teks
  final String? text;

  /// TextStyle
  final TextStyle? textStyle;

  /// Daftar warna gradient yang diberikan
  final List<Color>? colors;

  /// Posisi awal gradient
  final AlignmentGeometry? begin;

  /// Posisi akhir gradient
  final AlignmentGeometry? end;

  @override
  Widget build(BuildContext context) {
    return LinearGradientMask(
      colors: colors ?? AppColor.primaryGradient,
      begin: begin!,
      end: end!,
      child: Text(
        text!,
        style: textStyle?.copyWith(color: AppColor.secondaryBackgroundApp) ??
            textWhite14,
      ),
    );
  }
}

/// Icon berwarna gradient secara linear
class IconLinearGradient extends StatelessWidget {
  const IconLinearGradient(
    this.icon, {
    Key? key,
    this.colors,
    this.begin,
    this.end,
    this.semanticLabel,
    this.size,
    this.textDirection,
  }) : super(key: key);

  /// Daftar warna gradient yang diberikan
  final List<Color>? colors;

  /// Posisi awal gradient
  final AlignmentGeometry? begin;

  /// Posisi akhir gradient
  final AlignmentGeometry? end;

  /// Jenis icon
  final IconData? icon;

  /// Semantic label untuk icon
  final String? semanticLabel;

  /// Ukuran icon
  final double? size;

  /// Arah teks pada icon
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return LinearGradientMask(
      colors: colors ?? AppColor.primaryGradient,
      begin: begin ?? Alignment.topLeft,
      end: end ?? Alignment.bottomRight,
      child: Icon(
        icon,
        color: AppColor.secondaryBackgroundApp,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextGradient(
      'Ngetrip',
      textStyle: textBold18.copyWith(fontSize: 30),
    );
  }
}
