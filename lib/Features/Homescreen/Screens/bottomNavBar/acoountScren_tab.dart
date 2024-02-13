import 'dart:io';

import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Core/Utils/utils.dart';
import 'package:app_ecommerce/Features/Auth/Controller/seller_auth_contro.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreentab extends ConsumerStatefulWidget {
  const AccountScreentab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountScreentabState();
}

class _AccountScreentabState extends ConsumerState<AccountScreentab> {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _address;
  late TextEditingController _desc;
  late TextEditingController _phone;
  bool isProEdit = true;

  File? profileImage;
  Uint8List? profileWebImage;
  Future<void> selectProfileImage() async {
    final res = await pickSingleImage();
    if (res != null) {
      if (kIsWeb) {
        setState(() {
          profileWebImage = res.files.first.bytes;
        });
      } else {}

      setState(() {
        profileImage = File(res.files.first.path!);
      });
    }
  }

  @override
  void initState() {
    _name = TextEditingController(text: ref.read(sellerUserProvider)!.name);
    _email = TextEditingController(text: ref.read(sellerUserProvider)!.email);
    _desc =
        TextEditingController(text: ref.read(sellerUserProvider)!.description);
    _address =
        TextEditingController(text: ref.read(sellerUserProvider)!.address);

    _phone = TextEditingController(
        text: ref.read(sellerUserProvider)!.sl_phone.toString());
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    super.dispose();
  }

  void save() {
    int? phoneNumber = int.tryParse(_phone.text);
    ref.read(sellerauthControllerProvider.notifier).editProfile(
          context: context,
          profileImage: profileImage,
          profileWebImage: profileWebImage,
          name: _name.text.trim(),
          address: _address.text.trim(),
          desc: _desc.text.trim(),
          phoneNumber: phoneNumber!,
        );
  }

  void logout() {
    ref.read(sellerauthControllerProvider.notifier).sellerLogout();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(sellerauthControllerProvider);
    final seller = ref.watch(sellerUserProvider)!;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Pallete.loginBgColor,
      //   onPressed: () {
      //     setState(() {
      //       isProEdit = !isProEdit;
      //       if (kDebugMode) {
      //         print(isProEdit);
      //       }
      //     });
      //     isProEdit == true ? save() : null;
      //   },
      //   child: Icon(isProEdit ? Icons.edit : Icons.update),
      // ),
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ref.watch(sellerUserdataProvider(seller.id)).when(
                      data: (data) {
                        return Column(
                          children: [
                            const SizedBox(height: 15),
                            Center(
                              child: Text(
                                !isProEdit
                                    ? "Edit Your Profile"
                                    : "Your Account",
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                isProEdit ? null : selectProfileImage();
                              },
                              child: profileWebImage != null
                                  ? CircleAvatar(
                                      backgroundColor: Pallete.balckColor,
                                      backgroundImage:
                                          MemoryImage(profileWebImage!),
                                      minRadius: 100,
                                      maxRadius: 100,
                                    )
                                  : profileImage != null
                                      ? CircleAvatar(
                                          backgroundColor: Pallete.balckColor,
                                          backgroundImage:
                                              FileImage(profileImage!),
                                          minRadius: 100,
                                          maxRadius: 100,
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Pallete.balckColor,
                                          backgroundImage:
                                              NetworkImage(data.sel_pro),
                                          minRadius: 100,
                                          maxRadius: 100,
                                        ),
                            ),
                            const SizedBox(height: 15),
                            TextDisplayWidget(
                              name: _name,
                              isProEdit: isProEdit,
                              maxLine: 1,
                              hintText: "Your Name",
                              icon: Icons.text_fields,
                              labelText: "Your Name",
                              maxC: 30,
                              textInputType: TextInputType.name,
                            ),

                            const SizedBox(height: 20),
                            // //
                            TextDisplayWidget(
                              name: _email,
                              isProEdit: true,
                              maxLine: null,
                              hintText: "Your Email",
                              labelText: "Your Email",
                              icon: Icons.email,
                              maxC: 20,
                              textInputType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 15),
                            TextDisplayWidget(
                              name: _desc,
                              isProEdit: isProEdit,
                              maxLine: null,
                              hintText: "Your Description",
                              labelText: "Your Description",
                              icon: Icons.home_filled,
                              maxC: 500,
                              textInputType: TextInputType.multiline,
                            ),
                            const SizedBox(height: 15),

                            TextDisplayWidget(
                              name: _address,
                              isProEdit: isProEdit,
                              maxLine: 3,
                              hintText: "Your address",
                              labelText: "Your address",
                              icon: Icons.home_filled,
                              maxC: 300,
                              textInputType: TextInputType.streetAddress,
                            ),

                            //
                            const SizedBox(height: 15),
                            TextDisplayWidget(
                              name: _phone,
                              isProEdit: isProEdit,
                              maxLine: 1,
                              hintText: "Your Phone Number",
                              labelText: "Your Phone Number",
                              icon: Icons.phone,
                              maxC: 10,
                              textInputType: TextInputType.phone,
                            ),
                            const SizedBox(height: 15),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Total Ammount :",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                  ),
                                  Text(
                                    data.totalAmmount,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Pallete.redColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),

                            //
                            // /
                            // /
                            //
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Total Products :",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                  ),
                                  Text(
                                    "${data.total_product.length}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Pallete.redColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

//
                            //
                            const SizedBox(height: 15),
                            //
                            //
                            // Seller Rating etc need to be added
                            //
                            //

                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Pallete.loginBgColor,
                                    fixedSize: const Size(200, 50),
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                onPressed: () {
                                  setState(() {
                                    isProEdit = !isProEdit;
                                    if (kDebugMode) {
                                      print(isProEdit);
                                    }
                                  });
                                  isProEdit == true ? save() : null;
                                },
                                child: Text(
                                  isProEdit ? "Edit Profile" : "Save Profile",
                                  style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 18,
                                  ),
                                )),
                            const SizedBox(height: 15),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Pallete.loginBgColor,
                                    fixedSize: const Size(200, 50),
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                onPressed: () {
                                  logout();
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Pallete.whiteColor,
                                ),
                                label: const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 18,
                                  ),
                                )),
                            const SizedBox(height: 15),
                          ],
                        );
                      },
                      error: (error, stacktrace) =>
                          ErrorText(errorMessage: error.toString()),
                      loading: () => const Loader()),

                  // //
                  // const SizedBox(height: 15),
                  // //
                  // //
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12),
                  //   child: TextField(
                  //     onTapOutside: (v) {
                  //       FocusManager.instance.primaryFocus?.unfocus();
                  //     },
                  //     controller: _name,
                  //     maxLines: null,
                  //     readOnly: isProEdit,
                  //     // maxLength: max,
                  //     keyboardType: TextInputType.multiline,
                  //     decoration: InputDecoration(
                  //       label: const Text(
                  //         "Your Name",
                  //       ),
                  //       labelStyle: TextStyle(
                  //           // fontSize: 14,
                  //           color: Colors.grey.shade600,
                  //           fontWeight: FontWeight.bold),
                  //       hintText: "Your Name",
                  //       hintStyle: TextStyle(
                  //           fontSize: 14,
                  //           color: Colors.grey.shade600,
                  //           fontWeight: FontWeight.bold),
                  //       contentPadding: const EdgeInsets.all(25),
                  //       prefixIcon: Padding(
                  //         padding: const EdgeInsets.all(20.0),
                  //         child: Icon(
                  //           Icons.text_fields,
                  //           size: 25,
                  //           color: Colors.grey.shade600,
                  //         ),
                  //       ),
                  //       // suffixIcon: Padding(
                  //       //   padding: const EdgeInsets.all(20.0),
                  //       //   child: Icon(
                  //       //     Icons.text_fields,
                  //       //     size: 25,
                  //       //     color: Colors.grey.shade600,
                  //       //   ),
                  //       // ),
                  //       fillColor: Colors.grey.shade50,
                  //       focusColor: Colors.grey.shade50,
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: const BorderSide(
                  //           width: 3,
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //       filled: true,
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: const BorderSide(
                  //           color: Colors.black26,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // //
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
    required this.isProEdit,
    required this.maxLine,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.maxC,
    required this.textInputType,
  }) : _name = name;

  final TextEditingController _name;
  final bool isProEdit;
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
        readOnly: isProEdit,
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
//  CachedNetworkImage(
//                                         imageUrl:
//                                             profileImage!,
//                                         placeholder: (context, url) => Loader(),
//                                         errorWidget: (context, url, error) =>
//                                             const Icon(Icons.error),
//                                       )
