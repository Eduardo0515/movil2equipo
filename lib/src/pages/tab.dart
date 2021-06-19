import 'package:flutter/material.dart';
import 'package:prueba_cerrada/src/pages/login.dart';

class TabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Cerrar sesión',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
            backgroundColor: Color.fromRGBO(0, 176, 70, 69),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Carrusel",
                ),
                Tab(
                  text: "Lista",
                ),
                Tab(
                  text: "Registro",
                ),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ));
  }
}
