import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Controller/adminHomeScreenContro.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminHomeTab extends ConsumerStatefulWidget {
  const AdminHomeTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminHomeTabState();
}

class _AdminHomeTabState extends ConsumerState<AdminHomeTab> {
  int pageCarouselIndex = 0;
  void deleteBanner(String bn_id) {
    ref
        .read(adminHomeScreenControProvider.notifier)
        .deleteBanner(bn_id: bn_id, context: context);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(adminHomeScreenControProvider);

    return Scaffold(
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : Column(
              children: [
                ref.watch(getAllBannerProvider).when(
                    data: (banners) {
                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: banners.length,
                          itemBuilder: (BuildContext context, int index) {
                            final bannerImage = banners[index];
                            print("banners lenght ${banners.length}");
                            return Container(
                              color: Pallete.whiteColor,
                              height: 320,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                      ),
                                      Text(
                                        "Banner ${index + 1}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                // delete the banner product
                                              },
                                              icon: const Icon(
                                                Icons.hide_image,
                                                // color: Pallete.redColor,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                // delete the banner product
                                                // setState(() {});
                                                if (banners.length > 1) {
                                                  print(banners.length);
                                                  deleteBanner(
                                                      bannerImage.ban_id);
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Before deleting this add new one!",
                                                    backgroundColor:
                                                        Pallete.redColor,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                  );
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Pallete.redColor,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  CarouselSlider.builder(
                                    itemCount: bannerImage.ban_images.length,
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 360,
                                        decoration: BoxDecoration(
                                            color: Pallete.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl:
                                              bannerImage.ban_images[itemIndex],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const Loader(),
                                          errorWidget: (context, url, error) =>
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
                                            bannerImage.ban_images.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print(bannerImage.ban_images.length);
                                          return Container(
                                            height: 10,
                                            width: 10,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: pageCarouselIndex == index
                                                  ? Pallete.balckColor
                                                  : Pallete.bgColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) =>
                        ErrorText(errorMessage: error.toString()),
                    loading: () => const Loader()),
              ],
            ),
    );
  }
}
