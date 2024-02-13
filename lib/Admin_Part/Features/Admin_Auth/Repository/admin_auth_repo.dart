import 'package:app_ecommerce/Admin_Part/Models/Admin_model.dart';
import 'package:app_ecommerce/Core/Common/failure.dart';
import 'package:app_ecommerce/Core/Common/typeDef.dart';
import 'package:app_ecommerce/Core/Providers/firebaseProviders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final adminAuthRepoProvider = Provider((ref) {
  return AdminAuthRepo(
      firebaseFirestore: ref.read(firestoreProvider),
      firebaseAuth: ref.read(authProvider));
});

class AdminAuthRepo {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  AdminAuthRepo({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  CollectionReference get _admin => _firebaseFirestore.collection("Admin");
  Stream<User?> get authState => _firebaseAuth.authStateChanges();
  FutureEither<AdminModel> signUpEmailandPass(
      String email, String password, String name) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      AdminModel adminModel;
      if (credential.additionalUserInfo!.isNewUser) {
        adminModel = AdminModel(
          ad_id: credential.user!.uid,
          ad_name: name,
          ad_pro: "",
          ad_role: "Admin",
          ad_email: email,
          ad_password: password,
        );
        await _admin.doc(credential.user!.uid).set(adminModel.toMap());
      } else {
        adminModel = await getUserdata(credential.user!.uid).first;
      }
      return right(adminModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //
  //
  FutureEither<AdminModel> loginWithEmaiandPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AdminModel adminModel;
      adminModel = await getUserdata(credential.user!.uid).first;

      return right(adminModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

//
  Stream<AdminModel> getUserdata(String uid) {
    return _admin.doc(uid).snapshots().map(
        (event) => AdminModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void adminLogOut() {
    _firebaseAuth.signOut();
  }

  FutureVoid editAdminProfile(AdminModel adminModel) async {
    try {
      return right(
        _admin.doc(adminModel.ad_id).update(adminModel.toMap()),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
