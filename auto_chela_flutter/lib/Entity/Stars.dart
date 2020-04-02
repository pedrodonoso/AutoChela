



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Stars extends StatefulWidget {
  final double  numero;
  const Stars({Key key, this.numero}) : super(key: key);
  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  @override
  Widget build(BuildContext context) {
    List<int> stars;
    stars = [0,0,0,0,0,0];
    var i = widget.numero;

    if ((i%0.5) == 0) {
      i = i;
    }
    else if((i.ceil() - i.roundToDouble()) ==1)  {//i=3.4

      i = i.floor().floorToDouble();
    } else {//i=3.6
      i=i.ceil().ceilToDouble();
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize:  MainAxisSize.max,
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

