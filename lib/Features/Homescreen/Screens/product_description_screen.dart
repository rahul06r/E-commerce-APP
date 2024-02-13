import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Features/Homescreen/Controller/add_product_contro.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/edit_product_seller_screen.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/seller_answer_question.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ProductDescriptionScreen extends ConsumerStatefulWidget {
  final String prId;
  const ProductDescriptionScreen({super.key, required this.prId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState
    extends ConsumerState<ProductDescriptionScreen> {
  CarouselController buttonCarouselController = CarouselController();
  final ScrollController _scrollController = ScrollController();
  int pageCarouselIndex = 0;
  double rate = 1.5;
  void deleteProduct({required String prID, required String sl_ID}) {
    ref
        .read(addProductControProvider.notifier)
        .deleteProduct(prID, context, sl_ID);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(addProductControProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.whiteColor,
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProductScreenSeller(prID: widget.prId)));
                  },
                  icon: const Icon(
                    Icons.edit,
                  )),
            )
          ],
        ),
        // backgroundColor: Color.fromARGB(255, 236, 233, 233),
        backgroundColor: Pallete.bgColor,
        body: isLoading
            ? const Center(
                child: Loader(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      ref
                          .watch(getParticularProductInfoProvider(widget.prId))
                          .when(
                              data: (product) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Pallete.whiteColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                          topLeft: Radius.zero,
                                          topRight: Radius.zero,
                                        ),
                                      ),
                                      width: double.infinity,
                                      height: 250,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 4),
                                          CarouselSlider.builder(
                                            itemCount: product.pr_img.length,
                                            itemBuilder: (BuildContext context,
                                                int itemIndex,
                                                int pageViewIndex) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 350,
                                                decoration: BoxDecoration(
                                                    color: Pallete.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl:
                                                      product.pr_img[itemIndex],
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          const Loader(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              );
                                            },
                                            options: CarouselOptions(
                                              scrollPhysics:
                                                  const BouncingScrollPhysics(),
                                              autoPlay: false,
                                              enableInfiniteScroll:
                                                  product.pr_img.length > 1
                                                      ? true
                                                      : false,
                                              enlargeCenterPage: true,
                                              enlargeFactor: .9,
                                              viewportFraction: .94,
                                              height: 220,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  pageCarouselIndex = index;
                                                  if (kDebugMode) {
                                                    print(index);
                                                    print(pageCarouselIndex);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    product.pr_img.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    height: 10,
                                                    width: 10,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          pageCarouselIndex ==
                                                                  index
                                                              ? Pallete
                                                                  .balckColor
                                                              : Pallete.bgColor,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //
                                    //
                                    //
                                    const SizedBox(height: 5),
                                    Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Pallete.whiteColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.zero,
                                            bottomRight: Radius.zero,
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 15),
                                            child: Text(
                                              product.pr_name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                wordSpacing: 1,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                          // ####################### Rating
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 5, bottom: 5),
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
                                              valueLabelVisibility: true,
                                              animationDuration: const Duration(
                                                milliseconds: 1000,
                                              ),
                                              valueLabelMargin:
                                                  const EdgeInsets.only(
                                                      right: 15,
                                                      left: 5,
                                                      top: 5),
                                              valueLabelPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1,
                                                      horizontal: 5),
                                              starOffColor: Colors.grey,
                                              starColor: Colors.yellow,
                                              valueLabelRadius: 10,
                                            ),
                                          ),

                                          const SizedBox(height: 10),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Row(
                                              children: [
                                                product.discount_Ammount == 0.1
                                                    ? Container()
                                                    : Text(
                                                        "₹ ${product.discount_Ammount.toString()}",
                                                        style: const TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                const SizedBox(width: 15),
                                                Text(
                                                  "₹ ${product.pr_ammount.toString()}",
                                                  style: TextStyle(
                                                    decoration:
                                                        product.discount_Ammount ==
                                                                0.1
                                                            ? TextDecoration
                                                                .none
                                                            : TextDecoration
                                                                .lineThrough,
                                                    fontWeight:
                                                        product.discount_Ammount ==
                                                                0.1
                                                            ? FontWeight.bold
                                                            : FontWeight.w600,
                                                    fontSize:
                                                        product.discount_Ammount ==
                                                                0.1
                                                            ? 22
                                                            : 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //
                                          //
                                          //
                                          const SizedBox(height: 10),
                                          // const Divider(),

                                          // const Divider(),

                                          //
                                          //
                                          //
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 3),

                                    // ##############Descrption
                                    Container(
                                      color: Pallete.whiteColor,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, top: 5, bottom: 5),
                                              child: Text(
                                                "Description",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              product.description,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  wordSpacing: 1,
                                                  height: 1.3),
                                              textAlign: TextAlign.justify,
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      color: Pallete.whiteColor,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Question & Answers",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          ref
                                              .watch(
                                                  getAllQuestionsIdForSellerProvider(
                                                      product.pr_id))
                                              .when(
                                                  data: (data) {
                                                    if (data.isEmpty) {
                                                      return const Column(
                                                        children: [
                                                          SizedBox(height: 5),
                                                          SizedBox(
                                                            height: 80,
                                                            child: Center(
                                                              child: Text(
                                                                "No questions ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Divider(
                                                            thickness: 2,
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                    return ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          data.length >= 3
                                                              ? 3
                                                              : data.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final ids = data[index];

                                                        return ref
                                                            .watch(
                                                                getParticularQuestionDeatilsForSellerProvider(
                                                                    ids))
                                                            .when(
                                                                data: (data) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "${index + 1})",
                                                                              style: const TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 10),
                                                                            Expanded(
                                                                              child: Text(
                                                                                data.by_question,
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                maxLines: 3,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                5),
                                                                        Row(
                                                                          children: [
                                                                            data.sl_reply.isEmpty
                                                                                ? const Center(
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(left: 12),
                                                                                      child: Text(
                                                                                        "Wait for seller reply",
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : const Text(
                                                                                    "A:",
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                            const SizedBox(width: 10),
                                                                            Text(
                                                                              data.sl_reply,
                                                                              style: const TextStyle(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 16,
                                                                              ),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        //
                                                                        //
                                                                        //
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => SellerAnswerQuestionPage(
                                                                                              qId: data.qID,
                                                                                            )));
                                                                              },
                                                                              child: const Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.reply,
                                                                                    size: 19,
                                                                                  ),
                                                                                  SizedBox(width: 10),
                                                                                  Text("Reply")
                                                                                ],
                                                                              ),
                                                                            ),

                                                                            // data.by_ID == buyer.by_id
                                                                            // ?
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  // delete question.
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return SimpleDialog(
                                                                                          backgroundColor: Pallete.bgColor,
                                                                                          children: [
                                                                                            const Center(
                                                                                                child: Text(
                                                                                              "Delete Question?",
                                                                                              style: TextStyle(
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontSize: 18,
                                                                                              ),
                                                                                            )),
                                                                                            const SizedBox(height: 30),
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                              children: [
                                                                                                GestureDetector(
                                                                                                  onTap: () {
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                  child: const Row(
                                                                                                    children: [
                                                                                                      Icon(
                                                                                                        Icons.cancel,
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: 3,
                                                                                                      ),
                                                                                                      Text("Cancel"),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                GestureDetector(
                                                                                                  onTap: () {
                                                                                                    // delete answer
                                                                                                    ref.watch(addProductControProvider.notifier).deleteAnswerOfTheQuestion(qID: data.qID, context: context);
                                                                                                  },
                                                                                                  child: const Row(
                                                                                                    children: [
                                                                                                      Icon(
                                                                                                        Icons.delete,
                                                                                                      ),
                                                                                                      SizedBox(width: 3),
                                                                                                      Text("Delete")
                                                                                                    ],
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            )
                                                                                          ],
                                                                                        );
                                                                                      });
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.delete,
                                                                                  color: Pallete.redColor,
                                                                                  size: 19,
                                                                                ))
                                                                            // : Container(),
                                                                          ],
                                                                        ),
                                                                        const Divider(
                                                                            thickness:
                                                                                2),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                error: (error,
                                                                        stackTrcae) =>
                                                                    ErrorText(
                                                                        errorMessage:
                                                                            error
                                                                                .toString()),
                                                                loading: () =>
                                                                    const Loader());
                                                        // starts

                                                        // ends
                                                      },
                                                    );
                                                  },
                                                  error: (error, stackTrace) =>
                                                      ErrorText(
                                                          errorMessage:
                                                              error.toString()),
                                                  loading: () =>
                                                      const Loader()),
                                          //starts here

                                          // ends here list
                                          // add a condition to which if the buyer had bought the product
                                          // ask quetion buttuon
                                          // Center(
                                          //   child: ElevatedButton.icon(
                                          //       style: ElevatedButton.styleFrom(
                                          //         backgroundColor:
                                          //             Pallete.balckColor,
                                          //         // shape: RoundedRectangleBorder(
                                          //         //     side: BorderSide(
                                          //         //   color: Pallete.balckColor,
                                          //         // )),
                                          //       ),
                                          //       onPressed: () {
                                          //         //  ask quetion buttuon

                                          //         // Navigator.push(
                                          //         //     context,
                                          //         //     MaterialPageRoute(
                                          //         //         builder: (context) =>
                                          //         //             QuestionandAnswer(
                                          //         //               byId: buyer.by_id,
                                          //         //               prID:
                                          //         //                   product.pr_id,
                                          //         //               slID:
                                          //         //                   product.sl_id,
                                          //         //             )));
                                          //       },
                                          //       icon: const Icon(
                                          //         Icons.question_mark_sharp,
                                          //         color: Pallete.whiteColor,
                                          //       ),
                                          //       label: const Text(
                                          //         "Add Question ",
                                          //         style: TextStyle(
                                          //             color: Pallete.whiteColor,
                                          //             fontSize: 17,
                                          //             fontWeight:
                                          //                 FontWeight.w600),
                                          //       )),
                                          // ),
                                          // const SizedBox(height: 2),
                                        ],
                                      ),
                                    ),

                                    // ################# Similar product with same brand name

                                    const SizedBox(height: 3),
                                    Container(
                                      color: Pallete.whiteColor,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Center(
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                showDialog(
                                                    useSafeArea: true,
                                                    context: context,
                                                    builder: (context) {
                                                      return SimpleDialog(
                                                        backgroundColor: Pallete
                                                            .loginBgColor,
                                                        title: const Text(
                                                          "Delete Product?",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Pallete
                                                                  .whiteColor),
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              "After removing this,no new order will be placed and you should dispatch the previous order",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Pallete
                                                                      .whiteColor),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              TextButton.icon(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    deleteProduct(
                                                                        prID: product
                                                                            .pr_id,
                                                                        sl_ID: product
                                                                            .sl_id);
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      foregroundColor:
                                                                          Pallete
                                                                              .redColor),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Pallete
                                                                        .whiteColor,
                                                                  ),
                                                                  label:
                                                                      const Text(
                                                                    "Delete",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Pallete
                                                                          .whiteColor,
                                                                    ),
                                                                  )),
                                                              TextButton.icon(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      foregroundColor:
                                                                          Pallete
                                                                              .loginBgColor),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Pallete
                                                                        .whiteColor,
                                                                  ),
                                                                  label:
                                                                      const Text(
                                                                    "Cancel",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Pallete
                                                                          .whiteColor,
                                                                    ),
                                                                  ))
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Pallete.whiteColor,
                                              ),
                                              label: const Text(
                                                "Delete Product",
                                                style: TextStyle(
                                                    color: Pallete.whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor:
                                                    Pallete.redColor,
                                                elevation: 5,
                                                fixedSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5,
                                                  60,
                                                ),
                                                backgroundColor:
                                                    Pallete.redColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                    // #################### Question and Answer
                                    //

                                    const SizedBox(height: 3), //
                                    //
                                    //
                                    //############$%^&* Similar products from same seller
                                  ],
                                );
                              },
                              error: (error, stackTrace) =>
                                  ErrorText(errorMessage: error.toString()),
                              loading: () => const Loader()),
                    ],
                  ),
                ),
              ));

    //  isLoading
    //     ? const Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     :
    // SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const SizedBox(height: 5),
    //           ref
    //               .watch(getParticularProductInfoProvider(widget.prId))
    //               .when(
    //                   data: (product) {
    //                     return Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         SizedBox(
    //                           height: 250,
    //                           child: Column(
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.center,
    //                             children: [
    //                               CarouselSlider.builder(
    //                                 carouselController:
    //                                     buttonCarouselController,
    //                                 itemCount: product.pr_img.length,
    //                                 itemBuilder: (BuildContext context,
    //                                     int itemIndex,
    //                                     int pageViewIndex) {
    //                                   return Builder(builder: (context) {
    //                                     return Expanded(
    //                                       child: Container(
    //                                         width: MediaQuery.of(context)
    //                                             .size
    //                                             .width,
    //                                         height: 350,
    //                                         decoration: BoxDecoration(
    //                                             color: Pallete.whiteColor,
    //                                             borderRadius:
    //                                                 BorderRadius.circular(
    //                                                     10)),
    //                                         child: Image.network(
    //                                           product.pr_img[itemIndex],
    //                                           fit: BoxFit.fill,
    //                                         ),
    //                                       ),
    //                                     );
    //                                   });
    //                                 },
    //                                 options: CarouselOptions(
    //                                   autoPlay: false,
    //                                   enableInfiniteScroll: true,
    //                                   enlargeCenterPage: true,
    //                                   viewportFraction: .9,
    //                                   onPageChanged: (index, reason) {
    //                                     setState(() {
    //                                       pageCarouselIndex = index;
    //                                       if (kDebugMode) {
    //                                         print(index);
    //                                         print(pageCarouselIndex);
    //                                       }
    //                                     });
    //                                   },
    //                                 ),
    //                               ),
    //                               //
    //                               //

    //                               //
    //                             ],
    //                           ),
    //                         ),

    //                         //
    //                         // const Divider(),
    //                         //
    //                         //
    //                         //
    //                         Container(
    //                           // height:
    //                           // MediaQuery.of(context).size.height,
    //                           width: double.infinity,
    //                           decoration: const BoxDecoration(
    //                               color: Pallete.whiteColor,
    //                               borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(60),
    //                                 topRight: Radius.circular(60),
    //                                 bottomLeft: Radius.zero,
    //                                 bottomRight: Radius.zero,
    //                               )),
    //                           child: Column(
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.start,
    //                             children: [
    //                               Padding(
    //                                 padding: EdgeInsets.only(
    //                                     top: 8,
    //                                     left: MediaQuery.of(context)
    //                                             .size
    //                                             .width *
    //                                         .15),
    //                                 child: Text(
    //                                   product.pr_name.trimRight(),
    //                                   style: const TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                     color: Pallete.balckColor,
    //                                     fontSize: 26,
    //                                     wordSpacing: 1,
    //                                   ),
    //                                   maxLines: 2,
    //                                 ),
    //                               ),
    //                               //
    //                               const SizedBox(height: 5),
    //                               //
    //                               Padding(
    //                                 padding: EdgeInsets.only(
    //                                     top: 5,
    //                                     left: MediaQuery.of(context)
    //                                             .size
    //                                             .width *
    //                                         .13),
    //                                 child: Row(
    //                                   children: [
    //                                     Padding(
    //                                       padding: const EdgeInsets.only(
    //                                           top: 5, left: 10),
    //                                       child: Text(
    //                                         "₹${product.pr_ammount.toInt()}",
    //                                         style: TextStyle(
    //                                           fontWeight: FontWeight.bold,
    //                                           color:
    //                                               product.discount_Ammount !=
    //                                                       0
    //                                                   ? Colors.black45
    //                                                   : Pallete
    //                                                       .balckColor,
    //                                           fontSize: 20,
    //                                           wordSpacing: 1,
    //                                           decoration:
    //                                               product.discount_Ammount !=
    //                                                       0
    //                                                   ? TextDecoration
    //                                                       .lineThrough
    //                                                   : null,
    //                                         ),
    //                                         maxLines: 2,
    //                                       ),
    //                                     ),
    //                                     product.discount_Ammount != 0
    //                                         ? Padding(
    //                                             padding:
    //                                                 const EdgeInsets.only(
    //                                                     top: 5, left: 10),
    //                                             child: Text(
    //                                               "₹${product.discount_Ammount.toInt()}",
    //                                               style: const TextStyle(
    //                                                 fontWeight:
    //                                                     FontWeight.bold,
    //                                                 color: Pallete
    //                                                     .balckColor,
    //                                                 fontSize: 20,
    //                                                 wordSpacing: 1,
    //                                               ),
    //                                               maxLines: 2,
    //                                             ),
    //                                           )
    //                                         : Container(),
    //                                   ],
    //                                 ),
    //                               ),
    //                               const SizedBox(height: 10),
    //                               // discount

    //                               //

    //                               //
    //                               // RATING *********************#############################
    //                               const SizedBox(height: 5),
    //                               RatingStars(
    //                                 value: rate,
    //                                 onValueChanged: (v) {
    //                                   setState(() {
    //                                     rate = v;
    //                                     if (kDebugMode) {
    //                                       print(rate);
    //                                     }
    //                                   });
    //                                 },
    //                                 starSize: 25,
    //                                 maxValue: 5,
    //                                 starSpacing: 2,
    //                                 maxValueVisibility: true,
    //                                 valueLabelVisibility: true,
    //                                 animationDuration: const Duration(
    //                                   milliseconds: 1000,
    //                                 ),
    //                                 valueLabelMargin:
    //                                     const EdgeInsets.only(
    //                                         right: 15, left: 10, top: 5),
    //                                 valueLabelPadding:
    //                                     const EdgeInsets.symmetric(
    //                                         vertical: 1, horizontal: 8),
    //                                 starOffColor: Colors.grey,
    //                                 starColor: Colors.yellow,
    //                                 valueLabelRadius: 10,
    //                               ),
    //                               //
    //                               const SizedBox(height: 10),
    //                               const Divider(),
    //                               const SizedBox(height: 5),
    //                               Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     horizontal: 7),
    //                                 child: Text(
    //                                   product.description,
    //                                   style: const TextStyle(
    //                                     fontSize: 15,
    //                                     wordSpacing: 1,
    //                                   ),
    //                                   textAlign: TextAlign.justify,
    //                                 ),
    //                               ),

    //                               const SizedBox(height: 15),
    //                               //
    //                               const Padding(
    //                                 padding: EdgeInsets.symmetric(
    //                                     horizontal: 8),
    //                                 child: Text(
    //                                   "Brand",
    //                                   style: TextStyle(
    //                                       fontSize: 22,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     horizontal: 8),
    //                                 child: Text(
    //                                   product.pr_name,
    //                                   style: const TextStyle(
    //                                       fontSize: 18,
    //                                       fontWeight: FontWeight.w500),
    //                                 ),
    //                               ),

    //                               const SizedBox(height: 15),
    //                               Center(
    //                                 child: ElevatedButton.icon(
    //                                     style: ElevatedButton.styleFrom(
    //                                       foregroundColor:
    //                                           Pallete.greenColor,
    //                                       elevation: 5,
    //                                       fixedSize: Size(
    //                                         MediaQuery.of(context)
    //                                                 .size
    //                                                 .width *
    //                                             .5,
    //                                         60,
    //                                       ),
    //                                       backgroundColor:
    //                                           Pallete.greenColor,
    //                                     ),
    //                                     onPressed: () {
    //                                       Navigator.push(
    //                                           context,
    //                                           MaterialPageRoute(
    //                                               builder: (context) =>
    //                                                   EditProductScreenSeller(
    //                                                       prID: widget
    //                                                           .prId)));
    //                                     },
    //                                     icon: const Icon(
    //                                       Icons.edit,
    //                                       color: Pallete.whiteColor,
    //                                     ),
    //                                     label: const Text(
    //                                       "Edit",
    //                                       style: TextStyle(
    //                                           color: Pallete.whiteColor,
    //                                           fontWeight: FontWeight.bold,
    //                                           fontSize: 18),
    //                                     )),
    //                               ),
    //                               // edit button ends here
    //                               const SizedBox(height: 15),

    //                               //
    //                               // Delete Product Feature#######************
    //                               Center(
    //                                 child: ElevatedButton.icon(
    //                                   onPressed: () {
    //                                     showDialog(
    //                                         useSafeArea: true,
    //                                         context: context,
    //                                         builder: (context) {
    //                                           return SimpleDialog(
    //                                             backgroundColor:
    //                                                 Pallete.loginBgColor,
    //                                             title: const Text(
    //                                               "Delete Product?",
    //                                               style: TextStyle(
    //                                                   fontWeight:
    //                                                       FontWeight.bold,
    //                                                   color: Pallete
    //                                                       .whiteColor),
    //                                               maxLines: 1,
    //                                               textAlign:
    //                                                   TextAlign.center,
    //                                             ),
    //                                             children: [
    //                                               const Padding(
    //                                                 padding:
    //                                                     EdgeInsets.all(
    //                                                         8.0),
    //                                                 child: Text(
    //                                                   "After removing this,no new order will be placed and you should dispatch the previous order",
    //                                                   style: TextStyle(
    //                                                       fontWeight:
    //                                                           FontWeight
    //                                                               .w600,
    //                                                       color: Pallete
    //                                                           .whiteColor),
    //                                                 ),
    //                                               ),
    //                                               Row(
    //                                                 mainAxisAlignment:
    //                                                     MainAxisAlignment
    //                                                         .spaceAround,
    //                                                 children: [
    //                                                   TextButton.icon(
    //                                                       onPressed: () {
    //                                                         Navigator.pop(
    //                                                             context);
    //                                                         deleteProduct(
    //                                                             prID: product
    //                                                                 .pr_id,
    //                                                             sl_ID: product
    //                                                                 .sl_id);
    //                                                       },
    //                                                       style: TextButton.styleFrom(
    //                                                           foregroundColor:
    //                                                               Pallete
    //                                                                   .redColor),
    //                                                       icon:
    //                                                           const Icon(
    //                                                         Icons.delete,
    //                                                         color: Pallete
    //                                                             .whiteColor,
    //                                                       ),
    //                                                       label:
    //                                                           const Text(
    //                                                         "Delete",
    //                                                         style:
    //                                                             TextStyle(
    //                                                           color: Pallete
    //                                                               .whiteColor,
    //                                                         ),
    //                                                       )),
    //                                                   TextButton.icon(
    //                                                       onPressed: () {
    //                                                         Navigator.pop(
    //                                                             context);
    //                                                       },
    //                                                       style: TextButton.styleFrom(
    //                                                           foregroundColor:
    //                                                               Pallete
    //                                                                   .loginBgColor),
    //                                                       icon:
    //                                                           const Icon(
    //                                                         Icons.cancel,
    //                                                         color: Pallete
    //                                                             .whiteColor,
    //                                                       ),
    //                                                       label:
    //                                                           const Text(
    //                                                         "Cancel",
    //                                                         style:
    //                                                             TextStyle(
    //                                                           color: Pallete
    //                                                               .whiteColor,
    //                                                         ),
    //                                                       ))
    //                                                 ],
    //                                               )
    //                                             ],
    //                                           );
    //                                         });
    //                                   },
    //                                   icon: const Icon(
    //                                     Icons.delete,
    //                                     color: Pallete.whiteColor,
    //                                   ),
    //                                   label: const Text(
    //                                     "Delete Product",
    //                                     style: TextStyle(
    //                                         color: Pallete.whiteColor,
    //                                         fontWeight: FontWeight.bold,
    //                                         fontSize: 18),
    //                                   ),
    //                                   style: ElevatedButton.styleFrom(
    //                                     foregroundColor: Pallete.redColor,
    //                                     elevation: 5,
    //                                     fixedSize: Size(
    //                                       MediaQuery.of(context)
    //                                               .size
    //                                               .width *
    //                                           .5,
    //                                       60,
    //                                     ),
    //                                     backgroundColor: Pallete.redColor,
    //                                   ),
    //                                 ),
    //                               ),
    //                               // button ends here

    //                               //

    //                               const SizedBox(height: 15),
    //                               // End##############******************
    //                             ],
    //                           ),
    //                         ),

    //                         // const SizedBox(height: 10),
    //                         // const Divider(),
    //                       ],
    //                     );
    //                   },
    //                   error: (error, stackTrace) =>
    //                       ErrorText(errorMessage: error.toString()),
    //                   loading: () => const Loader()),
    //         ],
    //       ),
    //     ),
    //   ),
  }
}
