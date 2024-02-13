import 'dart:io';

import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Core/Utils/utils.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_ecommerce/Features/Homescreen/Controller/add_product_contro.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProductScreenSeller extends ConsumerStatefulWidget {
  final String prID;
  const EditProductScreenSeller({
    super.key,
    required this.prID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProductScreenSellerState();
}

class _EditProductScreenSellerState
    extends ConsumerState<EditProductScreenSeller> {
  late TextEditingController _productName;
  late TextEditingController _productDesc;
  late TextEditingController _productAmt;
  late TextEditingController _productDisc;
  late TextEditingController _productcategory;
  late TextEditingController _brand;
  late List<File?> productImage = [];
  int pageCarouselIndex = 0;
  CarouselController buttonCarouselController = CarouselController();

  Future<void> selectProductImage() async {
    final res = await pickImage();
    if (res != null) {
      if (kIsWeb) {
        // productWebImage = res.paths.map((e) => File(e!)).toList();
        Fluttertoast.showToast(msg: "Implementaion Add it manh");
      } else {}
      setState(() {
        productImage = res.paths.map((path) => File(path!)).toList();
      });
    }
  }

  @override
  void initState() {
    _productName = TextEditingController(
        text: ref
            .read(getParticularProductInfoProvider(widget.prID))
            .value!
            .pr_name);

    _productDesc = TextEditingController(
        text: ref
            .read(getParticularProductInfoProvider(widget.prID))
            .value!
            .description);
    _productAmt = TextEditingController(
        text: ref
            .read(getParticularProductInfoProvider(widget.prID))
            .value!
            .pr_ammount
            .toString());
    _productcategory = TextEditingController(
        text: ref
            .read(getParticularProductInfoProvider(widget.prID))
            .value!
            .pr_catogory);
    _brand = TextEditingController(
        text: ref
            .read(getParticularProductInfoProvider(widget.prID))
            .value!
            .brand);
    _productDisc = TextEditingController(
        text: ref
            .read(getParticularProductInfoProvider(widget.prID))
            .value!
            .discount_Ammount
            .toString());
    if (kDebugMode) {
      print(ref
          .read(getParticularProductInfoProvider(widget.prID))
          .value!
          .discount_Ammount
          .toString());
    }

    super.initState();
  }

  // void deleteProductImage({required String pr_id, String prImgLink}) {
  //   ref.read(addProductControProvider.notifier).deleteProductImage(
  //       context: context, pr_id: pr_id, pr_imgLink: prImgLink);
  // }

  @override
  void dispose() {
    _brand.dispose();
    _productAmt.dispose();
    _productDesc.dispose();
    _productName.dispose();
    _productcategory.dispose();
    _productDisc.dispose();
    super.dispose();
  }

  void update(String prID, String pname, String pdes) {
    double? pramnt = double.tryParse(_productAmt.text);
    double? prdisc = double.tryParse(_productDisc.text);
    ref.read(addProductControProvider.notifier).editProduct(
          productImage,
          context: context,
          productName: pname.trimRight(),
          productDescription: pdes.trimRight(),
          pr_disc: prdisc! == 0 ? 0.0 : prdisc,
          productAmt: pramnt!,
          pr_id: prID,
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(addProductControProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.loginBgColor,
        title: const Text("Edit Product"),
        automaticallyImplyLeading: true,
      ),
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ref.watch(getParticularProductInfoProvider(widget.prID)).when(
                      data: (data) {
                        return Column(
                          children: [
                            // List of images here
                            const SizedBox(height: 5),
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
                                    itemCount: data.pr_img.length,
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 350,
                                        decoration: BoxDecoration(
                                            color: Pallete.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: CachedNetworkImage(
                                                height: 250,
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                    data.pr_img[itemIndex],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        const Loader(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                            data.pr_img.length > 3
                                                ? Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    left: 0,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        //   // Delete Image
                                                        ref
                                                            .watch(
                                                                addProductControProvider
                                                                    .notifier)
                                                            .deleteProductImage(
                                                              context: context,
                                                              pr_id: data.pr_id,
                                                              pr_imgLink: data
                                                                      .pr_img[
                                                                  itemIndex],
                                                            );

                                                        if (kDebugMode) {
                                                          print(
                                                              "Edit page: ${data.pr_img[itemIndex]}");
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        size: 50,
                                                        color: Pallete.redColor,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      autoPlay: false,
                                      enableInfiniteScroll:
                                          data.pr_img.length > 1 ? true : false,
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
                                        itemCount: data.pr_img.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
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
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            //
                            FieldFormWidget(
                              productName: _productName,
                              maxLine: null,
                              labelText: "Proeuct name",
                              hintText: "Product Name",
                              icon: Icons.text_fields,
                              maxC: 500,
                              textInputType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              readOnly: false,
                            ),
                            const SizedBox(height: 15),
                            FieldFormWidget(
                              productName: _productDesc,
                              maxLine: null,
                              labelText: "Proeuct Description",
                              hintText: "Product Description",
                              icon: Icons.details_outlined,
                              maxC: 800,
                              textInputType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.sentences,
                              readOnly: false,
                            ),
                            const SizedBox(height: 15),
                            FieldFormWidget(
                              productName: _productAmt,
                              hintText: "Product Ammount",
                              labelText: "Product Ammount",
                              icon: Icons.numbers_sharp,
                              maxC: 10,
                              maxLine: 1,
                              textInputType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              readOnly: false,
                            ),
                            const SizedBox(height: 15),
                            FieldFormWidget(
                              productName: _productDisc,
                              hintText: "Product Discount",
                              labelText: "Product Discount",
                              icon: Icons.numbers_sharp,
                              maxC: 10,
                              maxLine: 1,
                              textInputType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              readOnly: false,
                            ),
                            const SizedBox(height: 15),
                            FieldFormWidget(
                              productName: _productcategory,
                              hintText: "Product Category",
                              labelText: "Product Category",
                              icon: Icons.numbers_sharp,
                              maxC: 10,
                              maxLine: 1,
                              textInputType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              readOnly: true,
                            ),
                            const SizedBox(height: 15),
                            FieldFormWidget(
                              productName: _brand,
                              hintText: "Product Brand",
                              labelText: "Product Brand",
                              icon: Icons.branding_watermark,
                              maxC: 10,
                              maxLine: 1,
                              textInputType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              readOnly: true,
                            ),
                            const SizedBox(height: 15),

                            //

                            //
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Center(
                                  child: Text(
                                    "Add the product images below",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    selectProductImage();
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Pallete.balckColor,
                                  ),
                                ),
                              ],
                            ),
                            productImage.isEmpty
                                ? Container()
                                : SizedBox(
                                    height: 310,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: productImage.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.transparent,
                                          onLongPress: () {
                                            if (kDebugMode) {
                                              print("deleted");
                                            }

                                            Fluttertoast.showToast(
                                              msg: "Deleted Product Image",
                                            );

                                            productImage.removeAt(index);
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Pallete.balckColor,
                                              ),
                                              image: DecorationImage(
                                                image: FileImage(
                                                    productImage[index]!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                            //
                            // will add edit  image for it
                            const SizedBox(height: 15),

                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Pallete.greenColor,
                                  elevation: 5,
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width * .5,
                                    60,
                                  ),
                                  backgroundColor: Pallete.greenColor,
                                ),
                                onPressed: () {
                                  // setState(() {});
                                  if (_productAmt.text.isEmpty ||
                                      _productDisc.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Fill the Ammount and Discount fields",
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Pallete.redColor);
                                  } else {
                                    update(data.pr_id, _productName.text,
                                        _productDesc.text);
                                  }
                                },
                                icon: const Icon(
                                  Icons.update,
                                  color: Pallete.whiteColor,
                                ),
                                label: const Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            const SizedBox(height: 10),
                          ],
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

class FieldFormWidget extends StatelessWidget {
  const FieldFormWidget({
    super.key,
    required TextEditingController productName,
    required this.maxLine,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.maxC,
    required this.textInputType,
    required this.textCapitalization,
    required this.readOnly,
  }) : _productName = productName;

  final TextEditingController _productName;
  final dynamic maxLine;
  final String labelText;
  final String hintText;
  final IconData icon;
  final int maxC;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onTapOutside: (v) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: _productName,
        maxLines: maxLine,
        maxLength: maxC,
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        readOnly: readOnly,
        decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: TextStyle(

              // fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold),
          contentPadding: const EdgeInsets.all(25),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              icon,
              size: 25,
              color: Colors.grey.shade600,
            ),
          ),
          fillColor: Colors.grey.shade50,
          focusColor: Colors.grey.shade50,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 3,
              color: Colors.grey,
            ),
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black26,
            ),
          ),
        ),
      ),
    );
  }
}
