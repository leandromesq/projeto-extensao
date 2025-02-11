import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

export 'app_theme.dart';

extension ThemeDataColorsExtension on ThemeData {
  AppColors get colors => extension<AppColors>()!;
}

extension ThemeDataTextsExtension on ThemeData {
  AppTextStyles get textStyles => extension<AppTextStyles>()!;
}
