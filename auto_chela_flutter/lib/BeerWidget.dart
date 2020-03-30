
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Beer.dart';


class BeerWidget extends StatefulWidget {
  final List<DocumentSnapshot> listReferencesBeer;
//  final Iterable<Future<DocumentSnapshot>> listBeers;


  BeerWidget({Key key, this.listReferencesBeer}) :
//        listBeers = listReferencesBeer.map((DocumentSnapshot doc) => Firestore.instance.document(doc['reference']).get()
//            .then((DocumentSnapshot snap) {return snap;})),
        super(key: key);
  @override
  _BeerWidgetState createState() => _BeerWidgetState();
}

class _BeerWidgetState extends State<BeerWidget> {
  /*Future<List<DocumentSnapshot>> _getBeersPerPub() async{
    List<DocumentSnapshot> listBeersPerPub = [];
    await widget.listReferencesBeer.map((beerRefs){

        listBeersPerPub.add(beerRefs);
     });
    print(listBeersPerPub.length);

  }*/




  DocumentSnapshot beeer;
  DocumentReference ref ;
  String nombre;
  String descripcion;
  int estrellas;
  String image;
  var precio;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INIT STATE');

    setState(() {
//      widget.listReferencesBeer.map((f)=> print("mapeo ${f.documentID}"));
//      widget.listReferencesBeer.map((f)=> Firestore.instance.document(f['reference'].toString())
//          .get().then((DocumentSnapshot sn) {
//        print('sad ${sn['precio'].toString()}');
//        listBeersPerPub.add(sn);
//      })
//      );
//      listBeersPerPub = _getBeersPerPub();
      print("listReferences: ${widget.listReferencesBeer.toList()[0]}");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
//                  height: MediaQuery.of(context).size.height,
//                  width: MediaQuery.of(context).size.width,
        child:
        ListView.builder(
          //            controller: widget.controller,
            physics: ClampingScrollPhysics(),
            //          physics: BouncingScrollPhysics(),
            //          addSemanticIndexes: true,     //proporciona un medio para que los programas lingüísticos como TalkBack o Voiceover hagan anuncios al usuario con discapacidad visual mientras los elementos se desplazan.
            scrollDirection: Axis.vertical,
            itemCount: widget.listReferencesBeer.length,
            padding: EdgeInsets.all(16),

            itemBuilder: (BuildContext ctxt, int index) {
              return _cardBeer(widget.listReferencesBeer[index], context);

//              return _cardBeer( widget.listBeers.elementAt(index), context);

            })
      /*FutureBuilder(
          future: _getBeersPerPub(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("KE? ${snapshot.data}");
            if (snapshot.hasData == null) {
              return Container(
                  child: Center(
                      child: Text("Loading ....")
                  )
              );
            } else {
              return ListView.builder(
                //            controller: widget.controller,
                  physics: ClampingScrollPhysics(),
                  //          physics: BouncingScrollPhysics(),
                  //          addSemanticIndexes: true,     //proporciona un medio para que los programas lingüísticos como TalkBack o Voiceover hagan anuncios al usuario con discapacidad visual mientras los elementos se desplazan.
                  scrollDirection: Axis.vertical,
                  itemCount: widget.listReferencesBeer.length,
                  padding: EdgeInsets.all(16),

                  itemBuilder: (BuildContext ctxt, int index) {
//                    return _cardBeer(widget.listReferencesBeer[index], context);
                    return ListTile(
                      title: Text(snapshot.data[index]['ref'].get().then((DocumentSnapshot beer)=> beer['precio'])),
                    );
                  }
              );
            }
          }
        ),*/
    );


  }

  /* _cardBeer(DocumentSnapshot beer, BuildContext context) {
    *//*Future<List<DocumentSnapshot>> _getBeersPerPub() async{
    List<DocumentSnapshot> listBeersPerPub = [];
    await widget.listReferencesBeer.map((beerRefs){

        listBeersPerPub.add(beerRefs);
     });
    print(listBeersPerPub.length);

  }*//*
//    String imagen = beer['image'];
//    DocumentSnapshot beer = beerd as DocumentSnapshot;
      ref = beer['ref'];
      ref.get().then((DocumentSnapshot beer) async {
        nombre = beer['nombreBeer'];
        descripcion =beer['descripcion'];
        image = beer['image'];
        precio = beer['precio'];
        estrellas = beer['estrellas'];
      });


    return GestureDetector(
      onTap: () {
        print("BOTON PRESIONADO");
        print("NOMBRE: ${nombre} ; DESCRICION: ${descripcion}");
        Navigator.pushNamed(context, '/beerDetails',arguments: beer);
      },
      onLongPress: () {

      },
      onDoubleTap: (){

      },
      onHorizontalDragCancel: () {
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: new BorderRadius.circular(90.0),
                    child:
//                      Container(
//                        width: 100,
//                        height: 100,
//                        padding: const EdgeInsets.all(8.0),
//                        child: ClipRRect(
//                          borderRadius: new BorderRadius.circular(24.0),
//                          child: Image(
//                            fit: BoxFit.contain,
//                            image: NetworkImage(imagen,scale: 0.5),
//                          ),
//                        ),
//                      ),
                   *//* Image(
                      image: NetworkImage(widget.beer['image']),
                      fit: BoxFit.contain,
                    )*//*
                    Image.asset("assets/altamira.png",width: 100,height: 100,fit: BoxFit.contain),
                  ),

                  SizedBox(width: 16),
                  Column(
                    children: <Widget>[
                      Text(
                        'nombre' ,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey[800],),
                      ),
                      Text(
                        'precio.toString()',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey[800],),
                      ),
                    ],
                  ),
              ],
              ),
                  Text(
                    "CONECTAR",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[800],),
                  )
            ],
          ),
        ),
      ),
    );
  }*/

  _cardBeer(DocumentSnapshot beer, BuildContext context) {

    Future<Beer> _getBeer() async{
      Beer snap;
      ref = beer['ref'];
      await ref.get().then((DocumentSnapshot beer) async {
//        snap = beer;
        /* nombre = beer['nombreBeer'];
        descripcion =beer['descripcion'];
        image = beer['image'];
        precio = beer['precio'];
        estrellas = beer['estrellas'];*/
        Beer  cerveza = Beer(beer);
        snap=cerveza;

      });
      print("FUTURE: ${beer['nombreBeer']}");
      return snap;

    }
//    String imagen = beer['image'];
//    DocumentSnapshot beer = beerd as DocumentSnapshot;
    /*ref = beer['ref'];
    ref.get().then((DocumentSnapshot beer) async {
      nombre = beer['nombreBeer'];
      descripcion =beer['descripcion'];
      image = beer['image'];
      precio = beer['precio'];
      estrellas = beer['estrellas'];
    });*/

    return Container(
      child:  FutureBuilder(
          future: _getBeer(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return ListTile(
//                title: Text(snapshot.data['nombreBeer']),
                title: Text("Loading..."),
              );
            } else {
              return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/beerDetails',arguments: beer);
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
                                          child:
                                          //                      Container(
                                          //                        width: 100,
                                          //                        height: 100,
                                          //                        padding: const EdgeInsets.all(8.0),
                                          //                        child: ClipRRect(
                                          //                          borderRadius: new BorderRadius.circular(24.0),
                                          //                          child: Image(
                                          //                            fit: BoxFit.contain,
                                          //                            image: NetworkImage(imagen,scale: 0.5),
                                          //                          ),
                                          //                        ),
                                          //                      ),
                                          /* Image(
                                image: NetworkImage(widget.beer['image']),
                                fit: BoxFit.contain,
                              )*/

                                          Image(
                                            image: NetworkImage(snapshot.data.imagen),
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
                                                snapshot.data.nombre,
                                                style: TextStyle(fontSize: 15.0,color: Colors.grey[800],),
                                              ),
                                            ),
                                            Divider(height: 16,indent: 8, endIndent: 8, ),
                                            Container(
                                              child: Text(
                                                snapshot.data.descripcion,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                style: TextStyle(fontSize: 12.0, color: Colors.grey[800],),
                                              ),
                                            ),
                                            Divider(height: 16,indent: 8, endIndent: 8, ),
                                            _stars(snapshot.data.estrellas),
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
                                                "\$ ${snapshot.data.precio.toString()}",
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
      ),
    );
  }

  Widget _stars( var i ) {
    List<int> stars;
    stars = [0,0,0,0,0,0];

    if ((i%0.5) == 0) {
      i = i;
    }
    else if((i.ceil() - i.roundToDouble()) ==1)  {//i=3.4
      i = i.floor();
    } else {//i=3.6
      i=i.ceil();
    }
    var contador = 0;
    stars.forEach( (estrella) {
      if(contador < i) {
        stars[contador] = 1;
      } else if((contador-i)==0.5)  {
        stars[contador-1] =2;
      }
      contador = contador +1;
    });

    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Icon(
                ((stars[0] ==1) ? FontAwesomeIcons.solidStar : ((stars[0] ==0) ? FontAwesomeIcons.star : FontAwesomeIcons.solidStarHalf) ),
//                  FontAwesomeIcons.star,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                ((stars[1] ==1) ? FontAwesomeIcons.solidStar : ((stars[1] ==0) ? FontAwesomeIcons.star : FontAwesomeIcons.solidStarHalf) ),
//                  FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                ((stars[2] ==1) ? FontAwesomeIcons.solidStar : ((stars[2] ==0) ? FontAwesomeIcons.star : FontAwesomeIcons.solidStarHalf) ),
//                  FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                ((stars[3] ==1) ? FontAwesomeIcons.solidStar : ((stars[3] ==0) ? FontAwesomeIcons.star : FontAwesomeIcons.solidStarHalf) ),
//                  FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                ((stars[4] ==1) ? FontAwesomeIcons.solidStar : ((stars[4] ==0) ? FontAwesomeIcons.star : FontAwesomeIcons.solidStarHalf) ),
//                  FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                ((stars[5] ==1) ? FontAwesomeIcons.solidStar : ((stars[5] ==0) ? FontAwesomeIcons.star : FontAwesomeIcons.solidStarHalf) ),
//                  FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
          ],
        ));
  }


}
