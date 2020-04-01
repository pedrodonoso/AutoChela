

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pub{
  String nombre;
  GeoPoint posicion;
  String imagen;
  var calificacion;
  String hora;
  DocumentSnapshot ref;

  Pub(DocumentSnapshot doc){
    this.ref = doc;
    this.nombre = doc['nombreBar'];
    this.posicion = doc['location'];
    this.imagen = doc['imagen'];
    this.calificacion =doc['calificacion'];
    this.hora= doc['hora'];
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pub &&
              runtimeType == other.runtimeType &&
              nombre == other.nombre &&
              posicion == other.posicion &&
              imagen == other.imagen &&
              ref == other.ref;

  @override
  int get hashCode =>
      nombre.hashCode ^
      posicion.hashCode ^
      imagen.hashCode ^
      ref.hashCode;

  @override
  String toString() {
    return 'Pub{nombre: $nombre, posicion: $posicion, imagen: $imagen}';
  }

  String getCierrePub() {
    return this.hora.split("-")[1];
  }
  String getStatePub() {
    print("HORA: ${this.hora}");
    print(this.hora.split("-"));
    TimeOfDay now = TimeOfDay.now();
    print(now.hour);
    var horas =this.hora.split("-");
    var inicio = int.parse(horas[0].split(":")[0]);
    var fin = int.parse(horas[1].split(":")[0]);
    var nowHour = now.hour;
    var nowMinute = now.minute;
    if((inicio < nowHour) && (fin > nowHour)){
      print("Esta abierto");
      return "Abierto";
    } else {
      return "Cerrado";
    }

  }

}