import 'package:baraanwilati/app/utils/size_utils.dart';
import 'package:flutter/material.dart';

import 'theme_helper.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray600,
      );
  static BoxDecoration get fillBluegray100 => BoxDecoration(
        color: appTheme.blueGray100,
      );
  static BoxDecoration get fillBluegray50 => BoxDecoration(
        color: appTheme.blueGray50,
      );
  static BoxDecoration get fillDeepOrange => BoxDecoration(
        color: appTheme.deepOrange600,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray200,
      );
  static BoxDecoration get fillGray600 => BoxDecoration(
        color: appTheme.gray600,
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillOnPrimary1 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.25),
      );

  static BoxDecoration get outlineBlueGray => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      );

  // Gradient decorations
  static BoxDecoration get gradientBlueGrayToBlueGrayB => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.95, 0.05),
          end: const Alignment(0.04, 0.97),
          colors: [
            appTheme.blueGray300,
            appTheme.blueGray300B5,
          ],
        ),
      );
  static BoxDecoration get gradientDeepOrangeToDeepOrange => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.95, 0.05),
          end: const Alignment(0.04, 0.97),
          colors: [
            appTheme.deepOrange600,
            appTheme.deepOrange600.withOpacity(0.7),
          ],
        ),
      );
  static BoxDecoration get gradientGrayToPink => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0),
          end: const Alignment(1, 1),
          colors: [
            appTheme.gray600,
            appTheme.deepOrange600,
            appTheme.pink400,
          ],
        ),
      );
  static BoxDecoration get gradientPinkToPink => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.95, 0.05),
          end: const Alignment(0.04, 0.97),
          colors: [
            appTheme.pink400,
            appTheme.pink400.withOpacity(0.7),
          ],
        ),
      );
  static BoxDecoration get gradientPrimaryToPrimary => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.95, 0.05),
          end: const Alignment(0.04, 0.97),
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.75),
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.15),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              5,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderBL20 => BorderRadius.vertical(
        bottom: Radius.circular(20.h),
      );
  static BorderRadius get customBorderTL7 => BorderRadius.horizontal(
        left: Radius.circular(7.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15.h,
      );
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );
  static BorderRadius get roundedBorder44 => BorderRadius.circular(
        44.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );

  static BorderRadius get customBorderTL38 => BorderRadius.vertical(
        top: Radius.circular(38.h),
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
