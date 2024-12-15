import 'package:flutter/material.dart';
import '../global/colors.dart';
import '../global/constants.dart';
import '../global/styles.dart';

class DateTime extends StatefulWidget {
  @override
  _DateTimeState createState() => _DateTimeState();
}

class _DateTimeState extends State<DateTime> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Card(
          child: ListTile(
            leading: Icon(Icons.calendar_today, color: DARK_PALETTE),
            title: Text(DAT, style: STYLE_TITLE_),
            subtitle: Text(DAT_VALUE, style: STYLE_STITLE_),
          ),
        )),
        Expanded(
            child: Card(
          child: ListTile(
            leading: Icon(Icons.access_time, color: DARK_PALETTE),
            title: Text(TIM, style: STYLE_TITLE_),
            subtitle: Text(TIM_VALUE, style: STYLE_STITLE_),
          ),
        )),
      ],
    );
  }
}
