import 'package:flutter/material.dart';

/// Kumpulan warna dalam aplikasi
class AppColor {
  //? Warna
  static Color primaryBackgroundApp = const Color(0xFFF2EEC8);
  static Color secondaryBackgroundApp = const Color(0xFFF0F5F9);
  static Color primaryColor = const Color(0xFF000AFF);
  static Color lightPrimaryColor = const Color(0xFF00A3FF);
  static Color secondaryColor = const Color(0xFF1C7849);
  static Color tertiaryColor = const Color(0xFFF56600);
  static Color netralColor = const Color(0xFFFEFEFD);
  static Color borderColor = const Color(0xFFF2CD00);
  static Color shadowColor = const Color(0xFF565656);
  static Color greyColor = const Color(0xFFC4C4C4);
  static Color iris = const Color(0xFF7879F1);
  static Color fuschia = const Color(0xFFF178B6);
  static Color lightIris = const Color(0xff713EDC);
  static Color lightFuschia = const Color(0xffC73781);
  // OLD COLOR
  static Color purpleHeader = const Color(0xff38364E);
  static Color blueButton = const Color(0xff3E85EF);
  static Color grayButton = const Color(0xFFB2BBC2);

  //? Font
  static Color blackFont = const Color(0xFF4D4D4D);
  static Color greyFont = const Color(0xFF9B9B9B);

  //? List warna
  static List<Color> primaryGradient = [
    primaryColor,
    lightPrimaryColor,
  ];
  static List<Color> irisGradient = [AppColor.iris, AppColor.lightIris];
  static List<Color> fuschiaGradient = [
    AppColor.fuschia,
    AppColor.lightFuschia
  ];

  //? Warna gradient
  static Gradient primaryLinearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: primaryGradient,
  );
  static Gradient irisLinearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: irisGradient,
  );
  static Gradient fuschiaLinearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: fuschiaGradient,
  );
  static Gradient primaryRadialGradient = RadialGradient(
    colors: primaryGradient,
    // center: const Alignment(-0.8, -0.6),
    radius: 2,
  );
}
