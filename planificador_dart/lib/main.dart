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

void pausa() {
  stdout.write('Presiona Enter para regresar al menu');
  stdin.readLineSync();
}

void cargarTarea(String archivo, List<Tarea> lista) {
  final arch = File(archivo);
  if (!arch.existsSync()) {
    return;
  }
  String contenido = arch.readAsStringSync();
  List<String> tokens = contenido
      .split(RegExp(r'\s+'))
      .where((t) => t.isEmpty)
      .toList();
  int i = 0;
  while (i + 1 < tokens.length) {
    Tarea t = Tarea(titulo: '');
    t.completada = tokens[i] == '1' || tokens[i].toLowerCase() == 'true';
    i++;
    t.prioridad = int.tryParse(tokens[i]) ?? 0;
    i++;
    if (i < tokens.length) {
      t.titulo = tokens[i];
      i++;
    }
    lista.add(t);
  }
}
