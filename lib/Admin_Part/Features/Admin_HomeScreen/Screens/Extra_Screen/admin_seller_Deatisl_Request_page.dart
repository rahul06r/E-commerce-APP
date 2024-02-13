import 'dart:async';

import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Controller/adminHomeScreenContro.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../Core/Common/loader.dart';
import '../../../../../Pallete/pallete.dart';

class AdminSellerRequestDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const AdminSellerRequestDetailsPage(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminSellerRequestDetailsPageState();
}

class _AdminSellerRequestDetailsPageState
    extends ConsumerState<AdminSellerRequestDetailsPage> {
  // late TextEditingController _name;
  // late TextEditingController _email;
  // late TextEditingController _address;
  // late TextEditingController _desc;
  // late TextEditingController _phone;
  bool isLoading = true;
  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  void acceptSeller({required String slID, required bool isAccpected}) {
    ref
        .read(adminHomeScreenControProvider.notifier)
        .sellerAcceptByAdmin(slID, isAccpected);
  }

  void rejectSeller({required String slID, required bool isAccpected}) {
    ref
        .read(adminHomeScreenControProvider.notifier)
        .sellerRejectByAdmin(slID, isAccpected);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(adminHomeScreenControProvider);
    final seller =
        ref.watch(getParticularSellerDetailsAccountProvider(widget.id));

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.blue.shade600,
          iconTheme: const IconThemeData(
            color: Pallete.whiteColor,
          ),
          title: const Text(
            "Seller Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Pallete.whiteColor,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Pallete.whiteColor,
        body: isLoading
            ? const Center(
                child: Loader(),
              )
            : SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    ref
                        .watch(getParticularSellerDetailsAccountProvider(
                            widget.id))
                        .when(
                            data: (data) {
                              return Column(
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      backgroundColor: Pallete.loginBgColor,
                                      backgroundImage:
                                          NetworkImage(seller.value!.sl_photo),
                                      minRadius: 100,
                                      maxRadius: 100,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  TextDisplayWidget(
                                    name: TextEditingController(
                                        text: seller.value!.sl_name),
                                    isProEdit: true,
                                    maxLine: 1,
                                    hintText: "Seller Name",
                                    icon: Icons.text_fields,
                                    labelText: "Seller Name",
                                    maxC: 30,
                                    textInputType: TextInputType.name,
                                  ),
                                  const SizedBox(height: 20),
                                  TextDisplayWidget(
                                    name: TextEditingController(
                                        text: seller.value!.sl_email),
                                    isProEdit: true,
                                    maxLine: null,
                                    hintText: "Seller Email",
                                    labelText: "Seller Email",
                                    icon: Icons.email,
                                    maxC: 20,
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 20),
                                  TextDisplayWidget(
                                    name: TextEditingController(
                                        text: seller.value!.sl_description),
                                    isProEdit: true,
                                    maxLine: null,
                                    hintText: "Seller Description",
                                    labelText: "Seller Description",
                                    icon: Icons.phone,
                                    maxC: 20,
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 20),
                                  TextDisplayWidget(
                                    name: TextEditingController(
                                        text: seller.value!.sl_address),
                                    isProEdit: true,
                                    maxLine: null,
                                    hintText: "Seller Address",
                                    labelText: "Seller Address",
                                    icon: Icons.location_city,
                                    maxC: 20,
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 20),
                                  TextDisplayWidget(
                                    name: TextEditingController(
                                        text: seller.value!.sl_phoneNo
                                            .toString()),
                                    isProEdit: true,
                                    maxLine: 1,
                                    hintText: "Seller Phone",
                                    labelText: "Seller Phone",
                                    icon: Icons.phone,
                                    maxC: 20,
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Tags",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: seller.value!.sl_tags.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Row(
                                          children: [
                                            Text(
                                              "${seller.value!.sl_tags[index]}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Pallete.redColor,
                                              backgroundColor: Pallete.redColor,
                                              textStyle: const TextStyle(
                                                color: Pallete.whiteColor,
                                              )),
                                          onPressed: () {
                                            // Remove
                                            rejectSeller(
                                                slID: seller.value!.sl_id,
                                                isAccpected: false);
                                          },
                                          icon: const Icon(
                                            Icons.cancel_schedule_send_sharp,
                                            color: Pallete.whiteColor,
                                          ),
                                          label: const Text(
                                            "Revoke",
                                            style: TextStyle(
                                                color: Pallete.whiteColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor:
                                                  Pallete.greenColor,
                                              backgroundColor:
                                                  Pallete.greenColor,
                                              textStyle: const TextStyle(
                                                color: Pallete.whiteColor,
                                              )),
                                          onPressed: () {
                                            // Accept
                                            acceptSeller(
                                                slID: seller.value!.sl_id,
                                                isAccpected: true);
                                          },
                                          icon: const Icon(
                                            Icons.check_box_rounded,
                                            color: Pallete.whiteColor,
                                          ),
                                          label: const Text(
                                            "Accpet",
                                            style: TextStyle(
                                                color: Pallete.whiteColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
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
        // maxLength: maxC,
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
