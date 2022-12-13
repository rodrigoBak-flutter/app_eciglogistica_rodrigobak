import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_eciglogistica_rodrigobak/src/models/models.dart';
import 'package:app_eciglogistica_rodrigobak/src/screens/screens.dart';

import 'package:app_eciglogistica_rodrigobak/src/services/services.dart';
import 'package:app_eciglogistica_rodrigobak/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test - Eciglogistica'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                productsService.deleteAllProduct(
                  Product(
                    title: '',
                    description: '',
                    categoty: '',
                  ),
                );
                productsService.refreshProducts();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.lightGreen,
        strokeWidth: 3,
        displacement: 10,
        edgeOffset: 0,
        onRefresh: productsService.refreshProducts,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: productsService.products.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Eliminar'),
                                onTap: () {
                                  productsService.deleteProduct(
                                      productsService.products[index]);
                                  productsService.refreshProducts();
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.update_outlined),
                                title: Text('Actualizar'),
                                onTap: () {
                                  productsService.selectedProduct =
                                      productsService.products[index].copy();
                                  Navigator.pushNamed(context, 'product');
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: ProductCard(
                    product: productsService.products[index],
                  ),
                )),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = Product(
            title: '',
            description: '',
            categoty: '',
          );
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
