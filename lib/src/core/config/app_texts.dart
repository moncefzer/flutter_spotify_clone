import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static TextTheme get _interTextTheme => GoogleFonts.poppinsTextTheme();

  static final _blackheadlineSmall = _interTextTheme.headlineSmall?.copyWith(
    fontSize: 24.sp,
    color: Colors.black,
  );
  static final _blacktitleLarge = _interTextTheme.titleLarge?.copyWith(
    fontSize: 22.sp,
    color: Colors.black,
  );
  static final _blacktitleMedium = _interTextTheme.titleMedium?.copyWith(
    fontSize: 16.sp,
    color: Colors.black,
  );
  static final _blacktitleSmall = _interTextTheme.titleSmall?.copyWith(
    fontSize: 14.sp,
    color: Colors.black,
  );
  static final _blackbodyLarge = _interTextTheme.bodyLarge?.copyWith(
    fontSize: 16.sp,
    color: Colors.black,
  );
  static final _blackbodyMedium = _interTextTheme.bodyMedium?.copyWith(
    fontSize: 14.sp,
    color: Colors.black,
  );
  static final _blackbodySmall = _interTextTheme.bodySmall?.copyWith(
    fontSize: 12.sp,
    color: Colors.black,
  );
  static final _blacklabelLarge = _interTextTheme.labelLarge?.copyWith(
    fontSize: 14.sp,
    color: Colors.black,
  );
  static final _blacklabelMedium = _interTextTheme.labelMedium?.copyWith(
    fontSize: 12.sp,
    color: Colors.black,
  );
  static final _blacklabelSmall = _interTextTheme.labelSmall?.copyWith(
    fontSize: 11.sp,
    color: Colors.black,
  );

  static get lightThemeText => TextTheme(
        headlineSmall: _blackheadlineSmall,
        titleLarge: _blacktitleLarge,
        titleMedium: _blacktitleMedium,
        titleSmall: _blacktitleSmall,
        bodyLarge: _blackbodyLarge,
        bodyMedium: _blackbodyMedium,
        bodySmall: _blackbodySmall,
        labelLarge: _blacklabelLarge,
        labelMedium: _blacklabelMedium,
        labelSmall: _blacklabelSmall,
      );

  static get darkThemeText => TextTheme(
        headlineSmall: _blackheadlineSmall?.copyWith(color: Colors.white),
        titleLarge: _blacktitleLarge?.copyWith(color: Colors.white),
        titleMedium: _blacktitleMedium?.copyWith(color: Colors.white),
        titleSmall: _blacktitleSmall?.copyWith(color: Colors.white),
        bodyLarge: _blackbodyLarge?.copyWith(color: Colors.white),
        bodyMedium: _blackbodyMedium?.copyWith(color: Colors.white),
        bodySmall: _blackbodySmall?.copyWith(color: Colors.white),
        labelLarge: _blacklabelLarge?.copyWith(color: Colors.white),
        labelMedium: _blacklabelMedium?.copyWith(color: Colors.white),
        labelSmall: _blacklabelSmall?.copyWith(color: Colors.white),
      );
}
