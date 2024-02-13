import 'package:app_ecommerce/Buyer_Part/Models/Buyer_Model.dart';
import 'package:app_ecommerce/Core/Common/failure.dart';
import 'package:app_ecommerce/Core/Common/typeDef.dart';
import 'package:app_ecommerce/Core/Providers/firebaseProviders.dart';
import 'package:app_ecommerce/Models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final buyerAuthRepoProvider = Provider((ref) {
  return BuyerAuthRepo(
      firebaseFirestore: ref.read(firestoreProvider),
      auth: ref.read(authProvider));
});

class BuyerAuthRepo {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _auth;
  BuyerAuthRepo({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firebaseFirestore = firebaseFirestore;

//
  CollectionReference get _users => _firebaseFirestore.collection("Buyer");
  Stream<User?> get authState => _auth.authStateChanges();
  CollectionReference get _products =>
      _firebaseFirestore.collection("products");

//
  FutureEither<BuyerModel> signUpEmailandPass(
      String email, String password, String name) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      BuyerModel buyerModel;
      if (credential.additionalUserInfo!.isNewUser) {
        buyerModel = BuyerModel(
          by_id: credential.user!.uid,
          by_name: name,
          by_email: email,
          by_password: password,
          by_pro: "",
          by_type: "Buyer",
          by_phone: 0,
          by_add_to_cart: [],
          by_bought: [],
          by_whithlist: [],
          by_review: [],
          by_address: "",
        );
        await _users.doc(credential.user!.uid).set(buyerModel.toMap());
      } else {
        buyerModel = await getUserdata(credential.user!.uid).first;
      }
      return right(buyerModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  // login############****************************

  //

  // ##############****************((((((((((((((()))))))))))))))
  FutureEither<BuyerModel> loginWithEmailAndPass(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      BuyerModel buyerModel;

      buyerModel = await getUserdata(credential.user!.uid).first;

      return right(buyerModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

// ##############################
  Stream<BuyerModel> getUserdata(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => BuyerModel.fromMap(event.data() as Map<String, dynamic>));
  }

// ##########$%^&*()_
  FutureVoid editBuyerPro(BuyerModel buyerModel) async {
    try {
      return right(_users.doc(buyerModel.by_id).update(buyerModel.toMap()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<ProductModel>> getAllProduct() {
    return _products.snapshots().map((event) => event.docs
        .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }

  //
  // Stream<Future<List<ProductModel>>> getUserCartDetails(String byId) {
  //   try {
  //     return _users.doc(byId).snapshots().map((event) async {
  //       BuyerModel buyer =
  //           BuyerModel.fromMap(event.data() as Map<String, dynamic>);
  //       List<ProductModel> cart = [];

  //       for (var productId in buyer.by_add_to_cart) {
  //         if (kDebugMode) {
  //           print("Product ID: $productId");
  //         }

  //         ProductModel productModel = await getProductById(productId);
  //         cart.add(productModel);
  //       }
  //       if (kDebugMode) {
  //         print("User Cart: $cart");
  //       }

  //       return cart;
  //     }).handleError((error) {
  //       if (kDebugMode) {
  //         print('Error getting user cart details: $error');
  //       }
  //       throw error;
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error getting user cart details: $e');
  //     }
  //     rethrow;
  //   }
  // }
  Stream<List<String>> getUserCartDetails(String byId) {
    try {
      return _users.doc(byId).snapshots().map((event) {
        BuyerModel buyer =
            BuyerModel.fromMap(event.data() as Map<String, dynamic>);
        List<String> cartIds = [];
        for (var cartId in buyer.by_add_to_cart) {
          cartIds.add(cartId);
        }
        return cartIds;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
  // Stream<List<ProductModel>> getcartproducts(List<String> )

  Future<ProductModel> getProductById(String productId) async {
    try {
      DocumentSnapshot productSnapshot = await _products.doc(productId).get();
      if (productSnapshot.exists) {
        return ProductModel.fromMap(
            productSnapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("Product with ID $productId not found.");
      }
    } catch (e) {
      print('Error getting product details: $e');
      throw e;
    }
  }

  //
  Stream<ProductModel> getparticularProductdetailsBuyer(String prId) {
    return _products.doc(prId).snapshots().map(
        (event) => ProductModel.fromMap(event.data() as Map<String, dynamic>));
  }

//
  void buyerLogout() {
    _auth.signOut();
  }
}
