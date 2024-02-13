import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Screens/Extra%20Screen/buyer_detailed_category.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class BuyercategoryTab extends ConsumerStatefulWidget {
  const BuyercategoryTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BuyercategoryTabState();
}

class _BuyercategoryTabState extends ConsumerState<BuyercategoryTab> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(buyerHomeControProvider);
    return Scaffold(
        backgroundColor: Pallete.whiteColor,
        body: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: const Center(
                  child: Loader(),
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const DetailedCategoryScreen(
                                          query: "Mobile",
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                        ctx: context,
                                      ));
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 100,
                                  child: Card.filled(
                                    elevation: 2,
                                    color: Pallete.bgColor,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          child: Image.asset(
                                            "assets/categories/mobile.png",
                                            height: 80,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const Text(
                                          "Mobile",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const DetailedCategoryScreen(
                                          query: "Laptop",
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                        ctx: context,
                                      ));
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 100,
                                  child: Card.filled(
                                    elevation: 2,
                                    // margin: EdgeInsets.only(left: ),
                                    color: Pallete.bgColor,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          child: Image.asset(
                                            "assets/categories/laptop.png",
                                            height: 80,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const Text(
                                          "Laptop",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const DetailedCategoryScreen(
                                          query: "Camera",
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                        ctx: context,
                                      ));
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 100,
                                  child: Card.filled(
                                    elevation: 2,
                                    // margin: EdgeInsets.only(left: ),
                                    color: Pallete.bgColor,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          child: Image.asset(
                                            "assets/categories/camera.png",
                                            height: 80,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const Text(
                                          "Camera",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Tshirt",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/tshirt1.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "T-Shirt",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Shoe",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/shoe.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Shoe",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Jeans",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/jeans.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Jeans",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Shirt",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/shirt.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Shirt",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Hair_Dryer",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/hairdryer.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Hair Dryer",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Iron_box",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/ironbox.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Iron box",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Headphones",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/headphone.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Headphone",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Neckband",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/neckband.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Neckband",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Beanbag",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/couch.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Bean bag",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Powerbank",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/powerbank.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Power bank",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Mixer",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/mixer.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Mixer",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Remote",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/remote.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Remote",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Shampoo",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/shampoo.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Shampoo",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Trimmer",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/trimmer.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Trimmer",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Jwellery",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/jwellery.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "Jwellery",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const DetailedCategoryScreen(
                                            query: "Tv",
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          ctx: context,
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Card.filled(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(left: ),
                                      color: Pallete.bgColor,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10),
                                            child: Image.asset(
                                              "assets/categories/tv.png",
                                              height: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            "television",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ));
  }
}
