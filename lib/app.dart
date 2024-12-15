import 'package:flutter/material.dart';
import './widgets/locale.dart';
import './widgets/datetime.dart';
import './widgets/vehicles.dart';
import './global/config.dart';
import './global/colors.dart';
import './global/constants.dart';
import './global/styles.dart';
import './global/dimensions.dart';
import './widgets/appBar.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: FONT_FAMILY),
      title: APP_TITLE,
      home: Builder(
          builder: (context) => Scaffold(
                backgroundColor: LIGHT_PALETTE,
                appBar: getAppBar(TITLE),
                body: SingleChildScrollView(
                  child: Container(
                      padding: DIM_APP_CONTAINER,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Placeholder(
                              fallbackHeight:
                                  MediaQuery.of(context).size.height * 0.2),
                          Locale(),
                          DateTime(),
                          Container(
                            padding: DIM_VTYPE_CONTAINER,
                            child: Text(VTYPE, style: STYLE_TITLE_),
                          ),
                          Vehicles(),
                        ],
                      )),
                ),
              )),
      debugShowCheckedModeBanner: false,
    );
  }
}
