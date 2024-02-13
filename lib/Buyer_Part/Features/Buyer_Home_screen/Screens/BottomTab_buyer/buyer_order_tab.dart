import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Pallete/pallete.dart';

class BuyerOrdertab extends ConsumerStatefulWidget {
  const BuyerOrdertab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuyerOrdertabState();
}

class _BuyerOrdertabState extends ConsumerState<BuyerOrdertab> {
  @override
  Widget build(BuildContext context) {
    final buyer = ref.watch(buyerUserProvider)!;
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      body: Column(
        children: [
          Expanded(
            child: ref.watch(getAllOrderIdsProvider(buyer.by_id)).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Order",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final orderIndexes = data[index];
                        return ref
                            .watch(
                                getParticularOrderDeatilsProvider(orderIndexes))
                            .when(
                              data: (order) {
                                double rate = 2;
                                final productPrice = ref
                                    .watch(getBuyerParticularProductProvider(
                                        order.prID))
                                    .when(
                                        data: (data) {
                                          return data.pr_ammount.toString();
                                        },
                                        error: (error, stackTrace) => ErrorText(
                                            errorMessage: error.toString()),
                                        loading: () => const Loader());

                                return Column(
                                  children: [
                                    // const SizedBox(height: 5),
                                    SizedBox(
                                      // height: 180,
                                      child: Card.filled(
                                        color: Pallete.whiteColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 1.0,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Order ID: ${order.orID.substring(1, 8)}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: order.prImageOne,
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
                                                          order.prName,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8.0),
                                                        // Text(
                                                        //   order.or_Quantity
                                                        //       .toString(),
                                                        //   style:
                                                        //       const TextStyle(
                                                        //           fontSize:
                                                        //               16.0),
                                                        //   maxLines: 1,
                                                        //   overflow: TextOverflow
                                                        //       .ellipsis,
                                                        // ),
                                                        RatingStars(
                                                          value: rate,
                                                          starSize: 18,
                                                          // ... other properties ...
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
                                                    const SizedBox(width: 15),
                                                    Text(
                                                      "₹ $productPrice",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                Text(
                                                  "Total Quantity: ${order.or_Quantity}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  "Ordered Price: ₹${order.or_price} ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  "Total Amount: ₹${order.total_ammount} ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(height: 5),
                                                const Divider(),
                                                ElevatedButton.icon(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Pallete.redColor,
                                                  ),
                                                  onPressed: () {
                                                    ref
                                                        .watch(
                                                            buyerHomeControProvider
                                                                .notifier)
                                                        .cancelOrder(
                                                            orID: order.orID,
                                                            byID: order.byID,
                                                            slID: order.slID);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Pallete.whiteColor,
                                                  ),
                                                  label: const Text(
                                                    "Cancel Order",
                                                    style: TextStyle(
                                                      color: Pallete.whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(height: 10),
                                  ],
                                );
                              },
                              error: (error, stackTrace) =>
                                  ErrorText(errorMessage: error.toString()),
                              loading: () => const Loader(),
                            );
                      },
                    );
                  },
                  error: (error, stackTrace) =>
                      ErrorText(errorMessage: error.toString()),
                  loading: () => const Loader(),
                ),
          ),
        ],
      ),
    );
  }
}
