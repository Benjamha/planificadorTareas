import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              color: Colors.blueGrey.shade100,
              child: SizedBox(
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Planificador',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.add_task),
                      title: const Text('Crear tarea'),
                      onTap: () => debugPrint('Crear tarea'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Eliminar tarea'),
                      onTap: () => debugPrint('Eliminar tarea'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Modificar tarea'),
                      onTap: () => debugPrint('Modificar tarea'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.check_circle_outline),
                      title: const Text('Marcar completada'),
                      onTap: () => debugPrint('Marcar completada'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.flag),
                      title: const Text('Cambiar prioridad'),
                      onTap: () => debugPrint('Cambiar prioridad'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text('Ver historial'),
                      onTap: () => debugPrint('Ver historial'),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: Center(child: Text('Planificador de Tareas')),
            ),
          ],
        ),
      ),
    );
  }
}
