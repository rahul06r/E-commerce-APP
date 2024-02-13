import 'package:app_ecommerce/Core/Common/failure.dart';
import 'package:app_ecommerce/Core/Common/typeDef.dart';
import 'package:app_ecommerce/Core/Providers/firebaseProviders.dart';
import 'package:app_ecommerce/Models/Seller_Acceptance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final sellerAcceptRepoProvider = Provider((ref) {
  return SellerAcceptRepo(firebaseFirestore: ref.read(firestoreProvider));
});

class SellerAcceptRepo {
  final FirebaseFirestore _firebaseFirestore;
  SellerAcceptRepo({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

//
// Requesting part
//

  CollectionReference get _sellerAceept =>
      _firebaseFirestore.collection("sellerAccept");
  CollectionReference get _user => _firebaseFirestore.collection("users");

  //

  //
  FutureEither<SellerAcceptanceModel> requestingAccess(
    String sl_id,
    String sl_name,
    String sl_email,
    String sl_desc,
    int sl_phNo,
    //  String sl_photo,
    String sl_address,
  ) async {
    try {
      SellerAcceptanceModel sellerAcceptanceModel = SellerAcceptanceModel(
        sl_id: sl_id,
        sl_name: sl_name,
        sl_email: sl_email,
        sl_description: sl_desc,
        sl_phoneNo: sl_phNo,
        sl_photo: "",
        sl_address: sl_address,
        sl_tags: [],
        accpet: false,
      );

      //

      await _sellerAceept
          .doc(sl_id)
          .set(sellerAcceptanceModel.toMap())
          .then((value) {
        _user.doc(sl_id).update({
          "requested": true,
          "description": sl_desc,
          "address": sl_address,
          "sl_phone": sl_phNo,
        });
      });
      return right(sellerAcceptanceModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
