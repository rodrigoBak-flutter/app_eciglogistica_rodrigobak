// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

//Modelo
import 'package:app_eciglogistica_rodrigobak/src/models/models.dart';


//Validador, cumple la funcion de verificar que los campos esten completos
class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  bool isValidForm() {
    print(product.title);
    print(product.categoty);
    print(product.description);
    print(product.picture);
    return formKey.currentState?.validate() ?? false;
  }
}
