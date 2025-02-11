import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  //
  final Color blackBackground;

  final Color grayStrong;
  final Color grayMedium;
  final Color grayLight;
  final Color grayText;
  final Color grayHint;
  final Color white;
  final Color black;
  final Color error;

  final Color primarygreen;
  final Color secondarygreen;
  final Color tertiarygreen;
  final Color darkgreen;
  final Color light;

  const AppColors({
    this.blackBackground = const Color(0xFF18191B),
    this.grayStrong = const Color(0xFF28292B),
    this.grayMedium = const Color(0xFF36373B),
    this.grayLight = const Color(0xFF898B8C),
    this.grayText = const Color(0xFF8E8E93),
    this.grayHint = const Color(0xFF898B8C),
    this.white = const Color(0xffffffff),
    this.black = const Color(0xff000000),
    this.primarygreen = const Color(0xff83CC61),
    this.secondarygreen = const Color(0xffB7E576),
    this.tertiarygreen = const Color(0xffEEFCA9),
    this.darkgreen = const Color(0xff5A9E7C),
    this.light = const Color(0xffFBF6EE),
    this.error = const Color(0xffE07B67),
  });

  @override
  AppColors copyWith({
    Color? blackBackground,
    Color? grayStrong,
    Color? grayMedium,
    Color? grayLight,
    Color? grayText,
    Color? grayHint,
    Color? white,
    Color? black,
    Color? primarygreen,
    Color? secondarygreen,
    Color? tertiarygreen,
    Color? darkgreen,
    Color? light,
    Color? error,
  }) {
    return AppColors(
      blackBackground: blackBackground ?? this.blackBackground,
      grayStrong: grayStrong ?? this.grayStrong,
      grayMedium: grayMedium ?? this.grayMedium,
      grayLight: grayLight ?? this.grayLight,
      grayText: grayText ?? this.grayText,
      grayHint: grayHint ?? this.grayHint,
      white: white ?? this.white,
      black: black ?? this.black,
      primarygreen: primarygreen ?? this.primarygreen,
      secondarygreen: secondarygreen ?? this.secondarygreen,
      tertiarygreen: tertiarygreen ?? this.tertiarygreen,
      darkgreen: darkgreen ?? this.darkgreen,
      light: light ?? this.light,
      error: error ?? this.error,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    //
    if (other is! AppColors) return this;

    return AppColors(
      blackBackground: Color.lerp(blackBackground, other.blackBackground, t)!,
      grayStrong: Color.lerp(grayStrong, other.grayStrong, t)!,
      grayMedium: Color.lerp(grayMedium, other.grayMedium, t)!,
      grayLight: Color.lerp(grayLight, other.grayLight, t)!,
      grayText: Color.lerp(grayText, other.grayText, t)!,
      grayHint: Color.lerp(grayHint, other.grayHint, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      primarygreen: Color.lerp(primarygreen, other.primarygreen, t)!,
      secondarygreen: Color.lerp(secondarygreen, other.secondarygreen, t)!,
      tertiarygreen: Color.lerp(tertiarygreen, other.tertiarygreen, t)!,
      darkgreen: Color.lerp(darkgreen, other.darkgreen, t)!,
      light: Color.lerp(light, other.light, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
