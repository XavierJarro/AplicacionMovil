import 'package:coop/main.dart';
import 'package:coop/models/poliza.dart';
import 'package:coop/models/respuesta.dart';
import 'package:coop/view/trexterna.dart';
import 'package:coop/view/trinterna.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cambio.dart';

class Resumen extends StatelessWidget {
  Resumen(this.respuesta);
  final Respuesta respuesta;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(title: 'CUENTA', respuesta: respuesta),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title, this.respuesta}) : super(key: key);
  final String title;
  final Respuesta respuesta;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _select(value) {
    if (value == 0)
      setState(() {
        sesion = false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      });
  }

  String transformar(fecha) {
    var nFecha = fecha.toString().split(" ")[0].split("-");
    return nFecha[2] + "/" + nFecha[1] + "/" + nFecha[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
          title: Text("Estado"),
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: _select,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 7.0,
                      ),
                      Text("LOG OUT"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 90.0,
                child: DrawerHeader(
                  child: Text(
                    'Servicios',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent[50],
                  ),
                ),
              ),
              ListTile(
                title: Text('Estado'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Cambio de Contraseña'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Cambio(widget.respuesta)));
                },
              ),
              ListTile(
                title: Text('Transferencia Interna'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrInterna(widget.respuesta)));
                },
              ),
              ListTile(
                title: Text('Transferencia Externa'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrExterna(widget.respuesta)));
                },
              ),
            ],
          ),
        ),
        body: paginaPrincipal(),
      ),
    );
  }

  Widget paginaPrincipal() {
    final double saldo = widget.respuesta.cuenta.saldo;
    void _item(int which) {
      Poliza pol;
      for (var item in widget.respuesta.polizas) {
        if (item.codigo == which) {
          pol = item;
        }
      }
    }

    List<ListTile> _polizas() {
      var list = List<ListTile>();
      for (var each in widget.respuesta.polizas) {
        list.add(ListTile(
          title: Text(
            'Código: ' + each.codigo.toString(),
            style: new TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Registro: " + transformar(each.fechaRegistro),
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              Text(
                "Vencimiento: " + transformar(each.fechaVencimiento),
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              Text("Estado: " + each.estado,
                  style: TextStyle(fontSize: 15.0, color: Colors.black)),
              Text("Monto: " + each.monto.toString(),
                  style: TextStyle(fontSize: 15.0)),
              Text("Tasa: " + each.tasa.toString() + "%",
                  style: TextStyle(fontSize: 15.0)),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[],
          ),
        ));
      }
      return list;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent[50],
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Cuenta",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            widget.respuesta.cuenta.numero,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: 200.0,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Icon(
                    Icons.monetization_on,
                    size: 60.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("$saldo",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent[100],
              shape: BoxShape.circle,
              border: Border.all(width: 5.0, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            widget.respuesta.cuenta.cliente.nombre +
                " " +
                widget.respuesta.cuenta.cliente.apellido,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "POLIZAS",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            height: 200.0,
            width: 450.0,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent[50],
              border: Border.all(width: 2.5, color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              children: ListTile.divideTiles(
                context: context,
                tiles: _polizas(),
              ).toList(),
            ),
          ),
        ],
      )),
    );
  }
}
