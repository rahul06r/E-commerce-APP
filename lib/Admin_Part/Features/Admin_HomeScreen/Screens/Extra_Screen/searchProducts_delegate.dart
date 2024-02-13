import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProductsDelegate extends SearchDelegate {
  final WidgetRef ref;
  // const SearchDeatils({super.key});
  SearchProductsDelegate(this.ref);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close)),
    ];
    // throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
    // return IconButton(
    //     onPressed: () {
    //       Navigator.pop(context);
    //     },
    //     icon: const Icon(Icons.));

    // TODO: implement buildLeading
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return ref.watch(searchProductsProvider(query)).when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No Product found"),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final product = data[index];
                return ListTile(
                  isThreeLine: true,
                  subtitle: Text("₹ ${product.pr_ammount.toString()}"),
                  onTap: () {},
                  title: Text(
                    product.pr_name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Pallete.redColor,
                    backgroundImage:
                        CachedNetworkImageProvider(product.pr_img[0]),
                  ),
                );
              },
            );
          }
        },
        error: (error, stacktrace) => ErrorText(errorMessage: error.toString()),
        loading: () => const Loader());

    // check once all done

    // TODO: implement buildResults
    // return const SizedBox(
    //     // child: Text("data"),
    //     );
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // throw UnimplementedError();

    //

    // #$%^&*()(*%$##########################)
    return ref.watch(searchProductsProvider(query)).when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No Product found"),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final product = data[index];
                return ListTile(
                  isThreeLine: true,
                  subtitle: Text("₹ ${product.pr_ammount.toString()}"),
                  onTap: () {},
                  title: Text(
                    product.pr_name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Pallete.redColor,
                    backgroundImage:
                        CachedNetworkImageProvider(product.pr_img[0]),
                  ),
                );
              },
            );
          }
        },
        error: (error, stacktrace) => ErrorText(errorMessage: error.toString()),
        loading: () => const Loader());
  }
}
