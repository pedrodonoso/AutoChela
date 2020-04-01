

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
  String nombre = data['nombreBar'];
  String imagen = data['imagen'];
  return Padding(
      padding: EdgeInsets.only(left: 2.0, top: 10.0),
      child: InkWell(
          onTap: () {
//              String n =docRef.data.['reference'].toString();
            print("Presionado $nombre");
            Navigator.of(context).pushNamed('/bar',arguments: data); //TODO: envía main info del boton presionado
          },
          child: FittedBox(
              child:Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 180,
                        height: 200,
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(24.0),
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(imagen,scale: 1.0),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myDetailsContainer1(nombre), //TODO: detalle card de mapa
                        ),
                      ),
                    ],)
              )
          )
      )
  );
}



Widget myDetailsContainer1(String barName) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
            child: Text(barName,
              style: TextStyle(
                  color: Colors.orange[700],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            )),
      ),
      SizedBox(height:5.0),
      Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                    "4.1",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  )),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStarHalf,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                  child: Text(
                    "(946)",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  )),
            ],
          )),
      SizedBox(height:5.0),
      Container(
          child: Text(
            "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          )),
      SizedBox(height:5.0),
      Container(
          child: Text(
            "Closed \u00B7 Opens 17:00 Thu",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )),
    ],
  );
}

