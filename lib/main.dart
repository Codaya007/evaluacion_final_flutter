import 'package:evaluacion_final_flutter/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa el paquete get

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Cambia MaterialApp por GetMaterialApp
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}
