class ApiEndPoints {
  static final String baseUrl = 'http://10.20.139.221:3041/api';

  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static _PointsEndPoints crudsEndpoints = _PointsEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = '/registro';
  final String loginEmail = '/autenticar';
}

class _PointsEndPoints {
  final String getCoordinates = '/listado/nro_guia';
}
