
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:location/location.dart';

import 'Entity/Pub.dart';
import 'MapWidget.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
//  bool mapToggle = false;
//  bool sitiosToggle = false;
//  bool resetToggle = false;
  GoogleMapController mapController;
//  Geolocation _location;

  StreamSubscription<QuerySnapshot> documentSubscription;
  List<Pub> pubs = List();
  LatLng  target;
  Stream<QuerySnapshot> _query;


  BitmapDescriptor pinLocationIcon;
//  Position positionn;
//  StateMarkers stateMarkers = StateMarkers();

//  void setCustomMapPin() async {
//    pinLocationIcon = await  BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.5),
//        'assets/icon/beer-outline.png');
//  }
//
//  void setPosition() async {
//    positionn = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//  }

  void initState() {
    super.initState();
    _initLocation();
//    createMarker();
    setState(()  {
      _query = Firestore.instance.collection('pubs').snapshots();

    });
  }
  _initLocation()  {
     documentSubscription = Firestore.instance.collection('pubs').snapshots()
        .listen((event) {
         pubs = event.documents.map((e) => Pub(e)).toList();

    });


  }
  void createMarker() async {

      ImageConfiguration   configuration = ImageConfiguration(devicePixelRatio: 2.5);
      BitmapDescriptor bmp = await BitmapDescriptor.fromAssetImage(configuration,'assets/icon/beer-outline.png');
      pinLocationIcon = bmp;
  }

  @override
  Widget build(BuildContext context) {
    LatLng latLng = LatLng(-33.5646871,-70.7026347);
//    createMarker(context);
//    List<Marker> markers= pubs.map(
//            (pub) => Marker(
//                markerId: MarkerId(pub.nombre),infoWindow: InfoWindow(title: pub.nombre),
//                position: LatLng(pub.posicion.latitude,pub.posicion.longitude))).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('AutoChela'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
//
            StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData) {
                  print('STREAM MAP FULL');
//                  snapshot.data.documents.map((element) {
//                    print(element);
//                    Pub pub = Pub(element);
//                    print(pub.nombre);
//                    Marker m  =  Marker(
//                        markerId: MarkerId(pub.nombre),
//                        position: LatLng(pub.posicion.latitude, pub.posicion.longitude),
//                        infoWindow: InfoWindow(title: pub.nombre),
//                        icon: BitmapDescriptor.defaultMarkerWithHue(
//                          BitmapDescriptor.hueOrange,
//                        ));
//                    listmarkers.add(m);
//                  });
                  print("MARKERS: ${pubs.length}");
//                  stateMarkers.setState(listmarkers);

                  return _mapWiget(latLng,snapshot.data);
//                    Center(child: CircularProgressIndicator());
//                    MapWidget(
//                    documents: snapshot.data.documents,
//                  );
                } else if( snapshot.connectionState ==  ConnectionState.done) {
                  print('CONNECTION DONE');
                  return _snackBar("CONNECTIONDONE");
                } else if( snapshot.connectionState == ConnectionState.waiting ) {
                  return Center(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text('No data yet'),
                            SizedBox(height: 16),
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                  );
                } else if( snapshot.hasError ) {
                  return _snackBar('Error: ${snapshot.error.toString()}');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            )

          ],
        )
    );

  }


Widget _mapWiget(LatLng latLng, QuerySnapshot snapshot ) {
    print("LARGO :${snapshot.documents.length}");
//    createMarker();
    List<Marker> markers= pubs.map(
            (pub) => Marker(
                markerId: MarkerId(pub.nombre),infoWindow: InfoWindow(title: pub.nombre),
                position: LatLng(pub.posicion.latitude,pub.posicion.longitude),
//                icon: pinLocationIcon
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)


            )).toList();

//    snapshot.documents.map((element) {
//        Pub pub = Pub(element);
//        print("ELEMENT : ${element.data["nombreBar"]}");
//        print(pub.nombre);
//        Marker m  =  Marker(
//            markerId: MarkerId(pub.nombre),
//            position: LatLng(pub.posicion.latitude, pub.posicion.longitude),
//            infoWindow: InfoWindow(title: pub.nombre),
//            icon: BitmapDescriptor.defaultMarkerWithHue(
//              BitmapDescriptor.hueOrange,
//            ));
//          listmarkers.add(m);
//
//      });
    return Stack (
      children: <Widget>[
//    mapToggle ?
//    true ?
    GoogleMap (
        initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: 15
    ),
  //                          onTap: (pos) {
  //                            print(pos);
  //                            Marker m = Marker(markerId: MarkerId('1'), icon: pinLocationIcon,position: pos);
  //                            setState(() {
  //                              listmarkers.add(m);
  //                            });
  //                          },
  onMapCreated: onMapCreated,
  myLocationButtonEnabled: true,
  myLocationEnabled: true,
  mapType: MapType.normal,
  compassEnabled: true,
//            markers: Set.from(listmarkers)
  markers: markers.toSet()),
//            Set.from(snapshot.documents.toList().map((doc) =>  Marker(
//                markerId: MarkerId(doc.data['nombreBar']),
//                position: LatLng(doc.data['location'].latitude, doc.data['location'].longitude),
//                infoWindow: InfoWindow(title: doc.data['nombreBar']),
//                icon: BitmapDescriptor.defaultMarkerWithHue(
//                  BitmapDescriptor.hueOrange,
//                )))),
  //                          Set.from(listmarkers),

            MapWidget(
                documents: snapshot.documents,
                  )
      ],
    );
}
  void onMapCreated(controller) async {
//    var icon;
//    await setCustomMapPin().then((i) => icon=i);
    setState(() {
      mapController = controller;


//      listmarkers.add(
//          Marker(
//            markerId: MarkerId("Prueba"),
//            position: LatLng(-33.5646871,-70.7026347),
//            infoWindow: InfoWindow(title: "Nombre Prueba"),
//            icon:  icon,
////              pinLocationIcon,
////              BitmapDescriptor.defaultMarkerWithHue(
////                BitmapDescriptor.hueOrange, )
//
//          ));
//      _getPosition();


    });
  }
  Widget _snackBar(String nombre) {
    return SnackBar(content: Text(nombre));
  }
/*
  Future<double> aux(Location startLoc, Location endLoc) async {
    var startLat = startLoc.lat;
    var startLng = startLoc.lng;
    var endLat	= endLoc.lat;
    var endLng = endLoc.lng;
    return (await Geolocator().distanceBetween(startLat, startLng, endLat, endLng));
    }
 */

/*  _startTracking() {
    final geolocator = Geolocator();
    final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 15);
    _positionStream = geolocator.getPositionStream(locationOptions).listen(_onLocationUpdate);
  }*/

/*  _onLocationUpdate(Position position) {
    if(position != null) {
      // initialPosition = LatLng(position.latitude,position.longitude);
      print("position ${position.latitude},${position.longitude}");
    }
  }*/



  zoomInMarker(sitio) {
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            sitio['location'].latitude, sitio['location'].longitude),
        zoom: 17.0,
        bearing: 90.0,
        tilt: 45.0)))
        .then((val) {
      setState(() {
//        resetToggle = true;
      });
    });
  }

  markerInicial() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(51.0533076, 5.9260656), zoom: 5.0))).then((val) {//Alemania, Berlin
      setState(() {
//        resetToggle = false;
      });
    });
  }
//
//  girarDerecha() {
//    mapController.animateCamera(CameraUpdate.newCameraPosition(
//        CameraPosition(
//            target: LatLng(sitioActual['location'].latitude,
//                sitioActual['location'].longitude
//            ),
//            bearing: currentBearing == 360.0 ? currentBearing : currentBearing + 90.0,
//            zoom: 17.0,
//            tilt: 45.0
//        )
//    )
//    ).then((val) {
//      setState(() {
//        if(currentBearing == 360.0) {}
//        else {
//          currentBearing = currentBearing + 90.0;
//        }
//      });
//    });
//  }
//
//  giroIzquierda() {
//    mapController.animateCamera(CameraUpdate.newCameraPosition(
//        CameraPosition(
//            target: LatLng(sitioActual['location'].latitude,
//                sitioActual['location'].longitude
//            ),
//            bearing: currentBearing == 0.0 ? currentBearing : currentBearing - 90.0,
//            zoom: 17.0,
//            tilt: 45.0
//        )
//    )
//    ).then((val) {
//      setState(() {
//        if(currentBearing == 0.0) {}
//        else {
//          currentBearing = currentBearing - 90.0;
//        }
//      });
//    });
//  }

}


class StateMarkers {
  final _stateController = StreamController<List<Marker>>();
  Stream<List<Marker>>get estate => _stateController.stream;
  void setState(List<Marker> val) =>_stateController.add(val);

  dispose(){
    _stateController.close();
  }
}

