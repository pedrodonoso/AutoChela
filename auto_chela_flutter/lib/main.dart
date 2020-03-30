
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: mainColor,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: (RouteSettings settings){
        WidgetBuilder builder;
        switch(settings.name) {
          case '/':
            builder =
                (BuildContext context) => MapaPage();
            //(BuildContext context) => HomePageBeer();

            break;

          case '/Bar':
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

