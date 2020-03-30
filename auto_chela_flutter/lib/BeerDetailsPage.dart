


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class BeerDetailsPage extends StatefulWidget {
  final DocumentSnapshot beer;


  const BeerDetailsPage({Key key, this.beer}) : super(key: key);

  @override
  _BeerDetailsState createState() => _BeerDetailsState();
}

class _BeerDetailsState extends State<BeerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.beer['nombreBeer']),
      ),
      body: Center(
          child:
          InkWell(
            onTap: (){
              DocumentReference ref = widget.beer['ref'];
              String reference = widget.beer['reference'];
              String nombre= widget.beer['reference'];
              print("REF: ${ref}");
              print("REF2: ${ref.documentID}");
              ref.get().then((DocumentSnapshot beer) => print("DESCRIPCION1: ${beer['descripcion']}"));


              print("NOMBRE: ${nombre}, REFERENCE: ${reference}");

            },

          )
        /*Image(
          image: NetworkImage(widget.beer['image']),
          fit: BoxFit.contain,
        ),*/
      ),
    );
  }
}
