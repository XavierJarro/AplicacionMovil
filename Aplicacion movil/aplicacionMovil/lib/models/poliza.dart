class Poliza {
  int codigo;
  String estado;
  double monto;
  double tasa;
  double interes;
  DateTime fechaRegistro;
  DateTime fechaVencimiento;

  int get getCodigo => codigo;

  set setCodigo(int codigo) => this.codigo = codigo;

  String get getEstado => estado;

  set setEstado(String estado) => this.estado = estado;

  double get getMonto => monto;

  set setMonto(double monto) => this.monto = monto;

  double get getTasa => tasa;

  set setTasa(double tasa) => this.tasa = tasa;

  double get getInteres => interes;

  set setInteres(double interes) => this.interes = interes;

  DateTime get getFechaRegistro => fechaRegistro;

  set setFechaRegistro(DateTime fechaRegistro) =>
      this.fechaRegistro = fechaRegistro;

  DateTime get getFechaVencimiento => fechaVencimiento;

  set setFechaVencimiento(DateTime fechaVencimiento) =>
      this.fechaVencimiento = fechaVencimiento;

  Poliza.fromJson(Map<String, dynamic> json)
      : codigo = json['codigoPol'],
        estado = json['estado'],
        tasa = json['tasa'],
        monto = json['monto'],
        interes = json['interes'],
        fechaRegistro =
            DateTime.fromMillisecondsSinceEpoch(json['fechaRegistro']),
        fechaVencimiento =
            DateTime.fromMillisecondsSinceEpoch(json['fechaVencimiento']);
}
