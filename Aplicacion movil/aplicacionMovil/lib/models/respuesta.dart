import 'package:coop/models/poliza.dart';
import 'package:coop/models/cuenta.dart';

class Respuesta {
  int codigo;
  String descripcion;
  Cuenta cuenta;
  List<Poliza> polizas;

 int get getCodigo => codigo;

 set setCodigo(int codigo) => this.codigo = codigo;

 String get getDescripcion => descripcion;

 set setDescripcion(String descripcion) => this.descripcion = descripcion;

 Cuenta get getCuenta => cuenta;

  set setCuenta(Cuenta cuenta) => this.cuenta = cuenta;

 List get getPolizas => polizas;

 set setPolizas(List<Poliza> polizas) => this.polizas = polizas;

}
