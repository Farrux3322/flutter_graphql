import 'package:flutter_graphql/api/api.dart';
import 'package:flutter_graphql/bloc/products/products_event.dart';
import 'package:flutter_graphql/bloc/products/products_state.dart';
import 'package:bloc/bloc.dart';
class ProductsBloc extends Bloc<ProductsEvent,ProductsState>{

  ProductsBloc({required  ProductApiClient productApiClient}):_productApiClient=productApiClient,
  super(ProductsLoadInProgress()){
    on<ProductsFetchStarted>(_onProductsFetchStarted);
  }

  final ProductApiClient _productApiClient;

  Future<void> _onProductsFetchStarted(
      ProductsFetchStarted event,
      Emitter<ProductsState> emit,
      ) async {
    emit(ProductsLoadInProgress());
    try {
      final products = await _productApiClient.getProducts();
      emit(ProductsLoadSuccess(products));
    } catch (error) {
      print("ERRROR:$error");
      emit(ProductsLoadFailure());
    }
  }

}