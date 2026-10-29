import 'dart:io';

class Tarea {
  String titulo;
  bool completada;
  int prioridad;

  Tarea({
    required this.titulo,
    this.completada = false,
    required this.prioridad,
  });
}

class Usuario {
  String user;
  String pass;
  String mail;

  Usuario({required this.user, required this.pass, required this.mail});
}
