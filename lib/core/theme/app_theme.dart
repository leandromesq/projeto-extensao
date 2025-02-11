import 'package:flutter/material.dart';
import 'package:rachadinha/core/theme/app_colors.dart';
import 'package:rachadinha/core/theme/app_text_style.dart';
import 'package:rachadinha/core/utils/extensions/padding_extensions.dart';

ThemeData get appTheme {
//
  const colors = AppColors();
  const textStyles = AppTextStyles();

  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: colors.grayStrong,
      onPrimary: colors.grayMedium,
      secondary: colors.red,
      onSecondary: colors.red,
      error: colors.red,
      onError: colors.red,
      surface: const Color(0xffffffff),
      onSurface: colors.blackBackground,
    ),
    textTheme: TextTheme(
      headlineLarge: textStyles.headlineLarge.copyWith(
        color: const Color(0xff222222),
      ),
      headlineSmall: textStyles.headlineSmall.copyWith(
        color: const Color(0xff222222),
      ),
      bodyMedium: textStyles.bodyMedium.copyWith(
        color: const Color(0xff000000),
      ),
      bodySmall: textStyles.bodySmall.copyWith(
        color: const Color(0xff222222),
      ),
      labelLarge: textStyles.labelLarge.copyWith(
        color: const Color(0xff000000),
      ),
      labelMedium: textStyles.labelMedium.copyWith(
        color: const Color(0xff000000),
      ),
      labelSmall: textStyles.labelSmall.copyWith(
        color: const Color(0xff000000),
      ),
      displayLarge: textStyles.displayLarge.copyWith(
        color: const Color(0xff000000),
      ),
    ),
    extensions: const [
      AppColors(),
      AppTextStyles(),
    ],
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.blue),
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xffC7C7C7),
      ),
      suffixIconColor: const Color(0xff939AA5),
      filled: true,
      fillColor: const Color(0xffF3F3F3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xffC7C7C7),
          width: 2.0,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.blue,
      size: 16,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(18.0)),
        backgroundColor: WidgetStateProperty.all(const Color(0xffC22445)),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        overlayColor: WidgetStateProperty.all(
          Colors.white.withValues(alpha: .2),
        ),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)),
        backgroundColor: WidgetStateProperty.all(colors.red),
        padding: WidgetStateProperty.all(14.0.paddingVertical),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    ),
  );
}
