import 'dart:convert';

import 'package:evaluacion_final_flutter/utils/api_endpoints.dart';
import 'package:evaluacion_final_flutter/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail);
      String nombres = nameController.text;
      String correo = emailController.text.trim();
      String clave = passwordController.text;

      if (nombres.isEmpty) {
        throw "Ingrese sus nombres";
      }
      if (correo.isEmpty) {
        throw "El correo es requerido";
      }
      if (Utils.esCorreoValido(correo) == false) {
        throw "El correo no es válido";
      }
      if (clave.isEmpty) {
        throw "Contraseña requerida";
      }

      Map body = {'nombre': nombres, 'correo': correo, 'clave': clave};

      print(body);

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['code'] == "200") {
          nameController.clear();
          emailController.clear();
          passwordController.clear();

          // Get.off(HomeScreen());
          showDialog(
              context: Get.context!,
              builder: (context) {
                return const SimpleDialog(
                  title: Text('Bienvenido'),
                  contentPadding: EdgeInsets.all(20),
                  children: [Text("Inicie sesión para continuar")],
                );
              });
        } else {
          print("No es code = 200");
          throw jsonDecode(response.body)["msg"] ?? "Algo salió mal";
        }
      } else {
        print("No es statusCode 200");
        throw jsonDecode(response.body)["msg"] ?? "Algo salió mal";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
