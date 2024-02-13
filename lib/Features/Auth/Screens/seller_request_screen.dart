// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Features/Auth/Controller/seller_accept_contro.dart';
import 'package:app_ecommerce/Features/Auth/Controller/seller_auth_contro.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/bottomNavBar/homeScreen_Tab.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerRequestScreen extends ConsumerStatefulWidget {
  const SellerRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SellerRequestScreenState();
}

class _SellerRequestScreenState extends ConsumerState<SellerRequestScreen> {
  final TextEditingController _address = TextEditingController();
  final TextEditingController _descr = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _address.dispose();
    _descr.dispose();
    _phone.dispose();
    super.dispose();
  }

  void requestAccess({
    required String sl_id,
    required String sl_name,
    required String sl_email,
    required String sl_desc,
    required int sl_phNo,
    required String sl_address,
  }) {
    ref.read(sellerAccessControProvider.notifier).requestingAccess(
        context: context,
        sl_id: sl_id,
        sl_name: sl_name,
        sl_email: sl_email,
        sl_desc: sl_desc,
        sl_phNo: sl_phNo,
        sl_address: sl_address);
  }

  @override
  Widget build(BuildContext context) {
    final seller = ref.watch(sellerUserProvider)!;
    final isLoading = ref.watch(sellerAccessControProvider);

    return Scaffold(
      appBar: !seller.isAccepted
          ? AppBar(
              backgroundColor: Pallete.loginBgColor,
              centerTitle: true,
              title: const Text(
                "Request for access",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      body: seller.isAccepted
          ? const HomeScreenTab()
          : SingleChildScrollView(
              child: isLoading
                  ? const Center(
                      child: Loader(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ConstsDeatils(
                          deatils: "Name :",
                          seller: seller.name,
                        ),
                        const SizedBox(height: 15),
                        ConstsDeatils(
                          deatils: "Email :",
                          seller: seller.email,
                        ),
                        const SizedBox(height: 15),
                        const SizedBox(height: 15),
                        seller.requested
                            ? Container()
                            : FormFillTextField(
                                hintText: "Address",
                                labelText: "Address",
                                icon: Icons.home,
                                address: _address,
                                max: 300,
                                maxL: 3,
                                type: TextInputType.multiline,
                              ),
                        const SizedBox(height: 15),
                        !seller.requested
                            ? Container()
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(30, 50)),
                                  color: Pallete.redColor,
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "You have been requested for selling the products, please wait for the confirmation",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Pallete.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                        seller.requested
                            ? Container()
                            : FormFillTextField(
                                hintText: "Description",
                                labelText: "Description",
                                icon: Icons.explicit,
                                address: _descr,
                                max: 500,
                                maxL: null,
                                type: TextInputType.streetAddress,
                              ),
                        const SizedBox(height: 15),
                        seller.requested
                            ? Container()
                            : FormFillTextField(
                                hintText: "Phone Number",
                                labelText: "Phone Number",
                                icon: Icons.phone,
                                address: _phone,
                                maxL: 1,
                                max: 10,
                                type: TextInputType.phone,
                              ),
                        const SizedBox(height: 15),
                        const SizedBox(height: 15),

                        //

                        seller.requested
                            ? Container()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .7,
                                      60),
                                  elevation: 5,
                                  backgroundColor: Pallete.loginBgColor,
                                  foregroundColor: Pallete.loginBgColor,
                                  side: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 236, 112, 112)),
                                  shape: const BeveledRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                onPressed: () {
                                  if (seller.requested) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "You have already requested for selling wait for admin to accept!",
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Pallete.redColor,
                                    );
                                  } else {
                                    int? phoneNumber =
                                        int.tryParse(_phone.text);
                                    if (_address.text.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: "Address is Required",
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Pallete.redColor,
                                      );
                                    } else if (_descr.text.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: "Description is Required",
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Pallete.redColor,
                                      );
                                    } else if (_phone.text.isEmpty ||
                                        _phone.text.length < 10) {
                                      Fluttertoast.showToast(
                                        msg: "Phone number is Required",
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Pallete.redColor,
                                      );
                                    } else {
                                      requestAccess(
                                        sl_id: seller.id,
                                        sl_name: seller.name,
                                        sl_email: seller.email,
                                        sl_desc: _descr.text,
                                        sl_phNo: phoneNumber!,
                                        sl_address: _address.text,
                                      );

                                      _address.clear();
                                      _descr.clear();
                                      _phone.clear();
                                      setState(() {});
                                    }
                                  }
                                },
                                child: const Text(
                                  "Request Access",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.balckColor,
                                  ),
                                ))
                      ],
                    ),
            ),
    );
  }
}

class FormFillTextField extends StatelessWidget {
  const FormFillTextField({
    Key? key,
    required this.address,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.max,
    required this.maxL,
    required this.type,
  }) : super(key: key);

  final TextEditingController address;
  final String labelText;
  final String hintText;
  final IconData icon;
  final int max;
  final dynamic maxL;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onTapOutside: (v) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: address,
        maxLines: maxL,
        maxLength: max,
        keyboardType: type,
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

class ConstsDeatils extends StatelessWidget {
  const ConstsDeatils({
    Key? key,
    required this.seller,
    required this.deatils,
  }) : super(key: key);

  final String seller;
  final String deatils;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          deatils,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          seller,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
