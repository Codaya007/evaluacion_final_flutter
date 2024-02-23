import 'dart:convert';

import 'package:evaluacion_final_flutter/screens/home_locations.dart';
import 'package:evaluacion_final_flutter/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);

      // Valido usuario
      String email = emailController.text.trim();
      String clave = passwordController.text;

      if (email.isEmpty) {
        throw "El correo es requerido";
      }

      if (clave.isEmpty) {
        throw "La contraseña es requerida";
      }

      Map body = {'usuario': email, 'clave': clave};
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (json['code'] == "200") {
          var token = json['token'];
          var username = json['username'];
          var correo = json['correo'];

          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          await prefs.setString('username', username);
          await prefs.setString('correo', correo);

          emailController.clear();
          passwordController.clear();

          Get.off(CommentLocationsView());

          showDialog(
              context: Get.context!,
              builder: (context) {
                return const SimpleDialog(
                  title: Text('Bienvenido'),
                  contentPadding: EdgeInsets.all(20),
                  children: [Text("Bienvenido usuario")],
                );
              });
        } else {
          throw json['msg'];
        }
      } else {
        throw jsonDecode(response.body)["msg"] ?? "Credenciales incorrectas";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
