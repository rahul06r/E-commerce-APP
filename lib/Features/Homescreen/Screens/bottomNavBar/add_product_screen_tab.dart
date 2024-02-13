import 'dart:io';

import 'package:app_ecommerce/Core/Utils/utils.dart';
import 'package:app_ecommerce/Features/Auth/Controller/seller_auth_contro.dart';
import 'package:app_ecommerce/Features/Homescreen/Controller/add_product_contro.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductTab extends ConsumerStatefulWidget {
  const AddProductTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductTabState();
}

class _AddProductTabState extends ConsumerState<AddProductTab> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productDesc = TextEditingController();
  final TextEditingController _productAmt = TextEditingController();
  final TextEditingController _productcategory = TextEditingController();
  final TextEditingController _brand = TextEditingController();
  late List<File?> productImage = [];
  late List<Uint8List?> productWebImage = [];
  final List<String> _categoriesItems = [
    'Mobile',
    'Latop',
    'Camera',
    'Tshirt',
    'Shoe',
    'Jeans',
    'Shirt',
    'Hair_Dryer',
    'Iron_box',
    'Headphones',
    'Neckband',
    'Beanbag',
    'Powerbank',
    'Mixer',
    'Remote',
    'Shampoo',
    'Trimmer',
    'Jwellery',
    'Television',
  ];
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
  void dispose() {
    _productAmt.dispose();
    _productDesc.dispose();
    _productName.dispose();
    _brand.dispose();
    _productcategory.dispose();

    super.dispose();
  }

  //

  void addProducts({
    required String sellerId,
    required String productName,
    required String productDescription,
    required String productCategory,
    required double productAmt,
    required String brand,
  }) {
    ref.read(addProductControProvider.notifier).addProducts(
          productImages: productImage,
          // productWebImage: "",
          context: context,
          sellerId: sellerId,
          productName: productName,
          productDescription: productDescription,
          productCategory: productCategory,
          productAmt: productAmt,
          brand: brand,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(addProductControProvider);
    final seller = ref.watch(sellerUserProvider)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Center(
                    child: Text(
                      "Add Product",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //

                  const SizedBox(height: 15),
                  FieldFormWidget(
                    productName: _productName,
                    hintText: "Product Name",
                    labelText: "Product Name",
                    icon: Icons.text_fields,
                    maxC: 500,
                    maxLine: null,
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 15),
                  FieldFormWidget(
                    productName: _productDesc,
                    hintText: "Product Description",
                    labelText: "Product Description",
                    icon: Icons.details_outlined,
                    maxC: 800,
                    maxLine: null,
                    textInputType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
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
                  ),
                  //
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButton(
                            // isExpanded: true,

                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Pallete.balckColor),
                            elevation: 2,
                            hint: _productcategory.text.isEmpty
                                ? const Text(
                                    "Select the category",
                                  )
                                : Text(_productcategory.text),
                            items: _categoriesItems.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(() {
                                _productcategory.text = v!;
                              });
                            }),
                      ),
                    ),
                  ),

                  // FieldFormWidget(
                  //   productName: _productcategory,
                  //   hintText: "Product Category",
                  //   labelText: "Product Category",
                  //   icon: Icons.numbers_sharp,
                  //   maxC: 10,
                  //   maxLine: 1,
                  //   textInputType: TextInputType.text,
                  // ),
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
                  ),
                  const SizedBox(height: 15),

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
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  productImage.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 310,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: productImage.length,
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

                                  productImage.removeAt(index);
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
                                      image: FileImage(productImage[
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

                  const SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.loginBgColor,
                          fixedSize: const Size(200, 50),
                        ),
                        onPressed: () {
                          double? productAmmount =
                              double.tryParse(_productAmt.text);
                          //
                          //
                          //
                          if (_productName.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Product Name required!!",
                                backgroundColor: Pallete.redColor,
                                gravity: ToastGravity.CENTER,
                                fontSize: 19);
                          } else if (_productDesc.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Product Description required!!",
                                backgroundColor: Pallete.redColor,
                                gravity: ToastGravity.CENTER,
                                fontSize: 19);
                          } else if (_productAmt.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Product Ammount required!!",
                                backgroundColor: Pallete.redColor,
                                gravity: ToastGravity.CENTER,
                                fontSize: 19);
                          } else if (_brand.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Product Brand name required!!",
                                backgroundColor: Pallete.redColor,
                                gravity: ToastGravity.CENTER,
                                fontSize: 19);
                          } else if (productImage.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Product Image required!!",
                                backgroundColor: Pallete.redColor,
                                gravity: ToastGravity.CENTER,
                                fontSize: 19);
                          } else {
                            addProducts(
                              sellerId: seller.id,
                              productName: _productName.text.trimRight(),
                              productDescription: _productDesc.text,
                              productCategory: _productcategory.text,
                              productAmt: productAmmount!,
                              brand: _brand.text,
                            );
                            setState(() {
                              productImage.clear();
                              _productAmt.clear();
                              _productDesc.clear();
                              _productName.clear();
                              _productcategory.clear();
                              _brand.clear();
                            });
                          }
                        },
                        child: const Text(
                          "Add Product",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Pallete.whiteColor,
                          ),
                        )),
                  ),
                  const SizedBox(height: 15),
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
  }) : _productName = productName;

  final TextEditingController _productName;
  final dynamic maxLine;
  final String labelText;
  final String hintText;
  final IconData icon;
  final int maxC;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;

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
