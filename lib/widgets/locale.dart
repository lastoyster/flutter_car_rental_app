import 'package:flutter/material.dart';
import '../global/colors.dart';
import '../global/constants.dart';
import '../global/styles.dart';

class Locale extends StatefulWidget {
  @override
  _LocaleState createState() => _LocaleState();
}

class _LocaleState extends State<Locale> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: GestureDetector(
            onTap: () {},
            child: Card(
              child: ListTile(
                leading: Icon(Icons.room, color: DARK_PALETTE),
                title: Text(
                  TITLE_2,
                  style: STYLE_TITLE_,
                ),
                subtitle: Text(
                  STITLE_2,
                  style: STYLE_STITLE_,
                ),
              ),
            )));
  }
}
