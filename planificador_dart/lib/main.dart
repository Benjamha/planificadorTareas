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
            Container(width: 220, color: Colors.blueGrey.shade100),
            const Expanded(
              child: Center(child: Text('Planificador de Tareas')),
            ),
          ],
        ),
      ),
    );
  }
}
