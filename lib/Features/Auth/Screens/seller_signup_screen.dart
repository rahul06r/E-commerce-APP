import 'package:app_ecommerce/Admin_Part/Features/Admin_Auth/Controller/admin_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Features/Auth/Controller/seller_auth_contro.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerSignupScreen extends ConsumerStatefulWidget {
  const SellerSignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SellerSignupScreenState();
}

class _SellerSignupScreenState extends ConsumerState<SellerSignupScreen> {
  final TextEditingController emailContro = TextEditingController();
  final TextEditingController passContro = TextEditingController();
  final TextEditingController nameContro = TextEditingController();

  bool isLogin = true;
  // void login(String email, String password) {
  //   ref
  //       .read(sellerauthControllerProvider.notifier)
  //       .login(email: email, password: password, context: context);
  // }

  // void signup(String email, String password, String name) {
  //   ref.read(sellerauthControllerProvider.notifier).signUpEmailAndPassword(
  //       email: email, password: password, name: name, context: context);
  // }
  void login(String email, String password) {
    ref
        .read(buyerAuthControProvider.notifier)
        .login(email: email, password: password, context: context);
  }

  void signup(String email, String password, String name) {
    ref.read(buyerAuthControProvider.notifier).signUpEmailAndPassword(
        email: email, password: password, name: name, context: context);
  }

  // void login(String email, String password) {
  //   ref
  //       .read(adminAuthControProvider.notifier)
  //       .login(email: email, password: password, context: context);
  // }

  // void signup(String email, String password, String name) {
  //   ref.read(adminAuthControProvider.notifier).signUpEmailandPassword(
  //       email: email, password: password, name: name, context: context);
  // }

  @override
  void dispose() {
    emailContro.dispose();
    passContro.dispose();
    nameContro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(sellerauthControllerProvider);
    // final bool isLoading = ref.watch(buyerAuthControProvider);
    // final bool isLoading = ref.watch(adminAuthControProvider);
    return Scaffold(
      backgroundColor: Pallete.loginBgColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: Text(
                        "Please",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .15,
                          top: 10),
                      child: Text(
                        isLogin ? "Login here" : "Register Before......",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Center(
                        child: Image.asset(
                      'assets/4.png',
                      height: 300,
                    )),
                    !isLogin
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                              onTapOutside: (v) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              controller: nameContro,
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(25),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(
                                    Icons.text_fields,
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
                          )
                        : Container(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: TextField(
                        onTapOutside: (v) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: emailContro,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.all(25),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.email,
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
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: TextField(
                        onTapOutside: (v) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: passContro,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                          contentPadding: const EdgeInsets.all(25),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.password,
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
                    ),

                    //

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Pallete.loginBgColor,
                                backgroundColor: Colors.white,
                                fixedSize: const Size(200, 50),
                                shape: const BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)))),
                            onPressed: () {
                              //
                              if (isLogin) {
                                if (passContro.text.length <= 6 ||
                                    passContro.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Password should be greater than 6",
                                    backgroundColor: Pallete.redColor,
                                    gravity: ToastGravity.CENTER,
                                  );
                                } else {
                                  login(emailContro.text, passContro.text);
                                  emailContro.clear();
                                  passContro.clear();
                                }
                              } else {
                                if (passContro.text.length <= 6 ||
                                    passContro.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Password should be greater than 6",
                                    backgroundColor: Pallete.redColor,
                                    gravity: ToastGravity.CENTER,
                                  );
                                } else if (nameContro.text.isEmpty ||
                                    nameContro.text.length < 4) {
                                  Fluttertoast.showToast(
                                    msg: "Name should not be empty",
                                    backgroundColor: Pallete.redColor,
                                    gravity: ToastGravity.CENTER,
                                  );
                                } else {
                                  signup(emailContro.text, passContro.text,
                                      nameContro.text);

                                  emailContro.clear();
                                  passContro.clear();
                                  nameContro.clear();
                                }
                              }
                            },
                            child: Text(
                              isLogin ? "Login" : "Signup",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          style: const ButtonStyle(),
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            !isLogin ? "Login here!!" : "Registraion here?",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 38, 55, 211),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
