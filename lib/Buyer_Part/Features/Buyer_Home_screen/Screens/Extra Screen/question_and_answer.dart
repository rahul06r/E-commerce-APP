// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Controller/buyer_home_contro.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionandAnswer extends ConsumerStatefulWidget {
  final String prID;
  final String slID;
  final String byId;
  const QuestionandAnswer({
    super.key,
    required this.prID,
    required this.slID,
    required this.byId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuestionandAnswerState();
}

class _QuestionandAnswerState extends ConsumerState<QuestionandAnswer> {
  final TextEditingController _questionController = TextEditingController();
  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  void submitQuestion({required String byQuestion}) {
    ref.read(buyerHomeControProvider.notifier).postquestionBuyer(
          context: context,
          byId: widget.byId,
          slID: widget.slID,
          byQuestion: byQuestion,
          prId: widget.prID,
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(buyerHomeControProvider);
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Pallete.greenColor,
        backgroundColor: Pallete.whiteColor,
        scrolledUnderElevation: 2,

        title: const Text(
          "Post Your Question?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [],

        automaticallyImplyLeading: true,
      ),
      backgroundColor: Pallete.bgColor,
      body: isLoading
          ? const Center(
              // child: Loader(),
              )
          : Column(children: [
              const SizedBox(height: 3),
              Container(
                color: Pallete.whiteColor,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 15),

                    // post question
                    FieldFormWidget(
                      productName: _questionController,
                      maxLine: null,
                      labelText: "Question here",
                      hintText: "Question here",
                      icon: Icons.question_mark,
                      maxC: 100,
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(
                width: double.infinity,
                // color: Pallete.whiteColor,
                child: Card.filled(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  elevation: 2,
                  color: Pallete.whiteColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          "1) Be specific, ask questions about the product and not about price,delivery,service etc..",
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "2) Ask for information which isn't captured in the product specifications.",
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    fixedSize: Size(MediaQuery.of(context).size.width, 60),
                    backgroundColor: Pallete.blueColor,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    // post question
                    if (_questionController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Question is Required",
                        backgroundColor: Pallete.redColor,
                        gravity: ToastGravity.TOP,
                      );
                    } else {
                      submitQuestion(byQuestion: _questionController.text);
                      _questionController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Pallete.whiteColor,
                  ),
                  label: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 19,
                    ),
                  )),
              const SizedBox(height: 1),
            ]),
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
