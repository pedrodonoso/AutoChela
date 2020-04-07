import 'package:AutoChela/entity/Beer.dart';
import 'package:AutoChela/entity/Hardware.dart';
import 'package:AutoChela/main.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';


import 'dart:convert';


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
  // final DocumentSnapshot beer;
  final Beer beer;
  final FirebaseApp app;

  BeerDetailsPage({Key key, this.beer,this.app}) : super(key: key);


  @override
  _BeerDetailsState createState() => _BeerDetailsState();
}

class _BeerDetailsState extends State<BeerDetailsPage> {

  // final String path = "/led-prueba";
  // final String path = "/prueba-hardware";
  final String path = "/esp32-prueba";

  DatabaseReference itemRef;
  StateHardware stateHardware = StateHardware();



  bool _value = false;
  String hash_usr = "ABC123";
  Pedido pedido = Pedido();
  List<ChipPedido> pedidos =[];
  ChipPedido seleccionado;

  @override
  void initState() {
    super.initState();
//    itemRef = FirebaseDatabase.instance.reference().child(path);
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    itemRef = database.reference().child(path);
    stateHardware.setState(true);
    pedidos = pedido.pedidos;
  }

  @override
  Widget build(BuildContext context) {
//    itemRef = FirebaseDatabase.instance.reference().child(path);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.beer.nombre),
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

                          // Text(widget.beer.nombre,
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       fontSize: 24.0,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(90.0),
                              child:
                              Image(
                                image: NetworkImage(widget.beer.imagen),
                                width: MediaQuery.of(context).size.width* 0.4,
                                height: MediaQuery.of(context).size.width* 0.3,
                                fit: BoxFit.contain,
                              ),
//                                              Image.asset("assets/altamira.png",width: 100,height: 100,fit: BoxFit.contain),
                            ),
                          ),
                          Text("Descripción ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          LimitedBox(
                            maxWidth: MediaQuery.of(context).size.width* 0.8,
                            maxHeight: MediaQuery.of(context).size.height* 0.4,
                            child:Padding(
                              padding: EdgeInsets.fromLTRB(32, 8, 32,8),
                              child: Text(widget.beer.descripcion,
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
                                  // if(snapshot.data.snapshot.value != null) {
                                      // stateHardware.setState(snapshot.data.snapshot.value);
    //                                return _textBuild(snapshot.data.snapshot.value);
                                      print("STREAM PERFECT");
                                      return _cardDetailBeer(snapshot.data);
                                  // }
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

Widget _cardDetailBeer(Event snapshot) {
   Map<dynamic, dynamic> map = snapshot.snapshot.value;
   Hardware hard = Hardware.fromJson(map);
   //si hard.
  return Column(
    children: <Widget>[
      LimitedBox(
        maxWidth:  MediaQuery.of(context).size.width* 0.6,
        child: Text(
          // snapshot.data.snapshot.value ? "Apagado" : "Encendido",
          (hard.estado == "esperando") ? "Elige una cantidad a servir y escanea" :  "Espera un momentito, pronto se desocupará la maquina del placer...",
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
        ),
      ),
      
      Divider(height: 16,indent: 8, endIndent: 8, ),
      // SizedBox( width:100,height: 80, child: _chips(),),
      Text("Cantidad ",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold),
      ),
      LimitedBox(
        maxWidth: MediaQuery.of(context).size.width* 0.67,
        maxHeight: MediaQuery.of(context).size.height* 0.1,
        child: _chips(),
      ),
      (hard.estado == "esperando") ? 
      RaisedButton(
        child: Text("Pedir"),
        elevation: 8.0,
        onPressed: () {
          print(hard.total);
          print(widget.beer.id);
          if(_value) {
            print(widget.beer.descripcion);
            hard.pedido = seleccionado.cantidad; //LISTO
            hard.hash_usr = hash_usr; //ref o widget.beer.id //PRIODO DE PRUEBAS
            hard.conectado = "idUsuario"; //CON LOGICA DE USUARIO
            hard.estado = Hardware.PROCESANDO; //LISTO
            itemRef.update(hard.toJson());
          };
          // itemRef.set(hard.toJson());
        },
      ) : 
      RaisedButton(
        child: Text("Espere su turno"),
        elevation: 0.0,
        onPressed: () {

        },
      )
    ], 
  );
}

Widget _chips() {
  return ListView.builder(
            physics: ClampingScrollPhysics(),
//          addSemanticIndexes: true,     //proporciona un medio para que los programas lingüísticos como TalkBack o Voiceover hagan anuncios al usuario con discapacidad visual mientras los elementos se desplazan.
            scrollDirection: Axis.horizontal,
            itemCount: pedidos.length,
            padding: EdgeInsets.only(right:4.0),
            itemBuilder: (BuildContext ctxt, int index) {
              return Row(
                children: [
                  SizedBox(width: 4.0,),
                  ChoiceChip(
                labelPadding: EdgeInsets.only(left:16.0,right:16.0),
                
                selectedColor: Palette.secundaryLight,
                label: Text(pedidos[index].nombre),
                selected: pedidos[index].estado,
                onSelected: (bool selected) {
                  
                  pedidos.forEach((ChipPedido e) {
                    // print(e.estado);
                    if((e.estado) && (e.nombre != pedidos[index].nombre)){
                       e.estado = !e.estado;
                     }
                    if(e.nombre == pedidos[index].nombre) {
                      seleccionado = e;
                      print(e.toString());
                    }
                  });
                  setState(() {
                    pedidos[index].estado = (!pedidos[index].estado);
                   
                  });

                })
                ],
              );
          });
        
}


  @override
  void dispose() {
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


class ChipPedido {
  String nombre;
  int cantidad;
  bool estado;

  ChipPedido(this.nombre,this.cantidad,this.estado);
  @override
  String toString() {
    return "Nombre: ${this.nombre} , Cantidad: ${this.cantidad.toString()} , Estado: ${this.estado.toString()}";
  }
}

class Pedido {
  
  List<ChipPedido> pedidos = [];
  static const List<String> tags = ["250","500","750","Garrafa","Tapita","Chimbombo","Botella"];
  static const List<int> cantidades = [250,500,750,1000,50,5000,2500];
  static const List<bool> estados = [false,false,false,false,false,false,false];

  Pedido() {
    print(tags);
    for(int i=0 ;i < 7; ++i) {
      pedidos.add(ChipPedido(tags[i],cantidades[i],estados[i]));
      // print(pedidos[i].toString());
    }
  }

  

}