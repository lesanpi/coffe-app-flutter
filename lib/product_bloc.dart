import 'package:flutter/cupertino.dart';

const _initialPage = 7.0;

class ProductBLoC {
  final currentPage = ValueNotifier<double>(_initialPage);
  final textPage = ValueNotifier<double>(_initialPage);

  final pageProductController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );

  final pageTextController = PageController(initialPage: _initialPage.toInt());

  void init() {
    currentPage.value = _initialPage;
    textPage.value = _initialPage;
    pageProductController.addListener(_productScollListener);
    pageTextController.addListener(_pageTextListener);
  }

  void dispose() {
    pageProductController.removeListener(_productScollListener);
    pageTextController.removeListener(_pageTextListener);
    pageProductController.dispose();
    pageTextController.dispose();
  }

  void _productScollListener() {
    currentPage.value = pageProductController.page ?? currentPage.value;
  }

  void _pageTextListener() {
    textPage.value = pageTextController.page ?? textPage.value;
  }
}

class ProductProvider extends InheritedWidget {
  final ProductBLoC bloc;

  ProductProvider({required this.bloc, required Widget child})
      : super(child: child);

  static ProductProvider? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ProductProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
