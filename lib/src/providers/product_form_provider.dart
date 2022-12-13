import 'package:flutter/material.dart';
import 'package:app_eciglogistica_rodrigobak/src/models/models.dart';

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey =  GlobalKey<FormState>();

  Product product;

  ProductFormProvider( this.product );

  updateAvailability( bool value ) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }


  bool isValidForm() {

    print( product.title );
    print( product.categoty );
    print( product.available );

    return formKey.currentState?.validate() ?? false;
  }

}