import 'dart:convert';

import 'package:evaluacion_final_flutter/utils/api_endpoints.dart';
import 'package:evaluacion_final_flutter/widgets/Menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CommentLocationsView extends StatefulWidget {
  @override
  _CommentLocationsViewState createState() => _CommentLocationsViewState();
}

class _CommentLocationsViewState extends State<CommentLocationsView> {
  late List<dynamic> _coordinates = [];

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _getCommentCoordinates();
  }

  Future<void> _getCommentCoordinates() async {
    try {
      final response = await http.get(
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.points.getCoordinates));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        setState(() {
          _coordinates = json['sitios'];
        });
      } else {
        throw Exception('No se pudieron obtener las coordenadas :(');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicaciones de Comentarios'),
      ),
      drawer: MenuDrawer(),
      /**body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ), **/
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-4.0329396, -79.2025477),
              zoom: 13,
            ),
            markers: _coordinates.map((coordinate) {
              final MarkerId markerId = MarkerId(coordinate['external_id']);
              return Marker(
                markerId: markerId,
                position: LatLng(
                  double.parse(coordinate['latitud']),
                  double.parse(coordinate['longitud']),
                ),
                infoWindow: InfoWindow(
                  title: coordinate['tema'], // Nombre que deseas mostrar
                ),
              );
            }).toSet(),
          ),
        ],
      ),
    );
  }
}
