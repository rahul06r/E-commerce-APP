import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/buyer_buyNow_Page.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Core/Common/loader.dart';

class BuyerCartTab extends ConsumerStatefulWidget {
  const BuyerCartTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuyerCartTabState();
}

class _BuyerCartTabState extends ConsumerState<BuyerCartTab> {
  void deletefromCart(String prId, String byId) {
    ref.read(buyerHomeControProvider.notifier).deleteFromCart(prId, byId);
  }

  double rate = 2;
  
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(buyerHomeControProvider);
    final buyer = ref.watch(buyerUserProvider)!;
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      body: isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: const Center(
                child: Loader(),
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Card.filled(
                      elevation: 2,
                      color: Pallete.whiteColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Delivered to: ",
                                  style: TextStyle(
                                    color: Pallete.balckColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  buyer.by_name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Text(buyer.by_address),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ref.watch(getCartDeatilsBuyerProvider(buyer.by_id)).when(
                      data: (data) {
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final productIndexes = data[index];

                              return ref
                                  .watch(
                                      getParticularProductdetailsBuyerProvider(
                                          productIndexes))
                                  .when(
                                      data: (product) {
                                        return Card.filled(
                                          color: Pallete.whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 1.0,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: product.pr_img[0],
                                                    height: 100.0,
                                                    width: 140.0,
                                                    fit: BoxFit.fill,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            const Loader(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            product.pr_name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8.0),
                                                          Text(
                                                            product.description,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16.0),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          //
                                                          RatingStars(
                                                            value: rate,
                                                            onValueChanged:
                                                                (v) {
                                                              setState(() {
                                                                rate = v;
                                                                if (kDebugMode) {
                                                                  print(rate);
                                                                }
                                                              });
                                                            },
                                                            starSize: 18,
                                                            maxValue: 5,
                                                            starSpacing: 1,
                                                            maxValueVisibility:
                                                                true,
                                                            valueLabelVisibility:
                                                                true,
                                                            animationDuration:
                                                                const Duration(
                                                              milliseconds:
                                                                  1000,
                                                            ),
                                                            valueLabelMargin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 15,
                                                                    left: 5,
                                                                    top: 5),
                                                            valueLabelPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 1,
                                                                    horizontal:
                                                                        5),
                                                            starOffColor:
                                                                Colors.grey,
                                                            starColor:
                                                                Colors.yellow,
                                                            valueLabelRadius:
                                                                10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      product.discount_Ammount !=
                                                              0.0
                                                          ? Text(
                                                              "₹ ${product.discount_Ammount}",
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            )
                                                          : Container(),
                                                      const SizedBox(width: 15),
                                                      Text(
                                                        "₹ ${product.pr_ammount.toString()}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration: product
                                                                      .discount_Ammount !=
                                                                  0.0
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        TextButton.icon(
                                                          style: TextButton
                                                              .styleFrom(
                                                            iconColor: Pallete
                                                                .redColor,
                                                            foregroundColor:
                                                                Pallete
                                                                    .loginBgColor,
                                                          ),
                                                          onPressed: () {
                                                            deletefromCart(
                                                                product.pr_id,
                                                                buyer.by_id);
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .delete_forever,
                                                          ),
                                                          label: const Text(
                                                            "Remove",
                                                            style: TextStyle(
                                                              color: Pallete
                                                                  .redColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        const VerticalDivider(
                                                          color: Pallete
                                                              .balckColor,
                                                          thickness: 2,
                                                        ),
                                                        TextButton.icon(
                                                          onPressed: () {
                                                            // navigate to buy now page
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        BuyerBuyNowPage(
                                                                            product.pr_id)));
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Pallete
                                                                    .loginBgColor,
                                                          ),
                                                          icon: const Icon(
                                                            Icons
                                                                .data_thresholding_rounded,
                                                            color: Pallete
                                                                .greenColor,
                                                          ),
                                                          label: const Text(
                                                            "Buy Now",
                                                            style: TextStyle(
                                                              color: Pallete
                                                                  .greenColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      error: (error, stackTrace) => ErrorText(
                                          errorMessage: error.toString()),
                                      loading: () => const Loader());
                            },
                          ),
                        );
                      },
                      error: (error, stackTrace) =>
                          ErrorText(errorMessage: error.toString()),
                      loading: () => const Loader()),
                ],
              ),
            ),
    );
  }
}
