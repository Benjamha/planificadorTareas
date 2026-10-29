import 'dart:io';

class Tarea {
  String titulo;
  bool completada;
  int prioridad;

  Tarea({required this.titulo, this.completada = false, this.prioridad = 2});

  String get nombrePrioridad {
    if (prioridad == 3) {
      return "Alta";
    } else if (prioridad == 2) {
      return "Media";
    } else {
      return "Baja";
    }
  }
}

class gestorTarea {
  final List<Tarea> lista = [];
  final List<String> historial = [];
  final String archivoLista = 'tareas.txt';
  final String archivoHistorial = 'historial.txt';
}

class Usuario {
  String user;
  String pass;
  String mail;

  Usuario({required this.user, required this.pass, required this.mail});
}
