class Cliente {
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String telefono1;
  String telefono2;
  String correo;
  String usuario;
  String clave;
  int contador;
  String estado;

  String get getCedula => cedula;

  set setCedula(String cedula) => this.cedula = cedula;

  String get getNombre => nombre;

  set setNombre(String nombre) => this.nombre = nombre;

  String get getApellido => apellido;

  set setApellido(String apellido) => this.apellido = apellido;

  String get getDireccion => direccion;

  set setDireccion(String direccion) => this.direccion = direccion;

  String get getTelefono1 => telefono1;

  set setTelefono1(String telefono1) => this.telefono1 = telefono1;

  String get getTelefono2 => telefono2;

  set setTelefono2(String telefono2) => this.telefono2 = telefono2;

  String get getCorreo => correo;

  set setCorreo(String correo) => this.correo = correo;

  String get getUsuario => usuario;

  set setUsuario(String usuario) => this.usuario = usuario;

  String get getClave => clave;

  set setClave(String clave) => this.clave = clave;

  String get getEstado => estado;

  set setEstado(String estado) => this.estado = estado;

  int get getContador => contador;

  set setContador(int contador) => this.contador = contador;

  String toString() {
    return cedula + " " + nombre + " " + apellido;
  }

  Cliente.fromJson(Map<String, dynamic> json)
      : cedula = json['cedula'],
        nombre = json['nombre'],
        apellido = json['apellido'],
        correo = json['correo'],
        direccion = json['direccion'],
        telefono1 = json['telefono1'],
        telefono2 = json['telefono2'],
        clave = json['clave'],
        usuario = json['usuario'],
        contador = json['contador'],
        estado = json['estado'];
}
