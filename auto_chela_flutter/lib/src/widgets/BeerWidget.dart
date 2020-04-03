
import 'package:AutoChela/src/widgets/BeerItemWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BeerWidget extends StatefulWidget {
  final List<DocumentSnapshot> listReferencesBeer;


  const BeerWidget({Key key, this.listReferencesBeer}) : super(key: key);
  @override
  _BeerWidgetState createState() => _BeerWidgetState();
}

class _BeerWidgetState extends State<BeerWidget> {

  DocumentSnapshot beeer;
  DocumentReference ref ;
  String nombre;
  String descripcion;
  int estrellas;
  String image;
  var precio;
  Stream<DocumentSnapshot>_query;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INIT STATE');
    setState(() {
      print("listReferences: ${widget.listReferencesBeer.toList()[0]}");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
        ListView.builder(
            physics: ClampingScrollPhysics(),
            //          physics: BouncingScrollPhysics(),
            //          addSemanticIndexes: true,     //proporciona un medio para que los programas lingüísticos como TalkBack o Voiceover hagan anuncios al usuario con discapacidad visual mientras los elementos se desplazan.
            scrollDirection: Axis.vertical,
            itemCount: widget.listReferencesBeer.length,
            padding: EdgeInsets.all(16),

            itemBuilder: (BuildContext ctxt, int index) {
              return _cardBeer(widget.listReferencesBeer[index], context);
            })
    );


  }

  _cardBeer(DocumentSnapshot beer, BuildContext context) {
    ref = beer['ref'];
    _query  = ref.snapshots();

    return Container(
      child:  StreamBuilder<DocumentSnapshot>(
        stream: _query,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if(snapshot.hasData) {
            return BeerItemWidget(
              document: snapshot.data,
            );
          } else {
            return ListTile(
              title: Text("Loading..."),
            );
          }
        },
      ),
    );
  }


}
