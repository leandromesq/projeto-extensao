import 'package:flutter/material.dart';

import 'app_colors.dart';

export 'app_theme.dart';

extension ThemeDataColorsExtension on ThemeData {
  AppColors get colors => extension<AppColors>()!;
}
