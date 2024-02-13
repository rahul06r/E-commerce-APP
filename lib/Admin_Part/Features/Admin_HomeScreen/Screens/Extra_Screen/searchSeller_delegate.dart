import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Controller/adminHomeScreenContro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchSellerDelegate extends SearchDelegate {
  final WidgetRef ref;
  // const SearchDeatils({super.key});
  SearchSellerDelegate(this.ref);

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
    return ref.watch(searchSellerProvider(query)).when(
        data: (data) {
          print(data);
          if (data.isEmpty) {
            return const Center(
              child: Text("No Seller found"),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final seller = data[index];
                return ListTile(
                  isThreeLine: true,
                  // subtitle: Text(seller.sl_phone.toString()),
                  onTap: () {},
                  // title: Text(
                  //   seller.name,
                  //   style: const TextStyle(
                  //       fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // leading: CircleAvatar(
                  //   backgroundColor: Pallete.redColor,
                  //   backgroundImage: CachedNetworkImageProvider(seller.sel_pro),
                  // ),
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
    return ref.watch(searchSellerProvider(query)).when(
        data: (data) {
          print(data);
          if (data.isEmpty) {
            return const Center(
              child: Text("No Product found"),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final seller = data[index];
                print(seller.sl_id);
                return ListTile(
                  isThreeLine: true,
                  subtitle: Text(seller.sl_phoneNo.toString()),
                  onTap: () {},
                  title: Text(
                    seller.sl_name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Pallete.redColor,
                    backgroundImage:
                        CachedNetworkImageProvider(seller.sl_photo),
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
