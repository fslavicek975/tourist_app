import 'package:flutter/material.dart';

const _titleTextStyle = TextStyle(fontSize: 36, fontWeight: FontWeight.bold);
const _subtitleTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
const _textFieldTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
const _buttonTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const _labelTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

const _cardTitleTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const _cardSubtitleTextStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
const _cardLabelTextStyle = TextStyle(fontSize: 12);



extension CustomTextStyle on TextTheme {
  TextStyle get titleTextStyle => _titleTextStyle;
  TextStyle get subtitleTextStyle => _subtitleTextStyle;
  TextStyle get textFieldTextStyle => _textFieldTextStyle;
  TextStyle get buttonTextStyle => _buttonTextStyle;
  TextStyle get labelTextStyle => _labelTextStyle;

  TextStyle get cardTitleTextStyle => _cardTitleTextStyle;
  TextStyle get cardSubtitleTextStyle => _cardSubtitleTextStyle;
  TextStyle get cardLabelTextStyle => _cardLabelTextStyle;
}