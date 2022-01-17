import 'package:burguers_app/product.dart';
import 'package:burguers_app/product_bloc.dart';
import 'package:burguers_app/product_details.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  void initState() {
    final bloc = ProductProvider.of(context)!.bloc;
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = ProductProvider.of(context)!.bloc;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<double>(
              valueListenable: bloc.currentPage,
              builder: (context, currentPage, _) {
                return Transform.scale(
                  scale: 1.6,
                  alignment: Alignment.bottomCenter,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      if (value < products.length) {
                        bloc.pageTextController.animateToPage(value,
                            duration: _duration, curve: Curves.easeOut);
                      }
                    },
                    controller: bloc.pageProductController,
                    scrollDirection: Axis.vertical,
                    itemCount: products.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox.shrink();
                      }

                      final product = products[index - 1];
                      final result = currentPage - index + 1;
                      final sizeScale = -0.4 * result + 1;
                      final opacity = sizeScale.clamp(0.0, 1.0);

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (context, animation, _) {
                              return FadeTransition(
                                opacity: animation,
                                child: ProductDetailsPage(product: product),
                              );
                            },
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..translate(0.0,
                                  size.height / 2.6 * (1 - sizeScale).abs())
                              ..scale(sizeScale),
                            child: Opacity(
                              opacity: opacity,
                              child: Hero(
                                tag: product.name,
                                child: Image.asset(
                                  product.image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 110,
            child: ProductHeader(),
          ),
        ],
      ),
    );
  }
}

class ProductHeader extends StatelessWidget {
  ProductHeader();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bloc = ProductProvider.of(context)!.bloc;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, -100 * value),
          child: child,
        );
      },
      child: ValueListenableBuilder<double>(
          valueListenable: bloc.textPage,
          builder: (context, textPage, _) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: products.length,
                    controller: bloc.pageTextController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final opacity =
                          (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                      return Opacity(
                        opacity: opacity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.2,
                          ),
                          child: Text(
                            products[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedSwitcher(
                  duration: _duration,
                  child: Text(
                    '\$${products[textPage.toInt()].price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                    key: Key(products[textPage.toInt()].name),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
