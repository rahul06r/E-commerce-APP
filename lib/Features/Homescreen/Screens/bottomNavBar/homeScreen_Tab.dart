import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Features/Auth/Controller/seller_auth_contro.dart';
import 'package:app_ecommerce/Features/Homescreen/Controller/add_product_contro.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/product_description_screen.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenTab extends ConsumerStatefulWidget {
  const HomeScreenTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends ConsumerState<HomeScreenTab> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sellerID = ref.watch(sellerUserProvider)!.id;
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 2),
          Container(
            height: 80,
            width: double.infinity,
            color: Pallete.whiteColor,
            child: const Center(
              child: Text(
                "List of your Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 15),
          const SizedBox(height: 15),
          Expanded(
            child: ref.watch(getAllProductsProvider(sellerID)).when(
                data: (data) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final productIndx = data[index];
                      return ref
                          .watch(getParticularProductInfoProvider(productIndx))
                          .when(
                              data: (product) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDescriptionScreen(
                                                    prId: product.pr_id)));
                                  },
                                  child: Container(
                                    height: 350,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Color.fromARGB(
                                              255, 240, 237, 237),
                                        )
                                      ],
                                      // color: Pallete.redColor,
                                      border: Border.all(
                                        // color: Pallete.balckColor,
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.zero,
                                          bottomRight: Radius.zero,
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft: Radius.zero,
                                                    bottomRight: Radius.zero,
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                            child: Image.network(
                                              product.pr_img[0],
                                              fit: BoxFit.fill,
                                              // check for it
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                product.pr_name,
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  product.discount_Ammount ==
                                                          0.0
                                                      ? MainAxisAlignment.center
                                                      : MainAxisAlignment
                                                          .spaceAround,
                                              children: [
                                                Text(
                                                  "₹  ${product.pr_ammount.toString()}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        product.discount_Ammount !=
                                                                0
                                                            ? Colors.black45
                                                            : Pallete
                                                                .balckColor,
                                                    decoration:
                                                        product.discount_Ammount !=
                                                                0
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : null,
                                                  ),
                                                ),
                                                product.discount_Ammount != 0
                                                    ? Text(
                                                        "₹  ${product.discount_Ammount.toString()}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              error: (error, stackTrace) =>
                                  ErrorText(errorMessage: error.toString()),
                              loading: () => const Loader());
                    },
                  );
                },
                error: (error, stackTrace) =>
                    ErrorText(errorMessage: error.toString()),
                loading: () => const Loader()),
          ),
        ],
      ),
    );
  }
}
