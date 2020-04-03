

import 'package:AutoChela/entity/Stars.dart';
import 'package:AutoChela/entity/Beer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BeerItemWidget extends StatefulWidget {
  final DocumentSnapshot document;


  const BeerItemWidget({Key key, this.document}) : super(key: key);

  @override
  _BeerItemWidgetState createState() => _BeerItemWidgetState();
}

class _BeerItemWidgetState extends State<BeerItemWidget> {
  Beer beer;

  @override
  void initState() {
    super.initState();
    setState(() {
      beer = Beer(widget.document);
    });
  }
  @override
  Widget build(BuildContext context) {
    beer = Beer(widget.document);
    return GestureDetector(
        onTap: () {
          // print(beer.toString());
          Navigator.pushNamed(context, '/beerDetails',arguments: widget.document);
        },
        onLongPress: () {

        },
        onDoubleTap: (){

        },
        onHorizontalDragCancel: () {
        },

        child: FittedBox(
//                        padding: EdgeInsets.all(10),
          child: Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(

                                borderRadius: new BorderRadius.circular(90.0),
                                child:Image(
                                    image: NetworkImage(beer.imagen),
                                    width: MediaQuery.of(context).size.width* 0.35,
                                    height: MediaQuery.of(context).size.width* 0.35,
                                    fit: BoxFit.contain,
                                ),
//                                              Image.asset("assets/altamira.png",width: 100,height: 100,fit: BoxFit.contain),
                              ),
                            )

                          ],
                        ),
                        SizedBox(width: 16),
                        LimitedBox(
                            maxWidth: MediaQuery.of(context).size.width* 0.45,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                right: 8,
                                bottom: 8,
                              ),

                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                        direction: Axis.vertical,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    child: Text(
                                      beer.nombre,
                                      style: TextStyle(fontSize: 15.0,color: Colors.grey[800],),
                                    ),
                                  ),
                                  Divider(height: 16,indent: 8, endIndent: 8, ),
                                  Container(
                                    child: Text(
                                      beer.descripcion,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: TextStyle(fontSize: 12.0, color: Colors.grey[800],),
                                    ),
                                  ),
                                  Divider(height: 16,indent: 8, endIndent: 8, ),
                                  Stars(
                                    numero: beer.estrellas,
                                  ),
                                  /*Container(
                                                child: Text(
                                                  snapshot.data.estrellas.toString(),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                  style: TextStyle(fontSize: 10.0, color: Colors.grey[800],),
                                                ),
                                              ),*/
                                  Divider(height: 16,indent: 8, endIndent: 8, ),
                                  Container(
                                    child: Text(
                                      "\$ ${beer.precio.toString()}",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: TextStyle(fontSize: 15.0, color: Colors.grey[800],),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],

                    ),
                    Divider(height: 16, thickness: 4,),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "CONECTAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0, color: Colors.grey[800],),
                        )
                    ),


                  ],
                )

            ),
          ),
        )
    );
  }
}