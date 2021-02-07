import 'dart:convert';
import 'package:coop/models/cuenta.dart';
import 'package:coop/models/respuesta.dart';
import 'package:coop/models/poliza.dart';
import 'package:http/http.dart' as http;

class ServiciosDAO {
  static const String IP = '34.68.88.244';
  //static const String IP = '192.168.56.1';
  static const int PORT = 8080;
  //static const int PORT = 8083;
  static const String ser1 =
      'http://$IP:$PORT/SitemasTransaccional2/restservice/starbank/login';
  static const String ser2 =
      'http://$IP:$PORT/SitemasTransaccional2/restservice/starbank/cambiopassword';
  static const String bus =
      "http://$IP:$PORT/SitemasTransaccional2/restservice/starbank/obtenerCliente";
  static const String ser3 =
      "http://$IP:$PORT/SitemasTransaccional2/restservice/starbank/transferencia";
  static const String ser4 =
      "http://$IP:$PORT/SitemasTransaccional2/restservice/starbank/transferenciaExterna";

  static Future<Respuesta> login(username, password) async {
    http.Response response = await http.post(ser1, body: {
      "username": username,
      "password": password,
    });
    print(response);
    Respuesta res = new Respuesta();
    var cue = json.decode(response.body)["Cuenta"];
    var pols = json.decode(response.body)["Poliza"];
    if (cue != null) {
      res.codigo = json.decode(response.body)["codigo"];
      res.descripcion = json.decode(response.body)["descripcion"];
      Cuenta cuenta = Cuenta.fromJson(cue);
      res.cuenta = cuenta;
      if (pols != null) {
        List<Poliza> polis = new List();
        for (var pol in pols) {
          Poliza poliza = Poliza.fromJson(pol);
          polis.add(poliza);
        }
        res.polizas = polis;
      }
    } else {
      res.codigo = json.decode(response.body)["codigo"];
      res.descripcion = json.decode(response.body)["descripcion"];
    }
    return res;
  }

  static Future<Respuesta> cambioClave(correo, contravieja, contranueva) async {
    http.Response response = await http.post(ser2, body: {
      "correo": correo,
      "contraAntigua": contravieja,
      "contraActual": contranueva,
    });
    Respuesta res = new Respuesta();
    res.codigo = json.decode(response.body)["codigo"];
    res.descripcion = json.decode(response.body)["descripcion"];
    return res;
  }

  static Future<Respuesta> busqueda(numeroCuenta) async {
    final response = await http.get(bus + "?numeroCuenta=$numeroCuenta");
    Respuesta res = new Respuesta();
    var cue = json.decode(response.body)["Cuenta"];
    if (cue != null) {
      Cuenta cuenta = Cuenta.fromJson(cue);
      res.codigo = json.decode(response.body)["codigo"];
      res.descripcion = json.decode(response.body)["descripcion"];
      res.cuenta = cuenta;
    } else {
      res.codigo = json.decode(response.body)["codigo"];
      res.descripcion = json.decode(response.body)["descripcion"];
    }
    return res;
  }

  static Future<Respuesta> transferencia(Map jsonTrans) async {
    var response = await http.post(ser3,
        body: json.encode(jsonTrans),
        headers: {"Content-Type": "application/json"});
    Respuesta res = new Respuesta();
    print(response.body);
    res.codigo = json.decode(response.body)["codigo"];
    res.descripcion = json.decode(response.body)["descripcion"];
    return res;
  }

  static Future<Respuesta> transferenciaExterna(Map jsonTrans) async {
    var response = await http.post(ser4,
        body: json.encode(jsonTrans),
        headers: {"Content-Type": "application/json"});
    Respuesta res = new Respuesta();
    print(response.body);
    res.codigo = json.decode(response.body)["codigo"];
    res.descripcion = json.decode(response.body)["descripcion"];
    return res;
  }
}
