import 'package:burguers_app/product_bloc.dart';
import 'package:burguers_app/products_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(ProductApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top],
    );

    return ProductApp();
  }
}

class ProductApp extends StatefulWidget {
  ProductApp({Key? key}) : super(key: key);

  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  final bloc = ProductBLoC();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top],
    );

    return Theme(
      data: ThemeData.light(),
      child: ProductProvider(
        bloc: bloc,
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductHome(),
        ),
      ),
    );
  }
}
