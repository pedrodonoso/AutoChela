

import 'package:AutoChela/Entity/Pub.dart';
import 'package:AutoChela/Entity/Stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;

  const MapWidget({Key key, this.documents}) : super(key: key);
//  ScrollController controller ;
//  MapWidget({Key key,this.documents,this.controller}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height - 280.0,
//      top: MediaQuery.of(context).size.height - 200.0,
        child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child:  ListView.builder(
//            controller: widget.controller,
                physics: ClampingScrollPhysics(),
//          physics: BouncingScrollPhysics(),
//          addSemanticIndexes: true,     //proporciona un medio para que los programas lingüísticos como TalkBack o Voiceover hagan anuncios al usuario con discapacidad visual mientras los elementos se desplazan.
                scrollDirection: Axis.horizontal,
                itemCount: widget.documents.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (BuildContext ctxt, int index) {
                  return siteCard(widget.documents[index],context);
                })
        )
    );
  }
}



Widget siteCard(DocumentSnapshot data,BuildContext context) {
  Pub pub = Pub(data);

  return Padding(
      padding: EdgeInsets.only(left: 2.0, top: 10.0),
      child: InkWell(
          onTap: () {
//              String n =docRef.data.['reference'].toString();
            print("Presionado ${pub.nombre}");
            Navigator.of(context).pushNamed('/bar',arguments: data); //TODO: envía main info del boton presionado
          },
          child: FittedBox(
              child: LimitedBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 14.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(16.0),
                            child: Image(
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width* 0.35,
                              height: MediaQuery.of(context).size.width* 0.35,
                              image: NetworkImage(pub.imagen,scale: 1.0),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right:8.0,top:8.0,bottom: 8.0),
                            child: myDetailsContainer1(pub,context),
                          ),
                      ],)
                ),
              )
          )
      )
  );
}



Widget myDetailsContainer1(Pub data,BuildContext context) {

  return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width*0.55,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(data.nombre,
          style: TextStyle(
//                  color: Colors.orange[700],
              fontSize: 24.0,
              fontWeight: FontWeight.bold),

        ),

        SizedBox(height:4.0),
        Stars(numero: data.calificacion),
        SizedBox(height:5.0),
        Container(
            child: Text( "Distancia \u00B7 1.6 Km",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        LimitedBox(
            maxWidth: MediaQuery.of(context).size.width*0.55,
            child: Text( "${data.getStatePub()} \u00B7 ${data.hora}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            )
        ),

      ],
    )
  );

}

