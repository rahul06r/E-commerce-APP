// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_ecommerce/Features/Homescreen/Controller/add_product_contro.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerAnswerQuestionPage extends ConsumerStatefulWidget {
  final String qId;
  const SellerAnswerQuestionPage({
    super.key,
    required this.qId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SellerAnswerQuestionPageState();
}

class _SellerAnswerQuestionPageState
    extends ConsumerState<SellerAnswerQuestionPage> {
  final TextEditingController _answerController = TextEditingController();
  //
  void answerBuyerQuestion({required String slAnswer}) {
    ref.read(addProductControProvider.notifier).answerQuestionofBuyer(
        slAnwser: slAnswer, qID: widget.qId, context: context);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(addProductControProvider);
    final answered = ref
        .watch(getParticularQuestionDeatilsForSellerProvider(widget.qId))
        .value!
        .sl_reply;
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Pallete.greenColor,
        backgroundColor: Pallete.whiteColor,
        scrolledUnderElevation: 2,

        title: const Text(
          "Answer to Post",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        // actions: [],

        automaticallyImplyLeading: true,
      ),
      backgroundColor: Pallete.bgColor,
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : Column(children: [
              ref
                  .watch(
                      getParticularQuestionDeatilsForSellerProvider(widget.qId))
                  .when(
                      data: (data) {
                        return Column(
                          children: [
                            const SizedBox(height: 3),
                            Container(
                              // height: 200,
                              color: Pallete.whiteColor,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const SizedBox(height: 18),
                                  FieldFormWidget(
                                    productName: TextEditingController(
                                        text: data.by_question),
                                    maxLine: null,
                                    labelText: "Buyer Question",
                                    hintText: "Buyer Question",
                                    icon: Icons.question_mark,
                                    maxC: 100,
                                    textInputType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 15),

                                  // post question
                                  FieldFormWidget(
                                    productName: data.sl_reply.isNotEmpty
                                        ? TextEditingController(
                                            text: data.sl_reply)
                                        : _answerController,
                                    readOnly:
                                        data.sl_reply.isNotEmpty ? true : false,
                                    maxLine: null,
                                    labelText: "Answer here",
                                    hintText: "Answer here",
                                    icon: Icons.question_mark,
                                    maxC: 100,
                                    textInputType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      error: (error, stackTrace) =>
                          ErrorText(errorMessage: error.toString()),
                      loading: () => const Loader()),

              // const SizedBox(height: 5),
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
                    backgroundColor:
                        answered.isEmpty ? Pallete.blueColor : Pallete.redColor,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    // post question
                    if (answered.isEmpty) {
                      if (_answerController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Question is Required",
                          backgroundColor: Pallete.redColor,
                          gravity: ToastGravity.TOP,
                        );
                      } else {
                        answerBuyerQuestion(slAnswer: _answerController.text);
                        _answerController.clear();
                      }
                    } else {
                      ref
                          .watch(addProductControProvider.notifier)
                          .deleteAnswerOfTheQuestion(
                              qID: widget.qId, context: context);
                    }
                  },
                  icon: Icon(
                    answered.isEmpty ? Icons.send : Icons.delete,
                    color: Pallete.whiteColor,
                  ),
                  label: Text(
                    answered.isEmpty ? "Submit" : "Delete",
                    style: const TextStyle(
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
    required this.readOnly,
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
