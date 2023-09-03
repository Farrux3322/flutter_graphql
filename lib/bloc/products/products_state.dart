import 'package:flutter_graphql/api/models/product_model.dart';

abstract class ProductsState {}

class ProductsLoadInProgress extends ProductsState {}

class ProductsLoadSuccess extends ProductsState {
  ProductsLoadSuccess(this.products);

  final List<ProductModel> products;
}

class ProductsLoadFailure extends ProductsState {}