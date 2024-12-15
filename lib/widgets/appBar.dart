import 'package:flutter/material.dart';
import '../global/colors.dart';
import '../global/styles.dart';

getAppBar(String title) {
  return AppBar(
    backgroundColor: LIGHT_PALETTE,
    leading: Icon(Icons.directions_car, color: DARK_PALETTE),
    title: Text(
      title,
      style: STYLE_TITLE,
    ),
    centerTitle: false,
    bottomOpacity: 0.0,
    elevation: 0.0,
  );
}

getAppBar1(String title) {
  return AppBar(
    iconTheme: IconThemeData(color: LIGHT_PALETTE),
    backgroundColor: DARK_PALETTE,
    title: Text(
      title,
      style: STYLE_TITLE1,
    ),
    centerTitle: false,
    bottomOpacity: 0.0,
    elevation: 0.0,
  );
}
