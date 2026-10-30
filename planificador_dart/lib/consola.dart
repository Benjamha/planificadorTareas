import 'dart:io';

import 'clases.dart';

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

int validarOpcion(String mensaje) {
  while (true) {
    stdout.write(mensaje);
    String entrada = stdin.readLineSync() ?? '';
    int? n = int.tryParse(entrada);
    if (n != null) {
      return n;
    } else {
      print("Debes ingresar un numero valido");
    }
  }
}

bool tituloValido(String titulo) {
  if (titulo.trim().isNotEmpty) {
    return true;
  }
  print("El titulo ingresado no es valido");
  return false;
}

bool confirmar() {
  while (true) {
    stdout.write("¿Estas seguro? y/n");
    String conf = stdin.readLineSync() ?? '';
    if (conf.isEmpty) {
      continue;
    }
    conf = conf.toLowerCase();
    if (conf == "y") {
      return true;
    } else if (conf == "n") {
      return false;
    } else {
      print("Ingresar 'y' como si o 'n' como no");
    }
  }
}

String nombrePrioridad(int p) {
  if (p == 3) {
    return "Alta";
  } else if (p == 2) {
    return "Media";
  } else {
    return "Baja";
  }
}

int asignarPrioridad() {
  while (true) {
    int p = validarOpcion(
      "Asignar prioridad (1 = Baja, 2 = Media, 3 = Alta): ",
    );
    if (p >= 1 && p <= 3) {
      return p;
    }
    print("La prioridad puede ser unicamente de 1, 2 o 3");
  }
}

void menu() {
  print("=====================================");
  print("PLANIFICADOR DE TAREAS");
  print("1. Ver Tareas");
  print("2. Crear Tarea");
  print("3. Eliminar Tarea");
  print("4. Modificar Tarea");
  print("5. Ver historial");
  print("6. Marcar tarea como completada");
  print("7. Cambiar prioridad");
  print("8. Salir");
  print("=====================================");
}

void main() {
  if (!login()) {
    exit(0);
  }

  gestorTarea gestiones = gestorTarea();
  gestiones.cargarTarea();
  gestiones.cargarLista();

  bool salir = false;
  while (!salir) {
    menu();
    int op = validarOpcion("Ingrese una opcion: ");
    switch (op) {
      case 1:
        gestiones.verTareas();
        break;

      case 2:
        gestiones.crearTarea();
        break;

      case 3:
        gestiones.eliminarTarea();
        break;

      case 4:
        gestiones.modificarTarea();
        break;

      case 5:
        gestiones.verHistorial();
        break;

      case 6:
        gestiones.completarTarea();
        break;

      case 7:
        gestiones.cambiarPrioridad();
        break;

      case 8:
        salir = true;
        break;

      default:
        print("Opcion no valida");
    }
    gestiones.guardarTarea();
    gestiones.guardarLista();
  }
}
