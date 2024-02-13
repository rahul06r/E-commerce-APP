import 'package:app_ecommerce/Core/Common/failure.dart';
import 'package:app_ecommerce/Core/Common/typeDef.dart';
import 'package:app_ecommerce/Core/Providers/firebaseProviders.dart';
import 'package:app_ecommerce/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final sellerAuthRepoProvider = Provider((ref) {
  return SellerAuthRepo(
      firebaseAuth: ref.read(authProvider),
      firebaseFirestore: ref.read(firestoreProvider));
});

class SellerAuthRepo {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;
  SellerAuthRepo({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _auth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  CollectionReference get _users => _firebaseFirestore.collection("users");
  Stream<User?> get authState => _auth.authStateChanges();

  FutureEither<SellerModel> sigupWithEmailAndPass(
      String email, String password, String name) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      SellerModel sellerModel;
      if (credential.additionalUserInfo!.isNewUser) {
        sellerModel = SellerModel(
          id: credential.user!.uid,
          email: email,
          password: password,
          address: "",
          comments: [],
          description: "",
          isAccepted: false,
          name: name,
          sellerRating: [],
          tag: "Seller",
          totalAmmount: "",
          totalSellerRating: [],
          total_product: [],
          total_product_sold: [],
          requested: false,
          sel_pro: "",
          sl_phone: 0,
        );

        await _users.doc(credential.user!.uid).set(sellerModel.toMap());
      } else {
        sellerModel = await getUserdata(credential.user!.uid).first;
      }
      return right(sellerModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<SellerModel> loginWithEmailAndPass(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      SellerModel sellerModel;

      sellerModel = await getUserdata(credential.user!.uid).first;

      return right(sellerModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<SellerModel> getUserdata(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => SellerModel.fromMap(event.data() as Map<String, dynamic>));
  }

//
//
// Edit
//
  FutureVoid editPro(SellerModel sellerModel) async {
    try {
      return right(_users.doc(sellerModel.id).update(sellerModel.toMap()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

//
//

  // logout

  void sellerLogout() {
    _auth.signOut();
  }
}
