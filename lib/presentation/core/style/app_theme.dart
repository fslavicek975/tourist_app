import 'package:flutter/material.dart';
import 'package:tourist_app/presentation/core/style/colors.dart';


final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  fontFamily: 'Montserrat',
  extensions: const [
    AppColors(
      text: textColorLight,
      background: backgroundColorLight,
      border: borderColorLight,
      error: errorColorLight,
      gradientBegin: gradientBeginColorLight,
      gradientEnd: gradientEndColorLight,
      cardText: cardTextColorLight,
      link: linkColorLight,
    ),
  ],
);
