

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BeerWidget.dart';




class BarPage extends StatefulWidget {
//  final String nombre;
  final DocumentSnapshot data;

  const BarPage({Key key, this.data}) : super(key: key);
  @override
  _BarPageState createState() => _BarPageState();
}

class _BarPageState extends State<BarPage> {

  //Stream<QuerySnapshot> _queryBeers;
//  Stream<List<DocumentSnapshot>> listBeers;
  List<DocumentSnapshot> listBeers =[];
  List<String> beers = [];
  Stream<QuerySnapshot> _queryBeers;


  @override
  void initState() {
    // TODO: implement initState


    setState(() {
      print("initStateBARwidget");
      print("Iniciando coleccion de Cervezas");
      DocumentReference ref = widget.data.reference;
//      DocumentReference refBeer ;

//      ref.collection('beersOfPub').snapshots()
//          .listen((beerCollection) => beerCollection.documents.forEach(
//                  (beer) => Firestore.instance.document(beer['reference']).get().then((DocumentSnapshot sn) {
//                    print('sad ${sn['precio'].toString()}');
//                  listBeers.add(sn);
//                  })
//      ));
      _queryBeers = ref.collection('beersOfPub')
          .snapshots();

    });
    super.initState();

  }

  _transformToDocSnap(DocumentSnapshot beer) {
    DocumentReference ref = beer['reference'];
    ref.get()
        .then((DocumentSnapshot ds) {
      String string = ds['estrellas'].toString();
      print('agregando: ${string}');
      listBeers.add(ds);
      beers.add(beer['nombreBeer']);
    });
  }


  @override
  Widget build(BuildContext context) {
    print("buildBar");

//    listBeers.forEach((DocumentSnapshot beer) => beers.add(beer['nombreBeer']));
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.data['nombreBar']}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
//              print(listBeers.length);

              showSearch(context: context, delegate: DataSearch(beers)
              );
            },
          )
        ],
      ),
//      drawer: Drawer(),  //menu lateral
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
        top: true,
        bottom: false,

        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _queryBeers,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                print('builderBarWidget');
                print('Bar Widget snap has data : ${snapshot.hasData}');

                if (snapshot.hasData &&  snapshot.data.documents.isNotEmpty ) {
                  print("LARGO: ${snapshot.data.documents.length}");

                  return BeerWidget(
//                    listReferencesBeer: snapshot.data.documents.map((DocumentSnapshot doc) {
//                      print('EJO ${doc.documentID}');
//                      Firestore.instance.document(doc['reference']).get().then((DocumentSnapshot c) async {
//                        print("AKA ${c.documentID}");
//                        return c;
//                      });
//                    }).toList(),
                    listReferencesBeer: snapshot.data.documents,
                  );

                } else if( snapshot.connectionState ==  ConnectionState.done) {
                  return Text('DONE BAR');
                } else if( snapshot.connectionState == ConnectionState.waiting ) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Text('No data yet BAR'),
                        SizedBox(height: 16),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else if( snapshot.hasError ) {
                  return Text('Error BAR: ${snapshot.error.toString()}');
                } else {
//                  return Text('Bar sin Cervezas');
                  return AlertDialog(
                    title: Text('Bar sin cervezas',textAlign: TextAlign.center,),
                    content: Center(
                      child: Column(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.data['imagen'],scale: 1.0),
                          ),
                        ],
                      ),
                    ),
                    elevation: 24.0,
                    titlePadding: EdgeInsets.all(16),
                  );
                }
              },
            ),

          ],
        ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}



class DataSearch extends SearchDelegate<String> {
//  final Stream<List<DocumentSnapshot>> beers;
//  final List<DocumentSnapshot> beers;
  final List<String> beers;
  List<String> recentBeers=[];

  DataSearch(this.beers);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Card(
      color: Colors.red,
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentBeers
        : beers.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) =>
          ListTile(
            onTap: () {
              showResults(context);
            },
            leading: Icon(Icons.local_drink),
            title: Text(suggestionList[index]),
          ),
      itemCount: suggestionList.length,
    );
  }
//      StreamBuilder<List<DocumentSnapshot>>(
//      stream: beers,
//      builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//            child: Text('No Data!'),
//          );
//        }
//        return ListView(
//          children: snapshot.data.map<Widget>((a) => Text(a['nombreBeer'])).toList(),
//        );
//      },
//    );



//
}
