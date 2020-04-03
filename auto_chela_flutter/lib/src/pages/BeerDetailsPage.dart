import 'package:AutoChela/entity/Beer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';




//
//Future<void> main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  final FirebaseApp app =  await FirebaseApp.configure(
//      name: "flutterapp13", options: const FirebaseOptions(
//    googleAppID: '1:549471011700:android:82831f807983a5cbfd2221',
//    apiKey: 'AIzaSyBo7EIUx6BwPlxZBye1bZSUHXa9xrTJjM8',
//    databaseURL: 'https://flutterapp13.firebaseio.com',
//  ));
//  runApp(BeerDetailsPage(app: app));
////  final FirebaseDatabase database = FirebaseDatabase(app: app);
//}


class BeerDetailsPage extends StatefulWidget {
  final DocumentSnapshot beer;
  final FirebaseApp app;
  BeerDetailsPage({Key key, this.beer,this.app}) : super(key: key);


  @override
  _BeerDetailsState createState() => _BeerDetailsState();
}

class _BeerDetailsState extends State<BeerDetailsPage> {

  final String path = "/led-prueba";
  DatabaseReference itemRef;
  StateHardware stateHardware = StateHardware();

  @override
  void initState() {
    super.initState();
//    itemRef = FirebaseDatabase.instance.reference().child(path);
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    itemRef = database.reference().reference().child(path);
    stateHardware.setState(true);
  }


  @override
  Widget build(BuildContext context) {
    Beer _beer  = Beer(widget.beer);
//    itemRef = FirebaseDatabase.instance.reference().child(path);
    return Scaffold(
        appBar: AppBar(
          title: Text(_beer.nombre),
        ),
        body: Center(
          child: FittedBox(
              child: Card(
                  margin: EdgeInsets.all(8.0),

                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text(_beer.nombre,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(90.0),
                              child:
                              Image(
                                image: NetworkImage(_beer.imagen),
                                width: MediaQuery.of(context).size.width* 0.3,
                                height: MediaQuery.of(context).size.width* 0.3,
                                fit: BoxFit.contain,
                              ),
//                                              Image.asset("assets/altamira.png",width: 100,height: 100,fit: BoxFit.contain),
                            ),
                          ),
                          LimitedBox(
                            maxWidth: MediaQuery.of(context).size.width* 0.6,
                            maxHeight: MediaQuery.of(context).size.height* 0.4,
                            child:Padding(
                              padding: EdgeInsets.fromLTRB(32, 8, 32,8),
                              child: Text(_beer.descripcion,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                          ),
                          Divider(height: 16,indent: 8, endIndent: 8, ),
                          Text("Estado ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),

                          StreamBuilder(
                            stream: itemRef.onValue,
                            builder: (context,AsyncSnapshot<Event> snapshot ) {
                              if(snapshot.data == null) {
                                print("STREAM NULL");
                              } else if(snapshot.hasData) {
                                if(snapshot.data.snapshot.value != null) {
                                    stateHardware.setState(snapshot.data.snapshot.value);
  //                                return _textBuild(snapshot.data.snapshot.value);
                                    print("STREAM PERFECT");
                                    return Column(
                                      children: <Widget>[
                                        SizedBox(height: 16),
                                        Text(
                                          snapshot.data.snapshot.value ? "Apagado" : "Encendido",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Divider(height: 8,indent: 8, endIndent: 8, ),
                                        Switch(
                                          value: snapshot.data.snapshot.value,
                                          onChanged: (bool s) {
                                            setState(() {
//                                              estado = s;
//                                              _changeState(estado);
                                              itemRef.set(s);
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                }
                              }
                              print("STREAM OTRO");
                              return Text(
                                  "Loading.."
                              );
                            },
                          ),
                        ],
                      )
                  )
              )

          ),
        )

    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stateHardware.dispose();
  }
}

class StateHardware {
  final _stateController = StreamController<bool>();
  Stream<bool>get estate => _stateController.stream;
  void setState(bool val) =>_stateController.add(val);

  dispose(){
    _stateController.close();
  }
}