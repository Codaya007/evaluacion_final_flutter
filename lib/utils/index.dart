import 'package:evaluacion_final_flutter/utils/api_endpoints.dart';

class Utils {
  static String replaceBaseUrl(String url) {
    return url.replaceAll('http://localhost:3000', ApiEndPoints.baseUrl);
  }
}
