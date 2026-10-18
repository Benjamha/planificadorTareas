import 'dart:io';

class Tarea {
  String titulo;
  bool completada;
  int prioridad;

  Tarea({required this.titulo, this.completada = false, this.prioridad = 1});
}

bool login() {
  print('LOGIN');
  for (int i = 0; i < 3; i++) {
    stdout.write('Usuario: ');
    String u = stdin.readLineSync() ?? '';
    stdout.write('Clave: ');
    String p = stdin.readLineSync() ?? '';
    if (u == 'admin' && p == '1234') {
      print('INICIO DE SESION CORRECTO');
      return true;
    } else {
      print('Usuario/Clave incorrecto/s');
    }
  }
  print('Limite de intentos alcanzado');
  return false;
}
