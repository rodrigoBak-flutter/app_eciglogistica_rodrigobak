import 'package:flutter/material.dart';

//Manejador de estado de la aplicaciones
import 'package:provider/provider.dart';
//Services
import 'package:app_eciglogistica_rodrigobak/src/services/services.dart';

//Rutas
import 'package:app_eciglogistica_rodrigobak/src/routes/routes.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductsService())],
      child: MyApp(),
    );
  }
}

//Este Widget le da inicio a la aplicacion
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test - Eciglogistica',
      //Hacia donde se dirige mi apliacion al iniciarse
      initialRoute: 'home',
       //Todas las rutas que pueda utilizar la aplicacion agrupadas en un mapa
      routes: appRoutes,
      //Tema que va a manejar por defecto mi aplicacion
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(elevation: 0, color: Colors.lightGreen),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.lightGreen, elevation: 0),
      ),
    );
  }
}
