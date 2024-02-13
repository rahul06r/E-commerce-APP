// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Core/Utils/utils.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';

class BuyerRatingScreen extends ConsumerStatefulWidget {
  final String slID;
  final String prID;
  const BuyerRatingScreen({
    super.key,
    required this.slID,
    required this.prID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BuyerRatingScreenState();
}

class _BuyerRatingScreenState extends ConsumerState<BuyerRatingScreen> {
  final TextEditingController _mainTextContro = TextEditingController();
  final TextEditingController _description = TextEditingController();
  double rate = 0;
  late List<File?> reviewImage = [];
  Future<void> selectProductImage() async {
    final res = await pickImage();
    if (res != null) {
      if (kIsWeb) {
        // productWebImage = res.paths.map((e) => File(e!)).toList();
        Fluttertoast.showToast(msg: "Implementaion Add it manh");
      } else {}
      setState(() {
        reviewImage = res.paths.map((path) => File(path!)).toList();
      });
    }
  }

  void addRatings({
    required String mainReview,
    required String revDeatils,
    required String prID,
    required String byID,
    required String slID,
    required String byName,
    required double revrating,
  }) {
    ref.read(buyerHomeControProvider.notifier).addReview(
          context: context,
          reviewImages: reviewImage,
          mainReview: mainReview,
          revDeatils: revDeatils,
          prID: prID,
          byID: byID,
          slID: slID,
          byName: byName,
          revrating: revrating,
        );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _description.dispose();
    _mainTextContro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buyer = ref.read(buyerUserProvider)!;
    final isLoading = ref.watch(buyerHomeControProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.loginBgColor,
        automaticallyImplyLeading: true,
        title: const Text(
          "Rating Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : SingleChildScrollView(
              // physics: FixedExtentScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: RatingStars(
                        value: rate,
                        onValueChanged: (v) {
                          setState(() {
                            rate = v;
                            if (kDebugMode) {
                              print(rate);
                            }
                          });
                        },
                        starSize: 30,
                        maxValue: 5,
                        starSpacing: 1,
                        maxValueVisibility: true,
                        valueLabelVisibility: true,
                        animationDuration: const Duration(
                          milliseconds: 1000,
                        ),
                        valueLabelMargin:
                            const EdgeInsets.only(right: 3, left: 0, top: 5),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 04),
                        starOffColor: Colors.grey,
                        starColor: Colors.yellow,
                        valueLabelRadius: 10,
                      ),
                    ),
                  ),
                  // ends star here
                  //
                  //
                  // main Text
                  const SizedBox(height: 15),
                  TextDisplayWidget(
                    name: _mainTextContro,
                    maxLine: 1,
                    labelText: "Main Review",
                    hintText: "Main Review",
                    icon: Icons.text_fields,
                    maxC: 70,
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(height: 15),
                  //
                  // Description Text
                  //
                  TextDisplayWidget(
                    name: _description,
                    maxLine: null,
                    labelText: "Description Review",
                    hintText: "Description Review",
                    icon: Icons.description,
                    maxC: 700,
                    textInputType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 20),
                  //
                  //
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          "Add the Product Images For review",
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
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  reviewImage.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 310,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: reviewImage.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.transparent,
                                onLongPress: () {
                                  if (kDebugMode) {
                                    print("deleted");
                                  }

                                  Fluttertoast.showToast(
                                    msg: "Deleted Product Image",
                                  );

                                  reviewImage.removeAt(index);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 300,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Pallete.balckColor,
                                    ),
                                    image: DecorationImage(
                                      image: FileImage(reviewImage[
                                          index]!), // Replace with your image path
                                      fit: BoxFit
                                          .cover, // Adjust this based on your needs
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        backgroundColor: Pallete.loginBgColor,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * .8, 50),
                      ),
                      onPressed: () {
                        if (rate == 0.0) {
                          Fluttertoast.showToast(
                              msg: "Add Rating",
                              gravity: ToastGravity.TOP,
                              backgroundColor: Pallete.redColor);
                        } else {
                          if (_mainTextContro.text.isEmpty ||
                              _description.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Add Review",
                                gravity: ToastGravity.TOP,
                                backgroundColor: Pallete.redColor);
                          } else {
                            if (reviewImage.isEmpty) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Add atleast 1 image for better Clarification",
                                  gravity: ToastGravity.TOP,
                                  backgroundColor: Pallete.redColor);
                            } else {
                              // add review here
                              addRatings(
                                mainReview: _mainTextContro.text.trimRight(),
                                revDeatils: _description.text.trimRight(),
                                prID: widget.prID,
                                byID: buyer.by_id,
                                slID: widget.slID,
                                byName: buyer.by_name,
                                revrating: rate,
                              );

                              //
                              _description.clear();
                              _mainTextContro.clear();
                              reviewImage.clear();
                              rate = 0;
                            }
                          }
                        }
                      },
                      icon: const Icon(Icons.check, color: Pallete.whiteColor),
                      label: const Text(
                        "Add Review",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Pallete.whiteColor,
                        ),
                      )),
                  const SizedBox(height: 10),
                ],
              ),
            ),
    );
  }
}

class TextDisplayWidget extends StatelessWidget {
  const TextDisplayWidget({
    super.key,
    required TextEditingController name,
    // required this.isProEdit,
    required this.maxLine,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.maxC,
    required this.textInputType,
  }) : _name = name;

  final TextEditingController _name;
  // final bool isProEdit;
  final dynamic maxLine;
  final String labelText;
  final String hintText;
  final IconData icon;
  final int maxC;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onTapOutside: (v) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: _name,
        maxLines: maxLine,
        // readOnly: isProEdit,
        maxLength: maxC,
        keyboardType: textInputType,
        decoration: InputDecoration(
          label: Text(
            labelText,
          ),
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
          // suffixIcon: Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Icon(
          //     Icons.text_fields,
          //     size: 25,
          //     color: Colors.grey.shade600,
          //   ),
          // ),
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
