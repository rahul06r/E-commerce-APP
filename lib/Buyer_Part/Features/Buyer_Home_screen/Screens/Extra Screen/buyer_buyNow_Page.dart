import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Core/Common/errorText.dart';
import '../../../../../Core/Common/loader.dart';

class BuyerBuyNowPage extends ConsumerStatefulWidget {
  final String byId;
  const BuyerBuyNowPage(this.byId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BuyerBuyNowPageState();
}

class _BuyerBuyNowPageState extends ConsumerState<BuyerBuyNowPage> {
  int quantity = 1;
  double totalAmmount = 0;

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(buyerHomeControProvider);

    final buyer = ref.watch(buyerUserProvider)!;
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Pallete.loginBgColor,
        title: const Text(
          "Order Now",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Card.filled(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      color: Pallete.whiteColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              buyer.by_name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, top: 6),
                            child: Text(
                              buyer.by_address,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, top: 6),
                            child: Text(buyer.by_phone.toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // card ends
                  ref
                      .watch(
                          getParticularProductdetailsBuyerProvider(widget.byId))
                      .when(
                        data: (product) {
                          double rate = 2;
                          double totalAmmount = product.discount_Ammount == 0
                              ? product.pr_ammount * quantity
                              : product.discount_Ammount * quantity;
                          return Column(
                            children: [
                              Card.filled(
                                color: Pallete.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const Loader(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product.pr_name,
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                Text(
                                                  product.description,
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                //
                                                RatingStars(
                                                  value: rate,
                                                  // onValueChanged: (v) {
                                                  //   setState(() {
                                                  //     rate = v;
                                                  //     if (kDebugMode) {
                                                  //       print(rate);
                                                  //     }
                                                  //   });
                                                  // },
                                                  starSize: 18,
                                                  maxValue: 5,
                                                  starSpacing: 1,
                                                  maxValueVisibility: true,
                                                  valueLabelVisibility: true,
                                                  animationDuration:
                                                      const Duration(
                                                    milliseconds: 1000,
                                                  ),
                                                  valueLabelMargin:
                                                      const EdgeInsets.only(
                                                          right: 15,
                                                          left: 5,
                                                          top: 5),
                                                  valueLabelPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 1,
                                                          horizontal: 5),
                                                  starOffColor: Colors.grey,
                                                  starColor: Colors.yellow,
                                                  valueLabelRadius: 10,
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
                                              MainAxisAlignment.center,
                                          children: [
                                            product.discount_Ammount != 0.0
                                                ? Text(
                                                    "₹ ${product.discount_Ammount}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : Container(),
                                            const SizedBox(width: 15),
                                            Text(
                                              "₹ ${product.pr_ammount.toString()}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration: product
                                                            .discount_Ammount !=
                                                        0.0
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton.icon(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Pallete.whiteColor,
                                                    foregroundColor:
                                                        Pallete.blueColor,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (quantity > 1) {
                                                        quantity -= 1;
                                                      }
                                                      product.discount_Ammount ==
                                                              0
                                                          ? totalAmmount =
                                                              product.pr_ammount *
                                                                  quantity
                                                          : totalAmmount = product
                                                                  .discount_Ammount *
                                                              quantity;
                                                    });
                                                    if (kDebugMode) {
                                                      print(totalAmmount);
                                                    }
                                                  },
                                                  icon: const Icon(Icons.remove,
                                                      color:
                                                          Pallete.balckColor),
                                                  label: const Text("")),
                                              Text(quantity.toString()),
                                              TextButton.icon(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Pallete.whiteColor,
                                                    foregroundColor:
                                                        Pallete.blueColor,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      quantity += 1;
                                                      product.discount_Ammount ==
                                                              0
                                                          ? totalAmmount =
                                                              product.pr_ammount *
                                                                  quantity
                                                          : totalAmmount = product
                                                                  .discount_Ammount *
                                                              quantity;
                                                    });
                                                    if (kDebugMode) {
                                                      print(totalAmmount);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Pallete.balckColor,
                                                  ),
                                                  label: const Text("")),

                                              // TextButton.icon(
                                              //   style: TextButton.styleFrom(
                                              //     iconColor: Pallete.redColor,
                                              //     foregroundColor: Pallete.loginBgColor,
                                              //   ),
                                              //   onPressed: () {
                                              //     // deletefromCart(
                                              //     //     product.pr_id,
                                              //     //     buyer.by_id);
                                              //   },
                                              //   icon: const Icon(
                                              //     Icons.delete_forever,
                                              //   ),
                                              //   label: const Text(
                                              //     "Remove",
                                              //     style: TextStyle(
                                              //       color: Pallete.redColor,
                                              //       fontWeight: FontWeight.bold,
                                              //     ),
                                              //   ),
                                              // ),
                                              // const VerticalDivider(
                                              //   color: Pallete.balckColor,
                                              //   thickness: 2,
                                              // ),
                                              // TextButton.icon(
                                              //   onPressed: () {
                                              //     // navigate to buy now page
                                              //     Navigator.push(
                                              //         context,
                                              //         MaterialPageRoute(
                                              //             builder: (context) =>
                                              //                 BuyerBuyNowPage(
                                              //                     product.pr_id)));
                                              //   },
                                              //   style: TextButton.styleFrom(
                                              //     foregroundColor: Pallete.loginBgColor,
                                              //   ),
                                              //   icon: const Icon(
                                              //     Icons.data_thresholding_rounded,
                                              //     color: Pallete.greenColor,
                                              //   ),
                                              //   label: const Text(
                                              //     "Buy Now",
                                              //     style: TextStyle(
                                              //       color: Pallete.greenColor,
                                              //       fontWeight: FontWeight.bold,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Total Ammount: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          // "${product.pr_ammount * quantity}",
                                          "₹ $totalAmmount",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Pallete.loginBgColor,
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width *
                                              .8,
                                          50)),
                                  onPressed: () {
                                    // order placed notification@@@@@@@@
                                    ref
                                        .watch(buyerHomeControProvider.notifier)
                                        .orderNow(
                                          context: context,
                                          byID: buyer.by_id,
                                          slID: product.sl_id,
                                          prID: product.pr_id,
                                          or_Quantity: quantity,
                                          total_ammount: totalAmmount,
                                          or_price:
                                              product.discount_Ammount == 0.0
                                                  ? product.pr_ammount
                                                  : product.discount_Ammount,
                                          prImage: product.pr_img[0],
                                          prName: product.pr_name,
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.data_thresholding_rounded,
                                    color: Pallete.whiteColor,
                                  ),
                                  label: const Text(
                                    "Order Now",
                                    style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                            ],
                          );
                        },
                        error: (error, stackTrace) =>
                            ErrorText(errorMessage: error.toString()),
                        loading: () => const Loader(),
                      ),
                  //
                ],
              ),
            ),
    );
  }
}
