

import 'package:cloud_firestore/cloud_firestore.dart';

class Beer{
  String nombre;
  String descripcion;
  String imagen;
  var estrellas;
  var precio;
  DocumentSnapshot ref;

  Beer(DocumentSnapshot doc){
    this.ref = doc;
    this.nombre = doc['nombreBeer'];
    this.descripcion = doc['descripcion'];
    this.imagen = doc['image'];
    this.estrellas = doc['estrellas'];
    this.precio = doc['precio'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Beer &&
              runtimeType == other.runtimeType &&
              ref == other.ref;

  @override
  int get hashCode => ref.hashCode;

  @override
  String toString() {
    return 'Beer{nombre: $nombre, estrellas: $estrellas, precio: $precio}';
  }


}