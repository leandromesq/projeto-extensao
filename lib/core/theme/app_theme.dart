import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rachadinha/core/theme/app_colors.dart';
import 'package:rachadinha/core/utils/extensions/padding_extensions.dart';

ThemeData get appTheme {
//
  const colors = AppColors();

  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: colors.primarygreen,
      onPrimary: colors.light,
      secondary: colors.secondarygreen,
      onSecondary: colors.light,
      tertiary: colors.tertiarygreen,
      onTertiary: colors.light,
      primaryContainer: colors.darkgreen,
      onPrimaryContainer: colors.light,
      error: colors.tertiarygreen,
      onError: colors.light,
      surface: colors.primarygreen,
      onSurface: colors.black,
    ),
    textTheme: GoogleFonts.sairaCondensedTextTheme().copyWith(),
    extensions: const [
      AppColors(),
    ],
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: colors.grayText),
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colors.darkgreen,
      ),
      prefixIconColor: colors.darkgreen,
      suffixIconColor: colors.darkgreen,
      filled: true,
      fillColor: colors.light,
      border: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colors.darkgreen,
          width: 2.0,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: colors.primarygreen,
      size: 16,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(18.0)),
        backgroundColor: WidgetStateProperty.all(colors.light),
        foregroundColor: WidgetStateProperty.all(colors.light),
        iconColor: WidgetStateProperty.all(colors.darkgreen),
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
        backgroundColor: WidgetStateProperty.all(colors.tertiarygreen),
        foregroundColor: WidgetStateProperty.all(colors.darkgreen),
        padding: WidgetStateProperty.all(14.0.paddingVertical),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(2),
              ),
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      locale: const Locale('pt', 'BR'),
      rangePickerBackgroundColor: colors.error,
      dividerColor: colors.darkgreen,
      backgroundColor: colors.light,
      todayBackgroundColor: WidgetStateProperty.all(colors.darkgreen),
      todayForegroundColor: WidgetStateProperty.all(colors.light),
      headerForegroundColor: colors.light,
      headerBackgroundColor: colors.darkgreen,
      dayStyle: TextStyle(color: colors.darkgreen),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(colors.darkgreen),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(colors.darkgreen),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: colors.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    drawerTheme: DrawerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: colors.primarygreen,
    ),
  );
}
