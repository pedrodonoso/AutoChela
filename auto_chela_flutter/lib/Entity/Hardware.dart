
class Hardware {

  int total;
  int pedido;
  String conectado;
  String estado;
  String hash_usr;
  String error;

  static const String PROCESANDO = "procesando";
  static const String procesado = "procesado";
  static const String esperando = "esperando";
  
  Hardware(this.total,this.conectado,this.estado,this.pedido,this.hash_usr);




  Hardware.fromJson(Map<dynamic, dynamic> json) 
    : total = json['total'],
      conectado = json['conectado'],
      estado = json['estado'],
      pedido = json['pedido'],
      hash_usr = json['hash-usr'];


  Map<String, dynamic> toJson() =>
  {
    'total' : total,
    'pedido' : pedido,
    'estado' : estado,
    'conectado' : conectado,
    'hash-usr' : hash_usr
  };
}