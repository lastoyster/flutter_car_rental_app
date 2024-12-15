import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../global/config.dart';
import '../global/colors.dart';
import '../global/dimensions.dart';
import '../global/styles.dart';
import '../global/constants.dart';
import '../pages/map.dart';

class Vehicles extends StatefulWidget {
  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  bool checked = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
        checked = newValue;
      });
  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: [
      CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.25,
          autoPlay: true,
          viewportFraction: 0.5,
        ),
        items: carList.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  color: WHITE_PALETTE,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              alignment: Alignment.topRight,
                              child: Checkbox(
                                  activeColor: BLUE_PALETTE,
                                  value: checked,
                                  onChanged: _onRememberMeChanged))),
                      Image.asset(
                        item['image'],
                        width: CAR_WIDTH,
                        height: CAR_HEIGHT,
                      ),
                      Text(item['title'], style: STYLE_TITLE_),
                      Text(item['desc'], style: STYLE_STITLE_),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ));
            },
          );
        }).toList(),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          child: RaisedButton(
            color: DARK_PALETTE,
            shape: StadiumBorder(),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Map()));
            },
            child: Text(
              S_CAR,
              style: TextStyle(color: WHITE_PALETTE),
            ),
          ))
    ]);
  }
}
