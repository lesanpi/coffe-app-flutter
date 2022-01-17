import 'package:flutter/material.dart';
import 'package:burguers_app/products_page_list.dart';
import 'package:burguers_app/product.dart';

class ProductHome extends StatelessWidget {
  const ProductHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          // print("Details ${details.primaryDelta}");
          if (details.primaryDelta! < -10) {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, _) {
                return FadeTransition(
                  opacity: animation,
                  child: ProductsListPage(),
                );
              },
            ));
          }
        },
        child: Stack(
          children: [
            Positioned(
              child: SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFA89276), Colors.white],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.3,
              left: 0,
              right: 0,
              top: size.height * 0.2,
              child: Hero(
                tag: "8", //products[10].name,
                child: Image.asset(
                  products[8].image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.4,
              left: 0,
              right: 0,
              top: size.height * 0.3,
              child: Hero(
                tag: "10", //products[10].name,
                child: Image.asset(
                  products[10].image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.62,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: products[7].name,
                child: Image.asset(
                  products[7].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.9,
              left: 0,
              right: 0,
              bottom: -size.height * 0.7,
              child: Hero(
                tag: "0", //products[0].name,
                child: Image.asset(
                  products[0].image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              height: 140,
              left: 0,
              right: 0,
              bottom: size.height * 0.25,
              child: Image.asset('assets/images/logo.png'),
            )
          ],
        ),
      ),
    );
  }
}
