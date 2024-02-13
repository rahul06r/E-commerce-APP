import 'package:app_ecommerce/Features/Auth/Repository/seller_accept_repo.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final sellerAccessControProvider =
    StateNotifierProvider<SellerAcceptanceController, bool>((ref) {
  return SellerAcceptanceController(
      sellerAcceptRepo: ref.watch(sellerAcceptRepoProvider), ref: ref);
});

class SellerAcceptanceController extends StateNotifier<bool> {
  final SellerAcceptRepo _sellerAcceptRepo;
  final Ref _ref;
  SellerAcceptanceController({
    required SellerAcceptRepo sellerAcceptRepo,
    required Ref ref,
  })  : _ref = ref,
        _sellerAcceptRepo = sellerAcceptRepo,
        super(false);

//

// requesting controller

//
  void requestingAccess({
    required BuildContext context,
    required String sl_id,
    required String sl_name,
    required String sl_email,
    required String sl_desc,
    required int sl_phNo,
    required String sl_address,
  }) async {
    state = true;
    final slreq = await _sellerAcceptRepo.requestingAccess(
      sl_id,
      sl_name,
      sl_email,
      sl_desc,
      sl_phNo,
      sl_address,
    );
    state = false;

    slreq.fold((l) {
      Fluttertoast.showToast(
        msg: "Cannot request the access,Try again after  some time!!",
        backgroundColor: Pallete.redColor,
        gravity: ToastGravity.CENTER,
      );
    }, (r) {
      Fluttertoast.showToast(
        msg: "Successfully requested for access",
        backgroundColor: Pallete.greenColor,
        gravity: ToastGravity.CENTER,
      );
    });
  }
}
