import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/api/api.dart';
import 'package:flutter_graphql/bloc/products/products_bloc.dart';
import 'package:flutter_graphql/bloc/products/products_event.dart';
import 'package:flutter_graphql/ui/products/products_screen.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp(productApiClient: ProductApiClient.create()));

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.productApiClient});

  final ProductApiClient productApiClient;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductsBloc(
            productApiClient: productApiClient,
          )..add(ProductsFetchStarted()),
        ),
        // BlocProvider(
        //   create: (_) => SingleCountryBloc(jobsApiClient: jobsApiClient),
        // ),
      ],
      child: GraphQLProvider(
        client: ValueNotifier(ProductApiClient.create().graphQLClient),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductsScreen(),
        ),
      ),
    );
  }
}
