





import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'MapWidget.dart';


class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  bool mapToggle = false;
  bool sitiosToggle = false;
  bool resetToggle = false;
  var currentLocation;
  // var initialPosition;
  var sitios = [];
  var sitioActual;
  var currentBearing;
  List<Marker> listmarkers = [];
  Stream<QuerySnapshot> _query;
  ScrollController ListViewController ;
  StreamSubscription<Position> _positionStream;

  GoogleMapController mapController;
  @override
  void dispose() {
    if(_positionStream!=null) {
      _positionStream.cancel();
      _positionStream = null;
    }
    super.dispose();
  }
  void initState() {
    super.initState();
//    ListViewController = ScrollController();

    setState(() {
      mapToggle = true;

      // populateClients();

      _query = Firestore.instance
          .collection('pubs')
          .snapshots();

      // _startTracking();
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng latLng = LatLng(-33.5646871,-70.7026347);
    return Scaffold(
        appBar: AppBar(
          title: Text('AutoChela'),
        ),
        body: Stack(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                print('builderMyHomeStream');
                if(snapshot.hasData) {

                  print('foreachMyhome');
                  return MapWidget(
                    documents: snapshot.data.documents,
//                          controller: ListViewController,
                  );
                } else if( snapshot.connectionState ==  ConnectionState.done) {
                  print('DONE');
                  return _snackBar("DONE");
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

          ],
        )
    );

  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
  Widget _snackBar(String nombre) {
    return SnackBar(content: Text('${nombre}'));
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

  _startTracking() {
    final geolocator = Geolocator();
    final locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 15);
    _positionStream = geolocator.getPositionStream(locationOptions).listen(_onLocationUpdate);
  }

  _onLocationUpdate(Position position) {
    if(position != null) {
      // initialPosition = LatLng(position.latitude,position.longitude);
      print("position ${position.latitude},${position.longitude}");
    }
  }

  /*  populateClients() {
    print('populate');
    sitios = [];

    Firestore.instance.collection('markers').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          sitiosToggle = true;
        });
        for (int i = 0; i < docs.documents.length; ++i) {
          print(docs.documents[i].data['nombreSitio']);
          sitios.add(docs.documents[i].data);
          setState(() {
            listmarkers.add(
              Marker(
              markerId: MarkerId(docs.documents[i].data['nombreSitio']),
              position: LatLng(
                  docs.documents[i].data['location'].latitude, docs.documents[i].data['location'].longitude),
              infoWindow: InfoWindow(title: docs.documents[i].data['nombreSitio']),
               icon: BitmapDescriptor.defaultMarkerWithHue(
                 BitmapDescriptor.hueViolet,
               )
          ));
          });

        }
      }
    });
  }

 */

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
        resetToggle = true;
      });
    });
  }

  markerInicial() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(51.0533076, 5.9260656), zoom: 5.0))).then((val) {//Alemania, Berlin
      setState(() {
        resetToggle = false;
      });
    });
  }

  girarDerecha() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(sitioActual['location'].latitude,
                sitioActual['location'].longitude
            ),
            bearing: currentBearing == 360.0 ? currentBearing : currentBearing + 90.0,
            zoom: 17.0,
            tilt: 45.0
        )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 360.0) {}
        else {
          currentBearing = currentBearing + 90.0;
        }
      });
    });
  }

  giroIzquierda() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(sitioActual['location'].latitude,
                sitioActual['location'].longitude
            ),
            bearing: currentBearing == 0.0 ? currentBearing : currentBearing - 90.0,
            zoom: 17.0,
            tilt: 45.0
        )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 0.0) {}
        else {
          currentBearing = currentBearing - 90.0;
        }
      });
    });
  }

}