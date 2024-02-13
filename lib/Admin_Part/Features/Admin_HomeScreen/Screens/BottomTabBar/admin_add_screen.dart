import 'dart:io';

import 'package:app_ecommerce/Admin_Part/Features/Admin_Auth/Controller/admin_auth_contro.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Controller/adminHomeScreenContro.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Core/Utils/utils.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminAddTab extends ConsumerStatefulWidget {
  const AdminAddTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminAddTabState();
}

class _AdminAddTabState extends ConsumerState<AdminAddTab> {
  final List<String> _items = [
    "Banner",
    "FromUS",
  ];
  final TextEditingController _addDefault = TextEditingController();
  late List<File?> bannerImages = [];
  Future<void> selectBannerImage() async {
    final res = await pickImage();
    if (res != null) {
      if (kIsWeb) {
        // productWebImage = res.paths.map((e) => File(e!)).toList();
        Fluttertoast.showToast(msg: "Implementaion Add it manh");
      } else {}
      setState(() {
        bannerImages = res.paths.map((path) => File(path!)).toList();
      });
    }
  }

  void addBanner() {
    ref
        .read(adminHomeScreenControProvider.notifier)
        .addBanner(bannerImages: bannerImages, context: context);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(adminHomeScreenControProvider);
    return Scaffold(
        backgroundColor: Pallete.whiteColor,
        body: isLoading
            ? const Center(
                child: Loader(),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Center(
                      child: DropdownButton(
                        hint: _addDefault.text.isEmpty
                            ? const Text(
                                "Select the Purpose",
                              )
                            : Text(_addDefault.text),
                        items: _items.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            _addDefault.text = v!;
                          });
                        },
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Pallete.balckColor),
                        elevation: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          "Add the banner product images",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          selectBannerImage();
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          color: Pallete.balckColor,
                        ),
                      ),
                    ],
                  ),
                  //
                  //
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  //
                  //
                  bannerImages.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 310,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: bannerImages.length,
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

                                  bannerImages.removeAt(index);
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
                                      image: FileImage(bannerImages[
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

                  //
                  //
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  //
                  //
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: Pallete.blueColor,
                        fixedSize: const Size(200, 50),
                        backgroundColor: Pallete.blueColor,
                      ),
                      onPressed: () {
                        // check if the image has 2 minimum,
                        // drop down is slected or not,
                        if (bannerImages.length >= 2) {
                          if (_addDefault.text == "Banner") {
                            addBanner();
                            setState(() {
                              bannerImages.clear();
                              _addDefault.clear();
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: "Select The dropdown list",
                              backgroundColor: Pallete.redColor,
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Select More than 2 images for banner",
                            backgroundColor: Pallete.redColor,
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Pallete.whiteColor,
                        size: 30,
                      ),
                      label: const Text(
                        "Upload",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Pallete.whiteColor,
                        ),
                      )),
                ],
              ));
  }
}
