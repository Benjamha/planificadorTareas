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
  List<String> lineas = arch.readAsLinesSync();
  for (String linea in lineas) {
    String lineaLimpia = linea.trim();
    if (lineaLimpia.isEmpty) {
      continue;
    }
    List<String> partes = lineaLimpia.split(RegExp(r'\s+'));
    if (partes.length >= 3) {
      bool completada = partes[0] == '1' || partes[0].toLowerCase() == 'true';
      int prioridad = int.tryParse(partes[1]) ?? 0;
      String titulo = partes.sublist(2).join(' ');
      Tarea t = Tarea(
        titulo: titulo,
        completada: completada,
        prioridad: prioridad,
      );
      lista.add(t);
    }
  }
}

void guardarTarea(String archivo, List<Tarea> lista) {}
