import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/particular_product_screen.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';

class BuyerHometab extends ConsumerStatefulWidget {
  const BuyerHometab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuyerHometabState();
}

class _BuyerHometabState extends ConsumerState<BuyerHometab> {
  CarouselController buttonCarouselController = CarouselController();
  int pageCarouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(buyerHomeControProvider);
    final products = ref.watch(getAllProductsBuyerProvider);
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
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    ref.watch(getAllBannerProvider).when(
                        data: (data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 5),
                              Container(
                                color: Pallete.whiteColor,
                                width: double.infinity,
                                height: 250,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 4),
                                    CarouselSlider.builder(
                                      itemCount: data.first.ban_images.length,
                                      itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) {
                                        final product = data.first;
                                        if (kDebugMode) {
                                          // print(product.ban_images.length);
                                        }
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 350,
                                          decoration: BoxDecoration(
                                              color: Pallete.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                product.ban_images[itemIndex],
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
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
                                        enableInfiniteScroll: true,
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
                                          itemCount:
                                              data.first.ban_images.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              height: 10,
                                              width: 10,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    pageCarouselIndex == index
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
                            ],
                          );
                        },
                        error: (error, stackTrace) =>
                            ErrorText(errorMessage: error.toString()),
                        loading: () => const Loader()),

                    // brands for  you section#################################
                    ref.watch(getAllProductsBuyerProvider).when(
                        data: (data) {
                          if (data.isEmpty) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * .6,
                              child: const Center(
                                child: Text(
                                  "Products are Empty",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const SizedBox(height: 8),

                                //
                                const SizedBox(height: 5),

                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Pallete.whiteColor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Favourite Brands For You",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Expanded(
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          // itemCount: data.length > 1 ? 5 : 3,
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final product = data[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        child:
                                                            ParticularProductScreen(
                                                          product.pr_id,
                                                        ),
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        ctx: context,
                                                        // fullscreenDialog:
                                                        //     true,
                                                        // duration:
                                                        //     const Duration(
                                                        //   milliseconds: 200,
                                                        // ),
                                                      )
                                                      // MaterialPageRoute(
                                                      //     builder: (context) =>
                                                      //         ParticularProductScreen(
                                                      //             product.pr_id)),
                                                      );
                                                },
                                                child: Card.filled(
                                                  color: Pallete.whiteColor,
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      side: BorderSide(
                                                          color:
                                                              Pallete.bgColor,
                                                          width: 1.4)),
                                                  child: Container(
                                                      height: 150,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        // border: Border.all(
                                                        //     color: Pallete
                                                        //         .balckColor,
                                                        //     width: 1),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      imageUrl:
                                                                          product
                                                                              .pr_img[0],
                                                                      progressIndicatorBuilder: (context,
                                                                              url,
                                                                              downloadProgress) =>
                                                                          const Loader(),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          const Icon(
                                                                              Icons.error),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    product
                                                                        .brand,
                                                                    maxLines: 1,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
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
                            ErrorText(errorMessage: error.toString()),
                        loading: () => const Loader()),

                    //
                    //
                    // SOme popular products here
                    const SizedBox(height: 5),

                    ref.watch(getAllProductsBuyerProvider).when(
                        data: (data) {
                          if (data.isEmpty) {
                            return Container(
                              color: Pallete.whiteColor,
                              height: 100,
                              child: const Center(
                                child: Text(
                                  "Empty product list",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: double.infinity,
                              // height: MediaQuery.of(context).size.height * .8,
                              color: Pallete.whiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10, top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Product You Like",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        // IconButton(onPressed: (){}, icon: Icon(Icons.angll))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child:
                                                        ParticularProductScreen(
                                                      products.value![0].pr_id,
                                                    ),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    ctx: context,
                                                    // fullscreenDialog:
                                                    //     true,
                                                    // duration:
                                                    //     const Duration(
                                                    //   milliseconds: 200,
                                                    // ),
                                                  )
                                                  // MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         ParticularProductScreen(
                                                  //             product.pr_id)),
                                                  );
                                            },
                                            child: Card.filled(
                                              color: Pallete.whiteColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: BorderSide(
                                                      color: Pallete.bgColor)),
                                              elevation: 2,
                                              child: Container(
                                                height: 230,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .46,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // border: Border.all(
                                                  //     color: Pallete.balckColor,
                                                  //     width: 1),
                                                ),
                                                child: Column(children: [
                                                  Expanded(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.fill,
                                                        imageUrl: products
                                                            .value![0]
                                                            .pr_img[0],
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                const Loader(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    products.value![0].pr_name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                  )
                                                ]),
                                              ),
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child:
                                                        ParticularProductScreen(
                                                      products.value![1].pr_id,
                                                    ),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    ctx: context,
                                                    // fullscreenDialog:
                                                    //     true,
                                                    // duration:
                                                    //     const Duration(
                                                    //   milliseconds: 200,
                                                    // ),
                                                  )
                                                  // MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         ParticularProductScreen(
                                                  //             product.pr_id)),
                                                  );
                                            },
                                            child: Card.filled(
                                              color: Pallete.whiteColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: BorderSide(
                                                      color: Pallete.bgColor)),
                                              elevation: 2,
                                              child: Container(
                                                height: 230,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .46,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // border: Border.all(
                                                  //     color: Pallete.balckColor,
                                                  //     width: 2),
                                                ),
                                                child: Column(children: [
                                                  Expanded(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.fill,
                                                        imageUrl: products
                                                            .value![1]
                                                            .pr_img[0],
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                const Loader(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    products.value![1].pr_name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                  )
                                                ]),
                                              ),
                                            ),
                                          ),
                                          //
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child:
                                                        ParticularProductScreen(
                                                      products.value![2].pr_id,
                                                    ),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    ctx: context,
                                                    // fullscreenDialog:
                                                    //     true,
                                                    // duration:
                                                    //     const Duration(
                                                    //   milliseconds: 200,
                                                    // ),
                                                  )
                                                  // MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         ParticularProductScreen(
                                                  //             product.pr_id)),
                                                  );
                                            },
                                            child: Card.filled(
                                              color: Pallete.whiteColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: BorderSide(
                                                      color: Pallete.bgColor)),
                                              elevation: 2,
                                              child: Container(
                                                height: 230,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .46,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // border: Border.all(
                                                  //     color: Pallete.balckColor,
                                                  //     width: 2),
                                                ),
                                                child: Column(children: [
                                                  Expanded(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.fill,
                                                        imageUrl: products
                                                            .value![2]
                                                            .pr_img[0],
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                const Loader(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    products.value![2].pr_name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                  )
                                                ]),
                                              ),
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child:
                                                        ParticularProductScreen(
                                                      products.value![3].pr_id,
                                                    ),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    ctx: context,
                                                    // fullscreenDialog:
                                                    //     true,
                                                    // duration:
                                                    //     const Duration(
                                                    //   milliseconds: 200,
                                                    // ),
                                                  )
                                                  // MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         ParticularProductScreen(
                                                  //             product.pr_id)),
                                                  );
                                            },
                                            child: Card.filled(
                                              color: Pallete.whiteColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: BorderSide(
                                                      color: Pallete.bgColor)),
                                              elevation: 2,
                                              child: Container(
                                                height: 230,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .46,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // border: Border.all(
                                                  //     color: Pallete.balckColor,
                                                  //     width: 2),
                                                ),
                                                child: Column(children: [
                                                  Expanded(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.fill,
                                                        imageUrl: products
                                                            .value![3]
                                                            .pr_img[0],
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                const Loader(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    products.value![3].pr_name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                              ),
                                            ),
                                          ),
                                          //
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        error: (error, stackTrace) =>
                            ErrorText(errorMessage: error.toString()),
                        loading: () => const Loader()),
                    const SizedBox(height: 5),

                    ref.watch(getCartDeatilsBuyerProvider(buyer.by_id)).when(
                          data: (data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const SizedBox(height: 8),

                                //
                                // const SizedBox(height: 5),

                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Pallete.whiteColor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                          "Your Cart Item",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Expanded(
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              data.length > 2 ? 2 : data.length,
                                          // itemCount:
                                          //     snapshot.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final productIndx = data[index];
                                            return ref
                                                .watch(
                                                    getParticularProductdetailsBuyerProvider(
                                                        productIndx))
                                                .when(
                                                    data: (product) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            //
                                                            Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                  child:
                                                                      ParticularProductScreen(
                                                                    product
                                                                        .pr_id,
                                                                  ),
                                                                  type: PageTransitionType
                                                                      .rightToLeft,
                                                                  ctx: context,
                                                                  // fullscreenDialog:
                                                                  //     true,
                                                                  duration:
                                                                      const Duration(
                                                                    milliseconds:
                                                                        200,
                                                                  ),
                                                                )
                                                                // MaterialPageRoute(
                                                                //     builder: (context) =>
                                                                //         ParticularProductScreen()),
                                                                );
                                                          },
                                                          child: Card.filled(
                                                            color: Pallete
                                                                .whiteColor,
                                                            elevation: 2,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                                side: BorderSide(
                                                                    // once use loginbg color
                                                                    color: Pallete.loginBgColor,
                                                                    width: 1.4)),
                                                            child: Container(
                                                                height: 150,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .5,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  // border: Border.all(
                                                                  //     color: Pallete
                                                                  //         .balckColor,
                                                                  //     width: 1.5),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Column(
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
                                                    error: (error,
                                                            stackTrace) =>
                                                        ErrorText(
                                                            errorMessage: error
                                                                .toString()),
                                                    loading: () =>
                                                        const Loader());
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
                          },
                          error: (error, stackTrace) =>
                              ErrorText(errorMessage: error.toString()),
                          loading: () => const Loader(),
                        ),
                    const SizedBox(height: 5),

                    //
                    //
                  ],
                ),
              ));
  }
}
