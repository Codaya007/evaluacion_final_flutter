import 'package:flutter/material.dart';
import 'package:evaluacion_final_flutter/screens/auth.dart';
import "package:get/get.dart";

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Navegar a la página principal (Home)
              // Get.off(const HomeScreen());
            },
          ),
          ListTile(
            title: const Text('Salir'),
            onTap: () {
              // Realizar acciones de cierre de sesión, por ejemplo
              Get.back();
              showDialog(
                  context: Get.context!,
                  builder: (context) {
                    return const SimpleDialog(
                      title: Text('Cerrar sesión'),
                      contentPadding: EdgeInsets.all(20),
                      children: [Text("Vuelva pronto usuario")],
                    );
                  });
              Get.off(const AuthScreen());
            },
          ),
        ],
      ),
    );
  }
}
