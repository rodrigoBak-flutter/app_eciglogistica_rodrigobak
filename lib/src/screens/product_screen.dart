import 'package:flutter/material.dart';
//Paquete de terceros que permite renderizar imagenes
import 'package:image_picker/image_picker.dart';
//Manejador de estados de la aplicacion
import 'package:provider/provider.dart';
//Providers, controlador, validador(verifica que los TextForm esten correctamente completados)
import 'package:app_eciglogistica_rodrigobak/src/providers/product_form_provider.dart';
//Servicios 
import 'package:app_eciglogistica_rodrigobak/src/services/services.dart';
//Widgets
import 'package:app_eciglogistica_rodrigobak/src/widgets/widgets.dart';
//UI de la apliacion
import 'package:app_eciglogistica_rodrigobak/src/ui/input_decorations.dart';


class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white),
                    )),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      final picker = new ImagePicker();
                      final PickedFile? pickedFile = await picker.getImage(
                          source: ImageSource.camera, imageQuality: 100);

                      if (pickedFile == null) {
                        print('No seleccionó nada');
                        return;
                      }

                      productService
                          .updateSelectedProductImage(pickedFile.path);
                    },
                    icon: const Icon(Icons.camera_alt_outlined,
                        size: 40, color: Colors.white),
                  ),
                ),
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;

                final String? imageUrl = await productService.uploadImage();

                if (imageUrl != null) productForm.product.picture = imageUrl;

                await productService.saveOrCreateProduct(productForm.product);
              },
        child: productService.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.categoty,
                onChanged: (value) => product.categoty = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'La categoria es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'categoria del producto',
                    labelText: 'Categoria:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: product.title,
                onChanged: (value) => product.title = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El Titulo es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Titulo del producto', labelText: 'Titulo:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: product.description,
                onChanged: (value) => product.description = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'La descripcion es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'descripcion del producto',
                    labelText: 'Descripcion:'),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
