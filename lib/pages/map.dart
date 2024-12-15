import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../widgets/appBar.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../global/colors.dart';
import '../global/config.dart';
import '../global/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../global/dimensions.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final LatLng sourceLocation = LatLng(42.747932, -71.167889);
  final LatLng destLocation = LatLng(37.335685, -122.0605916);
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  LocationData currentLocation;

  LocationData destinationLocation;

  Location location;
  String _mapStyle;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString(MAP_STYLE).then((string) {
      _mapStyle = string;
    });

    location = new Location();
    polylinePoints = PolylinePoints();

    location.onLocationChanged().listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });

    setSourceAndDestinationIcons();
    setInitialLocation();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), SOURCE_ICON);

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), DEST_ICON);
  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();

    destinationLocation = LocationData.fromMap(
        {"latitude": 37.335685, "longitude": -122.0605916});
  }

  void setPolylines(double lat, double long) async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        currentLocation.latitude,
        currentLocation.longitude,
        lat,
        long);
    if (result.isNotEmpty) {
      polylineCoordinates = [];
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polylines.add(Polyline(
            width: 5,
            polylineId: PolylineId("poly"),
            color: LIGHT_PALETTE,
            points: polylineCoordinates));
      });
    }
  }

  void showPinsOnMap() {
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);

    var destPosition = destLocation;

    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon));

    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon));

    setPolylines(37.335685, -122.0605916);
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(() {
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition,
          icon: sourceIcon));
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: sourceLocation);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return Scaffold(
      appBar: getAppBar1(TITLE1),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                controller.setMapStyle(_mapStyle);
                showPinsOnMap();
              }),
          Positioned(
              bottom: 7.0,
              right: 0.0,
              left: 0.0,
              child: Flex(direction: Axis.vertical, children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.25,
                    autoPlay: false,
                    viewportFraction: 0.5,
                  ),
                  items: carList1.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                            onTap: () {
                              setState(() {
                                var destPosition =
                                    LatLng(item['lat'], item['long']);

                                _markers.add(Marker(
                                    markerId: MarkerId('destPin'),
                                    position: destPosition,
                                    icon: destinationIcon));
                              });

                              setPolylines(item['lat'], item['long']);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  color: DARK_PALETTE,
                                ),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Flex(
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Image.asset(
                                      item['image'],
                                      width: CAR_WIDTH,
                                      height: CAR_HEIGHT,
                                    ),
                                    Text(item['title'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: LIGHT_PALETTE)),
                                    Text(item['reg'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: LIGHT_PALETTE)),
                                    Text(item['avail'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            color: LIGHT_PALETTE)),
                                  ],
                                )));
                      },
                    );
                  }).toList(),
                )
              ]))
        ],
      ),
    );
  }
}
