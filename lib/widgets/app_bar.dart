import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar transparentAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );
}