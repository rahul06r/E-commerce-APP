import 'package:app_ecommerce/Admin_Part/Models/Banner_model.dart';
import 'package:app_ecommerce/Core/Common/failure.dart';
import 'package:app_ecommerce/Core/Common/typeDef.dart';
import 'package:app_ecommerce/Core/Providers/firebaseProviders.dart';
import 'package:app_ecommerce/Models/ProductModel.dart';
import 'package:app_ecommerce/Models/Seller_Acceptance_model.dart';
import 'package:app_ecommerce/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final adminHomeScreenRepoProvider = Provider((ref) {
  return AdminHomeScreenRepository(
      firebaseFirestore: ref.read(firestoreProvider));
});

class AdminHomeScreenRepository {
  final FirebaseFirestore _firebaseFirestore;
  AdminHomeScreenRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _sellerAccept =>
      _firebaseFirestore.collection("sellerAccept");
  CollectionReference get _seller => _firebaseFirestore.collection("users");
  CollectionReference get _product => _firebaseFirestore.collection("products");
  CollectionReference get _banner => _firebaseFirestore.collection("Banners");

// features starts here
//
//
// #########Seller account

  Stream<SellerAcceptanceModel> getParticularSellerRequestAccount(String slID) {
    return _sellerAccept.doc(slID).snapshots().map((event) =>
        SellerAcceptanceModel.fromMap(event.data() as Map<String, dynamic>));
  }

// Selleraccept feature here

  Stream<List<ProductModel>> getAllNumberProducts() {
    try {
      return _product.snapshots().map((event) => event.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Stream<List<SellerAcceptanceModel>> getAllNumberOfSellerAccpet() {
    try {
      return _sellerAccept.snapshots().map((event) => event.docs
          .map((e) =>
              SellerAcceptanceModel.fromMap(e.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  FutureEither sellerAcceptByAdmin(String sl_id, bool isAccpeted) async {
    try {
      return right(
        _sellerAccept.doc(sl_id).update({
          "accpet": isAccpeted,
        }).then((value) {
          _seller.doc(sl_id).update({
            "isAccpeted": isAccpeted,
          });
        }),
        //in future after this we will send notification to the seller about his status
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither sellerRejectByAdmin(String sl_id, bool isAccpeted) async {
    try {
      return right(
        // remove the seller from seller accept collection use .then for request to false
        _seller.doc(sl_id).update({
          "requested": isAccpeted,
        }),
        //in future after this we will send notification to the seller about his status
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  // next banner carasouel

  FutureVoid addBannner(BannerModel bannerModel) async {
    try {
      return right(
        _banner.doc(bannerModel.ban_id).set(bannerModel.toMap()),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<BannerModel>> getAllBanner() {
    try {
      return _banner.orderBy("uploadTime", descending: false).snapshots().map(
          (event) => event.docs
              .map((e) => BannerModel.fromMap(e.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      rethrow;
    }
  }

  // delete banner file
  FutureVoid deleteBanner(String bn_id) async {
    try {
      return right(
        _banner.doc(bn_id).delete(),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // searching products
  Stream<List<ProductModel>> searchProduct(String query) {
    return _product
        .where("pr_name",
            isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
            isLessThan: query.isEmpty
                ? null
                : query.substring(0, query.length - 1) +
                    String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      for (var element in event.docs) {
        products
            .add(ProductModel.fromMap(element.data() as Map<String, dynamic>));
      }
      return products;
    });
  }

//
  // searching seller
  // Stream<List<SellerModel>> searchSeller(String query) {
  //   return _seller
  //       .where("name",
  //           isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
  //           isLessThan: query.isEmpty
  //               ? null
  //               : query.substring(0, query.length - 1) +
  //                   String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
  //       .snapshots()
  //       .map((event) {
  //     List<SellerModel> seller = [];
  //     for (var element in event.docs) {
  //       seller.add(SellerModel.fromMap(element.data() as Map<String, dynamic>));
  //     }
  //     return seller;
  //   });
  // }
  Stream<List<SellerAcceptanceModel>> searchSeller(String query) {
    return _sellerAccept
        .where("sl_name",
            isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
            isLessThan: query.isEmpty
                ? null
                : query.substring(0, query.length - 1) +
                    String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .snapshots()
        .map((event) {
      List<SellerAcceptanceModel> seller = [];
      for (var element in event.docs) {
        seller.add(SellerAcceptanceModel.fromMap(
            element.data() as Map<String, dynamic>));
      }
      return seller;
    });
  }
}
