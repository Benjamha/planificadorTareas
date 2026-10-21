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

void guardarTarea(String archivo, List<Tarea> lista) {
  try {
    final arch = File(archivo);
    final buffer = StringBuffer();
    for (var t in lista) {
      int compInt = t.completada ? 1 : 0;
      buffer.writeln("$compInt ${t.prioridad} ${t.titulo}");
    }

    arch.writeAsStringSync(buffer.toString());
  } catch (e) {
    print("No se pudo guardar $archivo");
  }
}

void cargarLista(String archivo, List<String> lista) {
  final arch = File(archivo);
  if (!arch.existsSync()) {
    return;
  }
  List<String> lineas = arch.readAsLinesSync();
  for (String linea in lineas) {
    if (linea.trim().isNotEmpty) {
      lista.add(linea);
    }
  }
}

void guardarLista(String archivo, List<String> lista) {
  try {
    final arch = File(archivo);
    final buffer = StringBuffer();
    for (var el in lista) {
      buffer.writeln(el);
    }
    arch.writeAsStringSync(buffer.toString());
  } catch (e) {
    print("No se pudo guardar $archivo");
  }
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

void cambiarPrioridad(List<Tarea> lista, List<String> listaH) {
  if (lista.isEmpty) {
    print("No hay tareas para cambiar su prioridad");
  } else {
    for (int i = 0; i < lista.length; i++) {
      String estado = lista[i].completada ? "x" : " ";
      print(
        "${i + 1}. [$estado] (${nombrePrioridad(lista[i].prioridad)}) ${lista[i].titulo}",
      );
    }
    print("=====================================");
    while (true) {
      int posicion = validarOpcion(
        "Ingrese tarea a la que quiera cambiar prioridad: ",
      );
      if (posicion > 0 && posicion < lista.length + 1) {
        String anterior = nombrePrioridad(lista[posicion - 1].prioridad);
        int nuevaPrioridad = asignarPrioridad();
        if (confirmar()) {
          lista[posicion - 1].prioridad = nuevaPrioridad;
          String nueva = nombrePrioridad(lista[posicion - 1].prioridad);
          listaH.add(
            "[PRIORIDAD] ${lista[posicion - 1].titulo}: $anterior -> $nueva",
          );
          print("Prioridad actualizada");
          break;
        } else {
          print("Cambio de prioridad cancelado");
          break;
        }
      } else {
        print("La tarea ingresada no existe");
      }
    }
  }
  pausa();
}

void verTareas(List<Tarea> lista) {
  if (lista.isEmpty) {
    print("=====================================");
    print("No hay tareas pendientes");
    print("=====================================");
  } else {
    print("=====================================");
    print("Listado de tareas: ");
    for (int i = 0; i < lista.length; i++) {
      String estado = lista[i].completada ? "x" : " ";
      print(
        "${i + 1}. [$estado] (${nombrePrioridad(lista[i].prioridad)}) ${lista[i].titulo}",
      );
    }
    print("=====================================");
  }
  pausa();
}

void crearTarea(List<Tarea> lista, List<String> listaC) {
  print("=====================================");
  stdout.write("Nueva tarea: ");
  String nuevaTarea = stdin.readLineSync() ?? '';
  if (tituloValido(nuevaTarea)) {
    int prioridad = asignarPrioridad();
    lista.add(Tarea(titulo: nuevaTarea, prioridad: prioridad));
    listaC.add("[CREADO] $nuevaTarea");
    print("Tarea añadida");
    print("=====================================");
  }
  pausa();
}

void eliminarTarea(List<Tarea> lista, List<String> listaE) {
  if (lista.isEmpty) {
    print("No hay tareas para eliminar");
  } else {
    for (int i = 0; i < lista.length; i++) {
      String estado = lista[i].completada ? "x" : " ";
      print(
        "${i + 1}. [$estado] (${nombrePrioridad(lista[i].prioridad)}) ${lista[i].titulo}",
      );
    }
    print("=====================================");
    while (true) {
      int posicion = validarOpcion("Escoge la tarea a eliminar: ");
      if (posicion > 0 && posicion < lista.length + 1) {
        if (confirmar()) {
          listaE.add("[ELIMINADO] ${lista[posicion - 1].titulo}");
          lista.removeAt(posicion - 1);
          print("Tarea eliminada");
        } else {
          print("Eliminacion cancelada");
        }
        break;
      } else {
        print("La tarea ingresada no existe");
      }
    }
  }
  print("=====================================");
  pausa();
}

void modificarTarea(List<Tarea> lista, List<String> listaM) {
  if (lista.isEmpty) {
    print("No hay tareas para modificar");
  } else {
    for (int i = 0; i < lista.length; i++) {
      String estado = lista[i].completada ? "x" : " ";
      print(
        "${i + 1}. [$estado] (${nombrePrioridad(lista[i].prioridad)}) ${lista[i].titulo}",
      );
    }
    print("=====================================");
    while (true) {
      int posicion = validarOpcion("Escoge la tarea a modificar: ");
      if (posicion > 0 && posicion < lista.length + 1) {
        stdout.write("Ingrese la nueva tarea: ");
        String nuevaTarea = stdin.readLineSync() ?? '';
        if (tituloValido(nuevaTarea)) {
          if (confirmar()) {
            listaM.add(
              "[MODIFICADO] ${lista[posicion - 1].titulo} -> $nuevaTarea",
            );
            lista[posicion - 1].titulo = nuevaTarea;
            print("Tarea modificada");
          } else {
            print("Modificacion cancelada");
          }
          break;
        }
      } else {
        print("La tarea ingresada no existe");
      }
    }
  }
  pausa();
}

void completarTarea(List<Tarea> lista, List<String> listaH) {
  if (lista.isEmpty) {
    print("No existen tareas. Crea una para comenzar a interactuar");
  } else {
    for (int i = 0; i < lista.length; i++) {
      String estado = lista[i].completada ? "x" : " ";
      print(
        "${i + 1}. [$estado] (${nombrePrioridad(lista[i].prioridad)}) ${lista[i].titulo}",
      );
    }
    print("=====================================");
    while (true) {
      int posicion = validarOpcion("Escoge la tarea completada: ");
      if (posicion > 0 && posicion < lista.length + 1) {
        if (lista[posicion - 1].completada) {
          print("La tarea seleccionada ya esta completada");
        } else {
          if (confirmar()) {
            lista[posicion - 1].completada = true;
            listaH.add("[COMPLETADO] ${lista[posicion - 1].titulo}");
            print("Tarea marcada como completada");
          }
        }
        break;
      } else {
        print("La tarea ingresada no existe");
      }
    }
  }
  pausa();
}

void verHistorial(List<String> listaH) {
  if (listaH.isEmpty) {
    print("Historial vacio");
  } else {
    print("HISTORIAL");
    for (int i = 0; i < listaH.length; i++) {
      print(listaH[i]);
    }
  }
  pausa();
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
  List<Tarea> tasks = [];
  List<String> historial = [];
  cargarTarea("Tareas.txt", tasks);
  cargarLista("Historial.txt", historial);
  bool salir = false;
  while (!salir) {
    menu();
    int op = validarOpcion("Ingrese una opcion: ");
    switch (op) {
      case 1:
        verTareas(tasks);
        break;

      case 2:
        crearTarea(tasks, historial);
        break;

      case 3:
        eliminarTarea(tasks, historial);
        break;

      case 4:
        modificarTarea(tasks, historial);
        break;

      case 5:
        verHistorial(historial);
        break;

      case 6:
        completarTarea(tasks, historial);
        break;

      case 7:
        cambiarPrioridad(tasks, historial);
        break;

      case 8:
        salir = true;
        break;

      default:
        print("Opcion no valida");
    }
    guardarTarea("Tareas.txt", tasks);
    guardarLista("Historial.txt", historial);
  }
}
