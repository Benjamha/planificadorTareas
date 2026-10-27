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
          children: [
            Container(width: 220, height: 100, color: Colors.blueGrey.shade100),
            const Expanded(
              child: Center(child: Text('Planificador de Tareas')),
            ),
          ],
        ),
      ),
    );
  }
}
