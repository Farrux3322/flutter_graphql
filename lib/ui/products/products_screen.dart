import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/bloc/products/products_bloc.dart';
import 'package:flutter_graphql/bloc/products/products_state.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Products'),
        backgroundColor: Colors.black,
      centerTitle: true,),
      body: Center(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadInProgress) {
              return const CupertinoActivityIndicator();
            }
            if (state is ProductsLoadSuccess) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Container(
                    padding:const EdgeInsets.all(5),
                    margin:const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow:const [
                        BoxShadow(
                          color:Colors.black,
                          blurRadius: 5
                        )
                      ]
                    ),
                    child: ListTile(
                      onTap: (){},
                      leading:product.image.isNotEmpty? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                          const CupertinoActivityIndicator(),
                          imageUrl: product.image,
                          height: 60,
                          width: 60,
                        ),
                      ):const Icon(Icons.image,size: 60),
                      title: Text(product.name),
                      trailing: Text(product.yearBuilt.toString()),
                      subtitle: Text(product.type),
                    ),
                  );
                },
              );
            }
            return const Text('Oops something went wrong!');
          },
        ),
      ),
    );
  }
}
