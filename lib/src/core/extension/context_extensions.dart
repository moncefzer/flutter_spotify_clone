import 'package:flutter/material.dart';

extension ContextUtils on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  TextStyle get headlineSmall => textTheme.headlineSmall!;
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleSmall => textTheme.titleSmall!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelSmall => textTheme.labelSmall!;
}

// displayLarge = displayLarge ?? headline1,
// displayMedium = displayMedium ?? headline2,
// displaySmall = displaySmall ?? headline3,
// headlineMedium = headlineMedium ?? headline4,
// headlineSmall = headlineSmall ?? headline5,
// titleLarge = titleLarge ?? headline6,
// titleMedium = titleMedium ?? subtitle1,
// titleSmall = titleSmall ?? subtitle2,
// bodyLarge = bodyLarge ?? bodyText1,
// bodyMedium = bodyMedium ?? bodyText2,
// bodySmall = bodySmall ?? caption,
// labelLarge = labelLarge ?? button,
// labelSmall = labelSmall ?? overline;

/// | NAME             | SIZE |  WEIGHT |  SPACING |             |
/// |-----------------|------|---------|----------|-------------|
/// | displayLarge   | 96.0 | light   | -1.5     |             |
/// | displayMedium  | 60.0 | light   | -0.5     |             |
/// | displaySmall   | 48.0 | regular |  0.0     |             |
/// | headlineMedium | 34.0 | regular |  0.25    |             |
/// | headlineSmall | 24.0 | regular |  0.0     |             |
/// | titleLarge    | 20.0 | medium  |  0.15    |             |
/// | titleMedium   | 16.0 | regular |  0.15    |             |
/// | titleSmall    | 14.0 | medium  |  0.1     |             |
/// | bodyLarge     | 16.0 | regular |  0.5     | (bodyText1) |
/// | bodyMedium    | 14.0 | regular |  0.25    | (bodyText2) |
/// | bodySmall     | 14.0 | medium  |  1.25    |             |
/// | labelLarge    | 12.0 | regular |  0.4     |             |
/// | labelSmall    | 10.0 | regular |  1.5     |             |