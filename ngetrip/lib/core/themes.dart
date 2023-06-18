import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngetrip/core/colors.dart';

TextStyle titleBold14 =
    GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 14);
TextStyle titleBold16 =
    GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 16);
TextStyle titleBold18 =
    GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 18);
TextStyle titleBold22 =
    GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 22);
TextStyle titleBold24 =
    GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 24);

TextStyle text10 =
    GoogleFonts.montserrat(color: AppColor.blackFont, fontSize: 10);
TextStyle text12 =
    GoogleFonts.montserrat(color: AppColor.blackFont, fontSize: 12);
TextStyle text14 =
    GoogleFonts.montserrat(color: AppColor.blackFont, fontSize: 14);
TextStyle text16 =
    GoogleFonts.montserrat(color: AppColor.blackFont, fontSize: 16);
TextStyle text18 =
    GoogleFonts.montserrat(color: AppColor.blackFont, fontSize: 18);

TextStyle textGray12 =
    GoogleFonts.montserrat(color: AppColor.greyFont, fontSize: 12);
TextStyle textGray14 =
    GoogleFonts.montserrat(color: AppColor.greyFont, fontSize: 14);
TextStyle textGray16 =
    GoogleFonts.montserrat(color: AppColor.greyFont, fontSize: 16);
TextStyle textGray18 =
    GoogleFonts.montserrat(color: AppColor.greyFont, fontSize: 18);

TextStyle textBold12 = GoogleFonts.montserrat(
    color: AppColor.blackFont, fontSize: 12, fontWeight: FontWeight.bold);
TextStyle textBold14 = GoogleFonts.montserrat(
    color: AppColor.blackFont, fontSize: 14, fontWeight: FontWeight.bold);
TextStyle textBold16 = GoogleFonts.montserrat(
    color: AppColor.blackFont, fontSize: 16, fontWeight: FontWeight.bold);
TextStyle textBold18 = GoogleFonts.montserrat(
    color: AppColor.blackFont, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle textWhite12 =
    GoogleFonts.montserrat(color: Colors.white, fontSize: 12);
TextStyle textWhite14 =
    GoogleFonts.montserrat(color: Colors.white, fontSize: 14);
TextStyle textWhite16 =
    GoogleFonts.montserrat(color: Colors.white, fontSize: 16);
TextStyle textWhite18 =
    GoogleFonts.montserrat(color: Colors.white, fontSize: 18);

TextStyle textWhiteBold12 = GoogleFonts.montserrat(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12);
TextStyle textWhiteBold14 = GoogleFonts.montserrat(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
TextStyle textWhiteBold16 = GoogleFonts.montserrat(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
TextStyle textWhiteBold18 = GoogleFonts.montserrat(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);
TextStyle textWhiteBold20 = GoogleFonts.montserrat(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);

TextStyle textPrimary14 =
    GoogleFonts.montserrat(color: AppColor.tertiaryColor, fontSize: 14);
TextStyle textPrimaryBold12 = GoogleFonts.montserrat(
    color: AppColor.primaryColor, fontSize: 12, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold14 = GoogleFonts.montserrat(
    color: AppColor.primaryColor, fontSize: 14, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold16 = GoogleFonts.montserrat(
    color: AppColor.primaryColor, fontSize: 16, fontWeight: FontWeight.bold);

TextStyle textAppbarStyle = GoogleFonts.montserrat(
    fontSize: 18, fontWeight: FontWeight.w800, color: AppColor.blackFont);

/// Kustumisasi
TextStyle text(double size) =>
    GoogleFonts.montserrat(color: AppColor.blackFont, fontSize: size);
TextStyle textBold(double size) => GoogleFonts.montserrat(
    color: AppColor.blackFont, fontWeight: FontWeight.bold, fontSize: size);
TextStyle textTitle(double size) => GoogleFonts.montserrat(
    color: AppColor.blackFont, fontWeight: FontWeight.w800, fontSize: size);
TextStyle textWhite(double size) =>
    GoogleFonts.montserrat(color: Colors.white, fontSize: size);

List<BoxShadow> get appShadowSmooth => [
      BoxShadow(
        blurRadius: 8,
        offset: const Offset(3, 3),
        color: AppColor.shadowColor.withOpacity(.15),
      ),
    ];
