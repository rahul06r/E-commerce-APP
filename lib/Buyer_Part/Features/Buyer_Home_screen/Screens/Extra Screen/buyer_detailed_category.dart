// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/particular_product_screen.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:page_transition/page_transition.dart';

class DetailedCategoryScreen extends ConsumerStatefulWidget {
  final String query;
  const DetailedCategoryScreen({
    super.key,
    required this.query,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailedCategoryScreenState();
}

class _DetailedCategoryScreenState
    extends ConsumerState<DetailedCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(buyerHomeControProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Pallete.loginBgColor,
        title: Text(widget.query),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Pallete.balckColor,
            fontSize: 20),
      ),
      backgroundColor: Pallete.bgColor,
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : ref.watch(getCategoryProductsProvider(widget.query)).when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Products ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .85,
                      crossAxisCount: 2,
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = data[index];
                      return Card.filled(
                        color: Pallete.whiteColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              color: Pallete.bgColor,
                            )),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  child: ParticularProductScreen(product.pr_id),
                                  type: PageTransitionType.rightToLeft,
                                  ctx: context,
                                ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: product.pr_img[0],
                                    height: 130.0,
                                    // width: 140.0,

                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const Loader(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              // Name and Others
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  product.pr_name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  product.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  product.discount_Ammount == 0.1
                                      ? const SizedBox()
                                      : Text(
                                          "From ₹ ${product.discount_Ammount.toString()}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  Text(
                                    "₹ ${product.pr_ammount.toString()}",
                                    style: TextStyle(
                                      fontWeight:
                                          product.discount_Ammount == 0.1
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      fontSize: product.discount_Ammount == 0.1
                                          ? 19
                                          : 17,
                                      decoration:
                                          product.discount_Ammount == 0.1
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 1),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              error: (error, stackTrace) =>
                  ErrorText(errorMessage: error.toString()),
              loading: () => const Loader()),
    );
  }
}
