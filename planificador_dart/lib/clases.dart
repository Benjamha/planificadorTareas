import 'dart:io';

import 'consola.dart';

class Tarea {
  String titulo;
  bool completada;
  int prioridad;

  Tarea({required this.titulo, this.completada = false, this.prioridad = 2});

  bool tituloValido() {
    if (titulo.trim().isNotEmpty) {
      return true;
    }
    print("El titulo ingresado no es valido");
    return false;
  }

  String nombrePrioridad() {
    if (prioridad == 3) {
      return "Alta";
    } else if (prioridad == 2) {
      return "Media";
    } else {
      return "Baja";
    }
  }

  int asignarPrioridad() {
    while (true) {
      prioridad = validarOpcion(
        "Asignar prioridad (1 = Baja, 2 = Media, 3 = Alta): ",
      );
      if (prioridad >= 1 && prioridad <= 3) {
        return prioridad;
      }
      print("La prioridad puede ser unicamente de 1, 2 o 3");
    }
  }
}

class gestorTarea {
  final List<Tarea> lista = [];
  final List<String> historial = [];
  final String archivoLista = 'tareas.txt';
  final String archivoHistorial = 'historial.txt';

  void cargarTarea() {
    final arch = File(archivoLista);
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

  void guardarTarea() {
    try {
      final arch = File(archivoLista);
      final buffer = StringBuffer();
      for (var t in lista) {
        int compInt = t.completada ? 1 : 0;
        buffer.writeln("$compInt ${t.prioridad} ${t.titulo}");
      }

      arch.writeAsStringSync(buffer.toString());
    } catch (e) {
      print("No se pudo guardar $archivoLista");
    }
  }

  void cargarLista() {
    final arch = File(archivoHistorial);
    if (!arch.existsSync()) {
      return;
    }
    List<String> lineas = arch.readAsLinesSync();
    for (String linea in lineas) {
      if (linea.trim().isNotEmpty) {
        historial.add(linea);
      }
    }
  }

  void guardarLista() {
    try {
      final arch = File(archivoHistorial);
      final buffer = StringBuffer();
      for (var el in historial) {
        buffer.writeln(el);
      }
      arch.writeAsStringSync(buffer.toString());
    } catch (e) {
      print("No se pudo guardar $archivoHistorial ");
    }
  }

  void cambiarPrioridad() {
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
            historial.add(
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

  void verTareas() {
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

  void crearTarea() {
    print("=====================================");
    stdout.write("Nueva tarea: ");
    String nuevaTarea = stdin.readLineSync() ?? '';
    if (tituloValido(nuevaTarea)) {
      int prioridad = asignarPrioridad();
      lista.add(Tarea(titulo: nuevaTarea, prioridad: prioridad));
      historial.add("[CREADO] $nuevaTarea");
      print("Tarea añadida");
      print("=====================================");
    }
    pausa();
  }

  void eliminarTarea() {
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
            historial.add("[ELIMINADO] ${lista[posicion - 1].titulo}");
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

  void modificarTarea() {
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
              historial.add(
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

  void completarTarea() {
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
              historial.add("[COMPLETADO] ${lista[posicion - 1].titulo}");
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

  void verHistorial() {
    if (historial.isEmpty) {
      print("Historial vacio");
    } else {
      print("HISTORIAL");
      for (int i = 0; i < historial.length; i++) {
        print(historial[i]);
      }
    }
    pausa();
  }
}

class Usuario {
  String user;
  String pass;
  String mail;

  Usuario({required this.user, required this.pass, required this.mail});
}
