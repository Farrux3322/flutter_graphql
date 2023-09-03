import 'package:flutter_graphql/api/models/product_model.dart';
import 'package:flutter_graphql/api/queries/get_products_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetProductsRequestFailure implements Exception{}

class ProductApiClient{
  const ProductApiClient({required this.graphQLClient});

  final GraphQLClient graphQLClient;

  factory ProductApiClient.create() {
    final httpLink = HttpLink('https://spacex-production.up.railway.app/');
    final link = Link.from([httpLink]);

    return ProductApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  Future<List<ProductModel>> getProducts() async {
    final result = await graphQLClient.query(
      QueryOptions(document: gql(getProductsQuery)),
    );

    if (result.hasException) throw GetProductsRequestFailure();
    return (result.data?['ships'] as List?)
        ?.map((dynamic e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [];
  }

}