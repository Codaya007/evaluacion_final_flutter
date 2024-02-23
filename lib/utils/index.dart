import 'package:evaluacion_final_flutter/utils/api_endpoints.dart';

class Utils {
  static String replaceBaseUrl(String url) {
    return url.replaceAll('http://localhost:3000', ApiEndPoints.baseUrl);
  }

  static bool esCorreoValido(String correo) {
    // Expresión regular para validar una dirección de correo electrónico
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Verificar si la cadena de texto coincide con la expresión regular
    return regex.hasMatch(correo);
  }
}
