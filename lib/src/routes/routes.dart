import 'package:flutter/material.dart';

//Screens
import 'package:app_eciglogistica_rodrigobak/src/screens/screens.dart';

/*
  De esta manera puedo manejar todas las rutas con la que mi apliacion cuenta,
  me permite tener una previa de las diferentes pantallas con las que cuento
 */

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (BuildContext context) => HomeScreen(),
  'product': (BuildContext context) => ProductScreen(),
};
