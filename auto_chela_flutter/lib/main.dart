
import 'package:AutoChela/entity/Beer.dart';
import 'package:AutoChela/src/pages/BarPage.dart';

import 'package:AutoChela/src/PushNotificationProvider.dart';
import 'package:AutoChela/src/pages/BeerDetailsPage.dart';
import 'package:AutoChela/src/pages/MapPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



//void main() => runApp(MyApp());
//void main() => runApp(HomePage());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app =  await FirebaseApp.configure(
      name: "flutterapp13", options: const FirebaseOptions(
    googleAppID: '1:549471011700:android:82831f807983a5cbfd2221',
    apiKey: 'AIzaSyBo7EIUx6BwPlxZBye1bZSUHXa9xrTJjM8',
    databaseURL: 'https://flutterapp13.firebaseio.com',
  ));
  runApp( HomePage(app: app,));
//  final FirebaseDatabase database = FirebaseDatabase(app: app);
}

class HomePage extends StatefulWidget {
  final FirebaseApp app;

  const HomePage({Key key, this.app}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final pushProvider = PushNotificationProvider();
    pushProvider.initNotifications();
  }
  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.amber;
    return MaterialApp(
      title: 'AutoChela',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // primarySwatch: mainColor,
        primaryColor: Palette.primary,
        accentColor: Palette.secundary,
        // backgroundColor: Palette.secundary,
        buttonColor: Palette.secundary,
        primaryColorDark: Palette.primaryDark,
        primaryColorLight: Palette.primaryLight,
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
            if(args is Beer) {
              builder =
                  (BuildContext context) =>
                  BeerDetailsPage(
                      beer: args,
                      app: widget.app
                  );
            }
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//
//    Color mainColor = Colors.amber;
//    return MaterialApp(
//      title: 'AutoChela',
//      debugShowCheckedModeBanner: false,
//
//      theme: ThemeData(
//        primarySwatch: mainColor,
//      ),
////      home: MyHomePage(title: 'Flutter Demo Home Page'),
//      onGenerateRoute: (RouteSettings settings){
//        WidgetBuilder builder;
//        switch(settings.name) {
//          case '/':
//            builder =
//                (BuildContext context) => MapPage();
//            //(BuildContext context) => HomePageBeer();
//
//            break;
//
//          case '/bar':
//            var args = settings.arguments;
//            if(args is DocumentSnapshot) {
//              builder =
//                  (BuildContext context) =>
//                  BarPage(
//                    data: args,
//                  );
//            }
//            break;
//          case '/beerDetails':
//            var args = settings.arguments;
//            if(args is DocumentSnapshot) {
//              builder =
//                  (BuildContext context) =>
//                  BeerDetailsPage(
//                    beer: args,
//                    app: app
//                  );
//            }
//            break;
//        }
//        return MaterialPageRoute(builder: builder, settings: settings);
//      },
//    );
//  }
//}


class Palette {

  static const Color primary = Color(0xFF344955);
  static const Color primaryLight = Color(0xFF5f7481);
  static const Color primaryDark = Color(0xFF0b222c);
  static const Color secundary = Color(0xFFF9a825);
  static const Color secundaryLight = Color(0xFFffd95a);
  static const Color secundaryDark = Color(0xFFc17900);
}