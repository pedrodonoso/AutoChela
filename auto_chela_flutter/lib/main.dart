
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'BarPage.dart';
import 'BeerDetailsPage.dart';
import 'MapPage.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Color mainColor = Colors.amber;
    return MaterialApp(
      title: 'AutoChela',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: mainColor,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: (RouteSettings settings){
        WidgetBuilder builder;
        switch(settings.name) {
          case '/':
            builder =
                (BuildContext context) => MapPage();
            //(BuildContext context) => HomePageBeer();

            break;

          case '/bar':
            var args = settings.arguments;
            if(args is DocumentSnapshot) {
              builder =
                  (BuildContext context) =>
                  BarPage(
                    data: args,
                  );
            }
            break;
          case '/beerDetails':
            var args = settings.arguments;
            if(args is DocumentSnapshot) {
              builder =
                  (BuildContext context) =>
                  BeerDetailsPage(
                    beer: args,
                  );
            }
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

