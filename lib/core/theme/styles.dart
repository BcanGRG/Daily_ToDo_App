import 'package:flutter/material.dart';

abstract class MyThemeStyle {
  static const InputDecoration textFieldInputDecoration = InputDecoration(
      border: InputBorder.none,
      hintText: "Görev Nedir ?",
      contentPadding: EdgeInsets.only(left: 8.0));

  static const ShapeBorder modelBottomSheetShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)));
  static const TextStyle taskDismissedTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static BoxDecoration taskItemContainer = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: Offset(0, 4),
        )
      ]);
}
