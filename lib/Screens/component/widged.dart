import 'package:flutter/material.dart';

card(Widget widget) {
  return Card(
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: widget,
  );
}
