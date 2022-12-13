import 'package:flutter/material.dart';

//Screens
import 'package:app_eciglogistica_rodrigobak/src/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (BuildContext context) => HomeScreen(),
  'product': (BuildContext context) => ProductScreen(),
};
