import 'package:flutter/material.dart';

class SyntaxHighlighterStyle {
  SyntaxHighlighterStyle(
      {this.baseStyle,
      this.numberStyle,
      this.commentStyle,
      this.keywordStyle,
      this.stringStyle,
      this.punctuationStyle,
      this.classStyle,
      this.constantStyle});

  final TextStyle baseStyle;
  final TextStyle numberStyle;
  final TextStyle commentStyle;
  final TextStyle keywordStyle;
  final TextStyle stringStyle;
  final TextStyle punctuationStyle;
  final TextStyle classStyle;
  final TextStyle constantStyle;
}
