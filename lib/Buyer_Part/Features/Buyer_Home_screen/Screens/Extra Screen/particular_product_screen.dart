import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/all_review_page.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/buyer_rating_screen.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/question_and_answer.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/special_cart_screen.dart';
import 'package:app_ecommerce/Buyer_Part/Models/Buyer_Model.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:intl/intl.dart';

class ParticularProductScreen extends ConsumerStatefulWidget {
  final String prID;
  const ParticularProductScreen(
    this.prID, {
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ParticularProductScreenState();
}

class _ParticularProductScreenState
    extends ConsumerState<ParticularProductScreen> {
  CarouselController buttonCarouselController = CarouselController();
  final ScrollController _scrollController = ScrollController();
  int pageCarouselIndex = 0;

  double rate = 4;

  List<String> questions = [
    "Show size",
    "is it Anckle shoe  and weight of it ",
    "Delivery range and Packagae details",
  ];
  List<String> answers = [
    "9,8 & 10",
    "Yes and 200g",
    "4 days and Safe package",
  ];
  @override
  void initState() {
    super.initState();
  }

  void deletefromCart(String prId, String byId) {
    ref.read(buyerHomeControProvider.notifier).deleteFromCart(prId, byId);
  }

  void addToCart(String prId, String byId) {
    ref.read(buyerHomeControProvider.notifier).addToCart(prId, byId);
  }

  void addCartProduct(BuyerModel buyerModel, String prID) {
    ref.read(buyerHomeControProvider.notifier).addcartProduct(buyerModel, prID);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(buyerAuthControProvider);
    final buyer = ref.watch(buyerUserProvider)!;

    final products = ref.watch(getBuyerParticularProductProvider(widget.prID));
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Pallete.balckColor,
          selectedItemColor: Pallete.greenColor,
          enableFeedback: true,

          selectedLabelStyle: const TextStyle(
            color: Pallete.whiteColor,
          ),
          elevation: 2,
          currentIndex: 0,
          unselectedItemColor: Pallete.whiteColor,
          // unselectedLabelStyle: const TextStyle(color: Pallete.whiteColor),
          mouseCursor: MouseCursor.defer,
          onTap: (v) {
            if (kDebugMode) {
              print(v);
            }
            if (v == 0) {
              // do the add to cart functionality

              addCartProduct(buyer, widget.prID);
            } else {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>))
              // go to buy page
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.trolley,
              ),
              label: "Add to cart",
              // backgroundColor: Pallete.greenColor,
            ),
            BottomNavigationBarItem(
              // backgroundColor: Pallete.redColor,
              icon: Icon(
                Icons.outbond_rounded,
                color: Pallete.whiteColor,
              ),
              label: "Buy Now",
            ),
          ],
        ),
        backgroundColor: Pallete.bgColor,
        appBar: AppBar(
          // foregroundColor: Pallete.greenColor,
          backgroundColor: Pallete.whiteColor,
          scrolledUnderElevation: 2,

          // title: Text("Product"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 18,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SpeacialCartScreenPage(),
                      ));
                },
                child: badges.Badge(
                    badgeContent: Text(
                      buyer.by_add_to_cart.length.toString(),
                      style: const TextStyle(
                          // fontSize: 18,
                          color: Pallete.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    showBadge: true,
                    onTap: () {
                      // navigate to cart screen
                      if (kDebugMode) {
                        print("Pressed Cart badge");
                      }
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const BuyerCartTab()),
                      //     (route) => false);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const BuyerCartTab()));
                    },
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: Pallete.greenColor,
                      elevation: 2,
                    ),
                    badgeAnimation: const badges.BadgeAnimation.rotation(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      toAnimate: true,
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                    ),
                    child: const Icon(Icons.trolley)),
              ),
            )
          ],

          automaticallyImplyLeading: true,
        ),
        body: isLoading
            ? const Center(
                child: Loader(),
              )
            : SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    ref
                        .watch(getBuyerParticularProductProvider(widget.prID))
                        .when(
                            data: (product) {
                              // 1.505
                              String textRating = "NAN";
                              switch (product.revRatings) {
                                case 1:
                                case 1.2:
                                case 1.3:
                                case 1.4:
                                case 1.5:
                                  textRating = "Very Poor";
                                  break;

                                case 1.6:
                                case 1.7:
                                case 1.8:
                                case 1.9:
                                case 2.0:
                                case 2.1:
                                case 2.2:
                                case 2.3:
                                case 2.4:
                                case 2.5:
                                  textRating = "Poor";
                                  break;

                                case 2.6:
                                case 2.7:
                                case 2.8:
                                case 2.9:
                                case 3.0:
                                case 3.1:
                                case 3.2:
                                case 3.3:
                                case 3.4:
                                case 3.5:
                                  textRating = "Average";
                                  break;

                                case 3.6:
                                case 3.7:
                                case 3.8:
                                case 3.9:
                                case 4.0:
                                case 4.1:
                                case 4.2:
                                case 4.3:
                                case 4.4:
                                case 4.5:
                                  textRating = "Good";
                                  break;
                                case 4.6:
                                case 4.7:
                                case 4.8:
                                case 4.9:
                                case 5.0:
                                  textRating = "Very Good";
                                  break;
                                default:
                              }
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
                                                errorWidget:
                                                    (context, url, error) =>
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
                                              scrollDirection: Axis.horizontal,
                                              itemCount: product.pr_img.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  height: 10,
                                                  width: 10,
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: pageCarouselIndex ==
                                                            index
                                                        ? Pallete.balckColor
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
                                            value: product.revRatings,
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
                                                    right: 15, left: 5, top: 5),
                                            valueLabelPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 1, horizontal: 5),
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
                                              product.discount_Ammount == 0.0
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
                                                              0.0
                                                          ? TextDecoration.none
                                                          : TextDecoration
                                                              .lineThrough,
                                                  fontWeight:
                                                      product.discount_Ammount ==
                                                              0.0
                                                          ? FontWeight.bold
                                                          : FontWeight.w600,
                                                  fontSize:
                                                      product.discount_Ammount ==
                                                              0.0
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

                                        const SizedBox(height: 10),
                                        //
                                        //
                                        //
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  // ###############################Address
                                  Container(
                                    color: Pallete.whiteColor,
                                    // height: 80,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Text(buyer.by_address),
                                        ),
                                        const SizedBox(height: 7),
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
                                            padding: EdgeInsets.only(left: 5),
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

                                  // ################# Similar product with same brand name

                                  Container(
                                    child:
                                        ref
                                            .watch(sameProductsProvider(
                                                product.pr_catogory))
                                            .when(
                                                data: (data) {
                                                  if (data.isEmpty) {
                                                    return SizedBox(
                                                        // height:
                                                        //     MediaQuery.of(context)
                                                        //             .size
                                                        //             .height *
                                                        //         .6,
                                                        // child: const Center(
                                                        //   child: Text(
                                                        //     "Products are Empty",
                                                        //     style: TextStyle(
                                                        //         fontWeight:
                                                        //             FontWeight
                                                        //                 .bold,
                                                        //         fontSize: 20),
                                                        //   ),
                                                        // ),
                                                        );
                                                  } else {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        //

                                                        const SizedBox(
                                                            height: 3),

                                                        Container(
                                                          height:
                                                              data.length < 2
                                                                  ? 0
                                                                  : 200,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Pallete
                                                                .whiteColor,
                                                          ),
                                                          child: data.length < 2
                                                              ? Container()
                                                              : Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              10,
                                                                          top:
                                                                              8),
                                                                      child:
                                                                          Text(
                                                                        "Similar Products ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Expanded(
                                                                      child: ListView
                                                                          .builder(
                                                                        physics:
                                                                            const BouncingScrollPhysics(),
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        shrinkWrap:
                                                                            true,
                                                                        // add a condition here
                                                                        itemCount: data.length >
                                                                                6
                                                                            ? 6
                                                                            : data.length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          final sameProduct =
                                                                              data[index];

                                                                          return sameProduct.pr_id == product.pr_id
                                                                              ? Container()
                                                                              : Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      // setState(
                                                                                      //     () {
                                                                                      //   ref
                                                                                      //       .read(selectedProductIDProvider.notifier)
                                                                                      //       .state
                                                                                      //       .clear();
                                                                                      // });

                                                                                      Navigator.push(
                                                                                          context,
                                                                                          PageTransition(
                                                                                            child: ParticularProductScreen(
                                                                                              sameProduct.pr_id,
                                                                                            ),
                                                                                            type: PageTransitionType.rightToLeft,
                                                                                            ctx: context,
                                                                                          ));
                                                                                    },
                                                                                    child: Card.filled(
                                                                                      color: Pallete.whiteColor,
                                                                                      elevation: 2,
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Pallete.bgColor, width: 1.4)),
                                                                                      child: Container(
                                                                                          height: 150,
                                                                                          width: MediaQuery.of(context).size.width * .5,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(15),
                                                                                            // border: Border.all(
                                                                                            //     color: Pallete
                                                                                            //         .balckColor,
                                                                                            //     width: 1),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Expanded(
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      Expanded(
                                                                                                        child: CachedNetworkImage(
                                                                                                          fit: BoxFit.fill,
                                                                                                          imageUrl: sameProduct.pr_img[0],
                                                                                                          progressIndicatorBuilder: (context, url, downloadProgress) => const Loader(),
                                                                                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Text(
                                                                                                        sameProduct.brand,
                                                                                                        maxLines: 1,
                                                                                                        style: const TextStyle(
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontSize: 16,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                        ),
                                                        // Text("data")

                                                        //
                                                      ],
                                                    );
                                                  }
                                                },
                                                error: (error, stackTrace) =>
                                                    ErrorText(
                                                        errorMessage:
                                                            error.toString()),
                                                loading: () => const Loader()),
                                  ),
                                  const SizedBox(height: 5),
                                  // #################### Question and Answer
                                  //
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
                                            .watch(getAllQuestionIDProvider(
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
                                                                  fontSize: 16),
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
                                                    itemCount: data.length >= 3
                                                        ? 3
                                                        : data.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final ids = data[index];

                                                      return ref
                                                          .watch(
                                                              getParticularQuestionDeatilsProvider(
                                                                  ids))
                                                          .when(
                                                              data: (data) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "${index + 1})",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
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
                                                                          const SizedBox(
                                                                              width: 10),
                                                                          Text(
                                                                            data.sl_reply,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 16,
                                                                            ),
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
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
                                                                          Row(
                                                                            children: [
                                                                              IconButton(
                                                                                  onPressed: () {
                                                                                    ref.watch(buyerHomeControProvider.notifier).likeQuestion(data, buyer.by_id);
                                                                                  },
                                                                                  icon: Icon(
                                                                                    data.liked.contains(buyer.by_id) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                                                                    size: 19,
                                                                                  )),
                                                                              Text(
                                                                                data.liked.length.toString(),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              IconButton(
                                                                                  onPressed: () {
                                                                                    ref.watch(buyerHomeControProvider.notifier).disLikeQuestion(data, buyer.by_id);
                                                                                  },
                                                                                  icon: Icon(
                                                                                    data.disliked.contains(buyer.by_id) ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
                                                                                    size: 19,
                                                                                  )),
                                                                              Text(
                                                                                data.disliked.length.toString(),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          data.by_ID == buyer.by_id
                                                                              ? IconButton(
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
                                                                                                      // delete
                                                                                                      ref.watch(buyerHomeControProvider.notifier).deleteQuestion(qID: data.qID, prID: data.pr_ID, context: context);
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
                                                                              : Container(),
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
                                                loading: () => const Loader()),
                                        //starts here

                                        // ends here list
                                        // add a condition to which if the buyer had bought the product
                                        // ask quetion buttuon
                                        Center(
                                          child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Pallete.balckColor,
                                                // shape: RoundedRectangleBorder(
                                                //     side: BorderSide(
                                                //   color: Pallete.balckColor,
                                                // )),
                                              ),
                                              onPressed: () {
                                                //  ask quetion buttuon

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuestionandAnswer(
                                                              byId: buyer.by_id,
                                                              prID:
                                                                  product.pr_id,
                                                              slID:
                                                                  product.sl_id,
                                                            )));
                                              },
                                              icon: const Icon(
                                                Icons.question_mark_sharp,
                                                color: Pallete.whiteColor,
                                              ),
                                              label: const Text(
                                                "Add Question ",
                                                style: TextStyle(
                                                    color: Pallete.whiteColor,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                        ),
                                        const SizedBox(height: 2),
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(height: 10),                                  //
                                  //
                                  // ratings
                                  const SizedBox(height: 3),
                                  Container(
                                    color: Pallete.whiteColor,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Review & Ratings",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, top: 5),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Pallete.loginBgColor,
                                                  foregroundColor:
                                                      Pallete.loginBgColor,
                                                  elevation: 2,
                                                  shape: BeveledRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    side: BorderSide(
                                                      color:
                                                          Pallete.loginBgColor,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  // here change to buyer fully bought products condition
                                                  if (buyer.by_add_to_cart
                                                      .contains(
                                                          product.pr_id)) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BuyerRatingScreen(
                                                                  prID: product
                                                                      .pr_id,
                                                                  slID: product
                                                                      .sl_id,
                                                                )));
                                                  } else {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "You cannot rate product which you haven't bought",
                                                      backgroundColor:
                                                          Pallete.redColor,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                    );
                                                  }
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
                                        ref
                                            .watch(getAllReviewIDSProvider(
                                                product.pr_id))
                                            .when(
                                                data: (data) {
                                                  // print(product.pr_id);
                                                  if (data.isEmpty) {
                                                    return const Center(
                                                      child: Text(
                                                        "No Review done",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Card.filled(
                                                                elevation: 2,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        side:
                                                                            BorderSide(
                                                                          color:
                                                                              Pallete.bgColor,
                                                                        )),
                                                                color: Pallete
                                                                    .whiteColor,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        textRating,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            top:
                                                                                5,
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            RatingStars(
                                                                          value:
                                                                              product.revRatings,
                                                                          // onValueChanged: (v) {
                                                                          //   setState(() {
                                                                          //     rate = v;
                                                                          //     if (kDebugMode) {
                                                                          //       print(rate);
                                                                          //     }
                                                                          //   });
                                                                          // },
                                                                          starSize:
                                                                              18,
                                                                          maxValue:
                                                                              5,
                                                                          starSpacing:
                                                                              1,
                                                                          maxValueVisibility:
                                                                              true,
                                                                          valueLabelVisibility:
                                                                              true,
                                                                          animationDuration:
                                                                              const Duration(
                                                                            milliseconds:
                                                                                1000,
                                                                          ),
                                                                          valueLabelMargin: const EdgeInsets
                                                                              .only(
                                                                              right: 3,
                                                                              left: 0,
                                                                              top: 5),
                                                                          valueLabelPadding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 1,
                                                                              horizontal: 04),
                                                                          starOffColor:
                                                                              Colors.grey,
                                                                          starColor:
                                                                              Colors.yellow,
                                                                          valueLabelRadius:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              6),
                                                                      // total ratings
                                                                      Text(
                                                                        "${product.review.length} Ratings given",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              // ends here left part
                                                              SizedBox(
                                                                height: 200,
                                                                child:
                                                                    CircularPercentIndicator(
                                                                  radius: 50,
                                                                  lineWidth:
                                                                      10.0,
                                                                  // value
                                                                  backgroundColor:
                                                                      Pallete
                                                                          .bgColor,
                                                                  percent: product
                                                                          .revRatings /
                                                                      10,
                                                                  animation:
                                                                      true,
                                                                  center: Text(
                                                                    // chnage this to toatlproductBought-total review given
                                                                    "${product.revRatings.round() * 10}%",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  progressColor:
                                                                      Pallete
                                                                          .greenColor,
                                                                  //
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Divider(
                                                            thickness: 2,
                                                            indent: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .03,
                                                            endIndent:
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .03,
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                        ],
                                                      ),
                                                      //
                                                      ListView.builder(
                                                        itemCount: data.length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          final revIndexs =
                                                              data[index];

                                                          if (kDebugMode) {
                                                            // print(revIndexs);
                                                            // print(data.length);
                                                          }
                                                          return ref
                                                              .watch(
                                                                  getParticularReviewDetailsProvider(
                                                                      revIndexs))
                                                              .when(
                                                                  data:
                                                                      (review) {
                                                                    final DateTime
                                                                        dateTime =
                                                                        DateTime.fromMillisecondsSinceEpoch(review
                                                                            .revUploadDateTime
                                                                            .millisecondsSinceEpoch);
                                                                    final String
                                                                        formatedTimeDate =
                                                                        DateFormat('dd-MM-yyyy hh:mm a')
                                                                            .format(dateTime);
                                                                    return SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                6),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                                                                                  child: RatingStars(
                                                                                    value: review.revratings,
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
                                                                                    valueLabelMargin: const EdgeInsets.only(right: 3, left: 0, top: 5),
                                                                                    valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 04),
                                                                                    starOffColor: Colors.grey,
                                                                                    starColor: Colors.yellow,
                                                                                    valueLabelRadius: 10,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(width: 10),
                                                                                Text(
                                                                                  review.mainReview,
                                                                                  style: const TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 17,
                                                                                  ),
                                                                                ),
                                                                                //
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            //
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                              child: ExpandableText(
                                                                                review.revDeatils,
                                                                                expandText: "Read more",
                                                                                collapseText: "Show less",
                                                                                maxLines: 2,
                                                                                linkColor: Pallete.blueColor,
                                                                                textAlign: TextAlign.justify,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 12),
                                                                            SizedBox(
                                                                              height: 90,
                                                                              child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemCount: 1,
                                                                                itemBuilder: (BuildContext context, int index) {
                                                                                  // return Image.asset("assets/4.png");
                                                                                  return CachedNetworkImage(
                                                                                    imageUrl: review.revImages[index],
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 4),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: Text(
                                                                                review.byName,
                                                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 8),
                                                                              child: Text(formatedTimeDate),
                                                                            ),
                                                                            const SizedBox(height: 9),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(left: 8),
                                                                                  height: 40,
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(
                                                                                      color: Pallete.balckColor,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Center(
                                                                                          child: IconButton(
                                                                                              onPressed: () {
                                                                                                ref.read(buyerHomeControProvider.notifier).aggreeReview(review);
                                                                                              },
                                                                                              icon: Icon(
                                                                                                review.revAgree.contains(buyer.by_id) ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                                                                                color: review.revAgree.contains(buyer.by_id) ? Pallete.greenColor : null,
                                                                                              )),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(right: 4),
                                                                                          child: Text(
                                                                                            "Helpfull for ${review.revAgree.length}",
                                                                                            style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(right: 6),
                                                                                  height: 40,
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(
                                                                                      color: Pallete.balckColor,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Center(
                                                                                          child: IconButton(
                                                                                              onPressed: () {
                                                                                                ref.read(buyerHomeControProvider.notifier).disAggreeReview(review);
                                                                                              },
                                                                                              icon: Icon(
                                                                                                review.revDisAgree.contains(buyer.by_id) ? Icons.thumb_down_alt : Icons.thumb_down_alt_outlined,
                                                                                                color: review.revDisAgree.contains(buyer.by_id) ? Pallete.redColor : null,
                                                                                              )),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(right: 4),
                                                                                          child: Text(
                                                                                            review.revDisAgree.length.toString(),
                                                                                            style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                review.byID == buyer.by_id
                                                                                    ? IconButton(
                                                                                        onPressed: () {
                                                                                          ref.watch(buyerHomeControProvider.notifier).deleteReview(byID: buyer.by_id, prID: product.pr_id, revID: review.revID);
                                                                                        },
                                                                                        icon: const Icon(
                                                                                          Icons.delete,
                                                                                          color: Pallete.redColor,
                                                                                        ))
                                                                                    : const SizedBox(),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 10),
                                                                            const Divider(),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  error: (error,
                                                                          stackTrace) =>
                                                                      ErrorText(
                                                                          errorMessage: error
                                                                              .toString()),
                                                                  loading: () =>
                                                                      const Loader());
                                                        },
                                                      ),
                                                      //
                                                      data.length > 3
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                // navigation to all review page
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            AllReviewPage(
                                                                              byID: buyer.by_id,
                                                                              prID: product.pr_id,
                                                                            )));
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
                                                                    child: Text(
                                                                      "All ${data.length} reviews",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            17,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            10),
                                                                    child: Icon(
                                                                      Icons
                                                                          .chevron_right_outlined,
                                                                      size: 30,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          : Container(),
                                                      data.length > 3
                                                          ? const SizedBox(
                                                              height: 13)
                                                          : const SizedBox(
                                                              height: 1.5),
                                                    ],
                                                  );
                                                },
                                                error: (error, stackTrace) =>
                                                    ErrorText(
                                                        errorMessage:
                                                            error.toString()),
                                                loading: () => const Loader()),

                                        // starts here
                                        //
                                        //

                                        // ends here
                                        // put a condition if the review number is greater than 3 only display button
                                      ],
                                    ),
                                  ),

                                  //
                                  //############$%^&* Other products from same seller
                                  Container(
                                    child: ref
                                        .watch(getSellerOtherProductsProvider(
                                            product.sl_id))
                                        .when(
                                            data: (data) {
                                              if (data.isEmpty) {
                                                return SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .6,
                                                  child: const Center(
                                                    child: Text(
                                                      "Products are Empty",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // const SizedBox(height: 8),

                                                    //
                                                    const SizedBox(height: 5),

                                                    Container(
                                                      height: 210,
                                                      width: double.infinity,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Pallete.whiteColor,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 8),
                                                            child: Text(
                                                              "Others Products of Seller",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Expanded(
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const BouncingScrollPhysics(),
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              shrinkWrap: true,
                                                              // itemCount: data.length > 1 ? 5 : 3,
                                                              // add a condition here
                                                              itemCount:
                                                                  data.length >
                                                                          6
                                                                      ? 6
                                                                      : data
                                                                          .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                final product =
                                                                    data[index];
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          PageTransition(
                                                                            child:
                                                                                ParticularProductScreen(product.pr_id),
                                                                            type:
                                                                                PageTransitionType.rightToLeft,
                                                                            ctx:
                                                                                context,
                                                                          ));
                                                                    },
                                                                    child: Card
                                                                        .filled(
                                                                      color: Pallete
                                                                          .whiteColor,
                                                                      elevation:
                                                                          2,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              15),
                                                                          side: BorderSide(
                                                                              color: Pallete.bgColor,
                                                                              width: 1.4)),
                                                                      child: Container(
                                                                          height: 150,
                                                                          width: MediaQuery.of(context).size.width * .5,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                          ),
                                                                          child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: CachedNetworkImage(
                                                                                          fit: BoxFit.fill,
                                                                                          imageUrl: product.pr_img[0],
                                                                                          progressIndicatorBuilder: (context, url, downloadProgress) => const Loader(),
                                                                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        product.brand,
                                                                                        maxLines: 1,
                                                                                        style: const TextStyle(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize: 16,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Text("data")

                                                    //
                                                  ],
                                                );
                                              }
                                            },
                                            error: (error, stackTrace) =>
                                                ErrorText(
                                                    errorMessage:
                                                        error.toString()),
                                            loading: () => const Loader()),
                                  ),
                                ],
                              );
                            },
                            error: (error, stackTrace) =>
                                ErrorText(errorMessage: error.toString()),
                            loading: () => const Loader()),
                  ],
                ),
              ));
  }
}
