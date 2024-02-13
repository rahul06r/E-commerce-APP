// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/buyer_rating_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';

import '../../../../../Core/Common/errorText.dart';
import '../../../../../Pallete/pallete.dart';

class AllReviewPage extends ConsumerStatefulWidget {
  final String prID;
  final String byID;

  const AllReviewPage({
    super.key,
    required this.prID,
    required this.byID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllReviewPageState();
}

class _AllReviewPageState extends ConsumerState<AllReviewPage> {
  double rate = 2;
  @override
  Widget build(BuildContext context) {
    final product =
        ref.watch(getBuyerParticularProductProvider(widget.prID)).value!;
    final isLoading = ref.watch(buyerAuthControProvider);
    final buyer = ref.watch(buyerUserProvider)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "All Reviews",
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
              child: Column(
                children: [
                  Container(
                    color: Pallete.whiteColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Review & Ratings",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10, top: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Pallete.loginBgColor,
                                  foregroundColor: Pallete.loginBgColor,
                                  elevation: 2,
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                      color: Pallete.loginBgColor,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BuyerRatingScreen(
                                                prID: product.pr_id,
                                                slID: product.sl_id,
                                              )));
                                },
                                child: const Text(
                                  "Rate Product",
                                  style: TextStyle(
                                    color: Pallete.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ref.watch(getAllReviewIDSProvider(widget.prID)).when(
                            data: (data) {
                              // print(product.pr_id);
                              if (data.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "No Review done",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                              return Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Card.filled(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color: Pallete.bgColor,
                                                )),
                                            color: Pallete.whiteColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    "Very Good",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: RatingStars(
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
                                                      valueLabelVisibility:
                                                          true,
                                                      animationDuration:
                                                          const Duration(
                                                        milliseconds: 1000,
                                                      ),
                                                      valueLabelMargin:
                                                          const EdgeInsets.only(
                                                              right: 3,
                                                              left: 0,
                                                              top: 5),
                                                      valueLabelPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 1,
                                                              horizontal: 04),
                                                      starOffColor: Colors.grey,
                                                      starColor: Colors.yellow,
                                                      valueLabelRadius: 10,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  // total ratings
                                                  Text(
                                                    "${product.review.length} Ratings given",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // ends here left part
                                          SizedBox(
                                            height: 200,
                                            child: CircularPercentIndicator(
                                              radius: 50,
                                              lineWidth: 10.0,
                                              // value
                                              backgroundColor: Pallete.bgColor,
                                              percent: 0.8,
                                              animation: true,
                                              center: const Text(
                                                "100%",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              progressColor: Pallete.greenColor,
                                              //
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Divider(
                                        thickness: 2,
                                        indent:
                                            MediaQuery.of(context).size.width *
                                                .03,
                                        endIndent:
                                            MediaQuery.of(context).size.width *
                                                .03,
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                  //
                                  ListView.builder(
                                    itemCount: data.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final revIndexs = data[index];

                                      if (kDebugMode) {
                                        // print(revIndexs);
                                        // print(data.length);
                                      }
                                      return ref
                                          .watch(
                                              getParticularReviewDetailsProvider(
                                                  revIndexs))
                                          .when(
                                              data: (review) {
                                                final DateTime dateTime = DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        review.revUploadDateTime
                                                            .millisecondsSinceEpoch);
                                                final String formatedTimeDate =
                                                    DateFormat(
                                                            'dd-MM-yyyy hh:mm a')
                                                        .format(dateTime);
                                                return SizedBox(
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 6),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              child:
                                                                  RatingStars(
                                                                value: review
                                                                    .revratings,
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
                                                                        right:
                                                                            3,
                                                                        left: 0,
                                                                        top: 5),
                                                                valueLabelPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            1,
                                                                        horizontal:
                                                                            04),
                                                                starOffColor:
                                                                    Colors.grey,
                                                                starColor:
                                                                    Colors
                                                                        .yellow,
                                                                valueLabelRadius:
                                                                    10,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              review.mainReview,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17,
                                                              ),
                                                            ),
                                                            //
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        //
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: ExpandableText(
                                                            review.revDeatils,
                                                            expandText:
                                                                "Read more",
                                                            collapseText:
                                                                "Show less",
                                                            maxLines: 2,
                                                            linkColor: Pallete
                                                                .blueColor,
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 12),
                                                        SizedBox(
                                                          height: 90,
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: 1,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              // return Image.asset("assets/4.png");
                                                              return CachedNetworkImage(
                                                                imageUrl: review
                                                                        .revImages[
                                                                    index],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8),
                                                          child: Text(
                                                            review.byName,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8),
                                                          child: Text(
                                                              formatedTimeDate),
                                                        ),
                                                        const SizedBox(
                                                            height: 9),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8),
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Pallete
                                                                      .balckColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            ref.read(buyerHomeControProvider.notifier).aggreeReview(review);
                                                                          },
                                                                          icon: Icon(
                                                                            review.revAgree.contains(buyer.by_id)
                                                                                ? Icons.thumb_up
                                                                                : Icons.thumb_up_alt_outlined,
                                                                            color: review.revAgree.contains(buyer.by_id)
                                                                                ? Pallete.greenColor
                                                                                : null,
                                                                          )),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              4),
                                                                      child:
                                                                          Text(
                                                                        "Helpfull for ${review.revAgree.length}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 6),
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Pallete
                                                                      .balckColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            ref.read(buyerHomeControProvider.notifier).disAggreeReview(review);
                                                                          },
                                                                          icon: Icon(
                                                                            review.revDisAgree.contains(buyer.by_id)
                                                                                ? Icons.thumb_down_alt
                                                                                : Icons.thumb_down_alt_outlined,
                                                                            color: review.revDisAgree.contains(buyer.by_id)
                                                                                ? Pallete.redColor
                                                                                : null,
                                                                          )),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              4),
                                                                      child:
                                                                          Text(
                                                                        review
                                                                            .revDisAgree
                                                                            .length
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Divider(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              error: (error, stackTrace) =>
                                                  ErrorText(
                                                      errorMessage:
                                                          error.toString()),
                                              loading: () => const Loader());
                                    },
                                  ),
                                  //
                                  // data.length > 3
                                  //     ?
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     // navigation to all review page
                                  //     // Navigator.push(
                                  //     //     context,
                                  //     //     MaterialPageRoute(
                                  //     //         builder: (context) => AllReviewPage()));
                                  //   },
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Padding(
                                  //         padding:
                                  //             const EdgeInsets.only(left: 10),
                                  //         child: Text(
                                  //           "All ${data.length} reviews",
                                  //           style: const TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 17,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       const Padding(
                                  //         padding: EdgeInsets.only(right: 10),
                                  //         child: Icon(
                                  //           Icons.chevron_right_outlined,
                                  //           size: 30,
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  // : Container(),
                                  // data.length > 3
                                  //     ? const SizedBox(height: 13)
                                  //     : const SizedBox(height: 1.5),
                                ],
                              );
                            },
                            error: (error, stackTrace) =>
                                ErrorText(errorMessage: error.toString()),
                            loading: () => const Loader()),

                        // starts here
                        //
                        //

                        // ends here
                        // put a condition if the review number is greater than 3 only display button
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
