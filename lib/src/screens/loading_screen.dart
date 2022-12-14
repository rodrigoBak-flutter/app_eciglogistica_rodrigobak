import 'package:flutter/material.dart';

/*
  Este widget contiene un Loading, lo que le indica al usuario que debe esperar
  hasta que el backend le responda a nuestra aplicacion y asi poder ver el contenido

 */

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Products'),
      ),
      body:const Center(
        child: CircularProgressIndicator(
          color: Colors.lightGreen,
        ),
     ),
   );
  }
}