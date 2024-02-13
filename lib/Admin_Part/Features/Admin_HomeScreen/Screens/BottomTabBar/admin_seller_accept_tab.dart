import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Controller/adminHomeScreenContro.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Screens/Extra_Screen/admin_seller_Deatisl_Request_page.dart';
import 'package:app_ecommerce/Core/Common/errorText.dart';
import 'package:app_ecommerce/Core/Common/loader.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSellerAcceptTab extends ConsumerStatefulWidget {
  const AdminSellerAcceptTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminSellerAcceptTabState();
}

class _AdminSellerAcceptTabState extends ConsumerState<AdminSellerAcceptTab> {
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
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : Column(
              children: [
                //
                // GestureDetector(
                //   onTap: () {},
                //   child: SizedBox(
                //     height: 50,
                //     child: Card.filled(
                //       elevation: 2,
                //       color: Pallete.whiteColor,
                //       shape: RoundedRectangleBorder(
                //           side: BorderSide(
                //         color: Pallete.bgColor,
                //         width: 2,
                //       )),
                //       child: const Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Padding(
                //             padding: EdgeInsets.only(left: 10),
                //             child: Text(
                //               "Requested Seller",
                //               style: TextStyle(
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(right: 10),
                //             child: Icon(
                //               Icons.chevron_right_outlined,
                //               size: 30,
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Card.filled(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    color: Pallete.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Requested Seller",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                //
                ref.watch(getAllNumberSellerRequestProvider).when(
                      data: (data) {
                        if (data.isEmpty) {
                          return const Center(
                            child: Text(
                              "No Seller Request Available Now",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final seller = data[index];
                              if (kDebugMode) {
                                print(
                                    "${data.length} length#################################################################");
                              }

                              return !seller.accpet
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: Card.filled(
                                          elevation: 2,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          color: Pallete.whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            side: BorderSide(
                                                color: Pallete.bgColor,
                                                width: 2),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 5),
                                              Text(
                                                seller.sl_name,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 40,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start, // Adjust the alignment as needed
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        "Tags :",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    // Add some space between "Tags :" and the ListView
                                                    Expanded(
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: seller
                                                            .sl_tags.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                "${seller.sl_tags[index]}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 4),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Buttons

                                              const Spacer(),
                                              Wrap(
                                                alignment: WrapAlignment.start,
                                                spacing: 5,
                                                direction: Axis.horizontal,
                                                children: [
                                                  ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              foregroundColor:
                                                                  Pallete
                                                                      .redColor,
                                                              backgroundColor:
                                                                  Pallete
                                                                      .redColor,
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Pallete
                                                                    .whiteColor,
                                                              )),
                                                      onPressed: () {
                                                        // Remove
                                                        rejectSeller(
                                                            slID: seller.sl_id,
                                                            isAccpected: false);
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .cancel_schedule_send_sharp,
                                                        color:
                                                            Pallete.whiteColor,
                                                      ),
                                                      label: const Text(
                                                        "Revoke",
                                                        style: TextStyle(
                                                            color: Pallete
                                                                .whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                  ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              foregroundColor:
                                                                  Pallete
                                                                      .balckColor,
                                                              backgroundColor:
                                                                  Pallete
                                                                      .balckColor,
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Pallete
                                                                    .whiteColor,
                                                              )),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdminSellerRequestDetailsPage(
                                                                    seller
                                                                        .sl_id),
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove_red_eye,
                                                        color:
                                                            Pallete.whiteColor,
                                                      ),
                                                      label: const Text(
                                                        "View",
                                                        style: TextStyle(
                                                            color: Pallete
                                                                .whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                  ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              foregroundColor:
                                                                  Pallete
                                                                      .greenColor,
                                                              backgroundColor:
                                                                  Pallete
                                                                      .greenColor,
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Pallete
                                                                    .whiteColor,
                                                              )),
                                                      onPressed: () {
                                                        // Accept
                                                        acceptSeller(
                                                            slID: seller.sl_id,
                                                            isAccpected: true);
                                                      },
                                                      icon: const Icon(
                                                        Icons.check_box_rounded,
                                                        color:
                                                            Pallete.whiteColor,
                                                      ),
                                                      label: const Text(
                                                        "Accpet",
                                                        style: TextStyle(
                                                            color: Pallete
                                                                .whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              // Ends@@@@@@@@@@@@@@@@@@@@@@@@@
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .6,
                                      child: const Center(
                                        child: Text(
                                          "No Seller Request Available Now",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          );
                        }
                      },
                      error: (error, stackTrace) =>
                          ErrorText(errorMessage: error.toString()),
                      loading: () => const Loader(),
                    ),
              ],
            ),
    );
  }
}
