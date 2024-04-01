import 'package:flutter/material.dart';

// Flutter Hex Opacity Values
// 100% — FF
// 95% — F2
// 90% — E6
// 85% — D9
// 80% — CC
// 75% — BF
// 70% — B3
// 65% — A6
// 60% — 99
// 55% — 8C
// 50% — 80
// 45% — 73
// 40% — 66
// 35% — 59
// 30% — 4D
// 25% — 40
// 20% — 33
// 15% — 26
// 10% — 1A
// 5% — 0D
// 0% — 00
//#8185D3
class AppColors {
  static const mainColor = Color(0xFF8157D3);
  static const cyan = Color(0xFF2C7D7E);
  static const containerColor = Color(0xffF5F5F5);
  static const customWhite = Color(0xFFCDCDCD);
  static const customGray = Color(0xffa3a6aa);
  static const shadow = Color(0xFF53C2C4);
  static const blue = Color(0xFF1A3566);
  static const white = Color(0xFFF9F9F9);
  static const red = Color(0xFFA55252);
  static const orange = Color(0xffFFCEC2);
  static const yellow = Color(0xFFFFD500);
  static const gary = Color(0xFF6F6F6F);
  static const gray = Color(0xFFE2E2E2);
  static const border = Color(0xFF919EAC);
  static const profileBox1 = Color(0xFFFFECDD);
  static const profileBox2 = Color(0xFFFEF2F0);
  static const profileBox3 = Color(0xFFEBECEF);
  static const textColor = Color(0xff454545);
  static const canvasColor = Color(0xffE4E4E4);
  static const dividerColor = Color(0xffE4E4E4);
  static const appBarColor = Color(0xffFFFFFF);
  static  Color iconColor =  const Color(0xff454545);
  static const darkBackgroundColor = Color(0xff1A1A1A);
  static const darkContainerColor = Color(0xff454545);
  static  Color paragraphColor = Colors.black54;


  static BoxShadow boxShadow1 =   BoxShadow(

    color: Colors.grey[300]!,
    offset: const Offset(10, 10),
    blurRadius: 5,
    spreadRadius: 1,
  );
  static BoxShadow boxShadow2 =   const BoxShadow(

      color: Colors.white,
      offset: Offset(-4, -4),
      blurRadius: 5,
      spreadRadius: 1);




}