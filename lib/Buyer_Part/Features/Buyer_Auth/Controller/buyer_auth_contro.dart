import 'dart:io';

import 'package:app_ecommerce/Buyer_Part/Models/Buyer_Model.dart';
import 'package:app_ecommerce/Core/Providers/storageProvider.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/seller_home_screen.dart';
import 'package:app_ecommerce/Models/ProductModel.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Repository/buyer_auth_repo.dart';

final buyerUserProvider = StateProvider<BuyerModel?>((ref) => null);

final buyerAuthControProvider =
    StateNotifierProvider<BuyerAuthController, bool>((ref) {
  return BuyerAuthController(
      buyerAuthRepo: ref.read(buyerAuthRepoProvider),
      ref: ref,
      storageRepository: ref.read(firebaseStorageProvider));
});

//
final buyerAuthStateChangedProvider = StreamProvider((ref) {
  final authController = ref.watch(buyerAuthControProvider.notifier);

  return authController.authStateChnaged;
});
final buyerUserdataProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(buyerAuthControProvider.notifier).getUserdata(uid);
});
final getAllProductsBuyerProvider = StreamProvider((ref) {
  return ref.watch(buyerAuthControProvider.notifier).getProduct();
});

final getCartDeatilsBuyerProvider = StreamProvider.family((ref, String byID) {
  return ref.watch(buyerAuthControProvider.notifier).getUserCartDetails(byID);
});
final getParticularProductdetailsBuyerProvider =
    StreamProvider.family((ref, String prId) {
  return ref
      .read(buyerAuthControProvider.notifier)
      .getparticularProductdetailsBuyer(prId);
});

// ################

class BuyerAuthController extends StateNotifier<bool> {
  final BuyerAuthRepo _buyerAuthRepo;
  final Ref _ref;
  final StorageRepository _storageRepository;
  BuyerAuthController(
      {required BuyerAuthRepo buyerAuthRepo,
      required Ref ref,
      required StorageRepository storageRepository})
      : _buyerAuthRepo = buyerAuthRepo,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  //
  Stream<User?> get authStateChnaged => _buyerAuthRepo.authState;

  void signUpEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    state = true;

    final user = await _buyerAuthRepo.signUpEmailandPass(email, password, name);

    state = false;
    user.fold(
        (l) => {
              Fluttertoast.showToast(
                  gravity: ToastGravity.CENTER,
                  msg: "Error in creation of account 😓",
                  fontSize: 20,
                  backgroundColor: Pallete.redColor),
            },
        (r) => {
              _ref.read(buyerUserProvider.notifier).update((state) => r),
              Fluttertoast.showToast(
                msg: "Signed In Sucesfully",
                fontSize: 20,
                gravity: ToastGravity.CENTER,
                backgroundColor: Pallete.greenColor,
              ).then((value) {
                // here give navigation
              }).then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SellerHomeScreen(),
                  ),
                  (route) => false,
                );
              }),
              //
            });
  }

  // login ##############((((((((((((((((()))))))))))))))))
  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;

    final user = await _buyerAuthRepo.loginWithEmailAndPass(email, password);

    state = false;
    user.fold((l) {
      Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: "Error in logging in account 😓",
          fontSize: 20,
          backgroundColor: Pallete.redColor);
    }, (r) {
      Fluttertoast.showToast(
              msg: "Signed In Sucesfully", backgroundColor: Pallete.greenColor)
          .then((value) {
        // here give navigation
      }).then((value) async {
        BuyerModel buyerModel = await _buyerAuthRepo.getUserdata(r.by_id).first;

        if (buyerModel != null) {
          _ref.read(buyerUserProvider.notifier).update((state) => buyerModel);
        }
      }).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SellerHomeScreen(),
          ),
          (route) => false,
        );
      });
    });
  }

  // ##########%^&^&(*)
  Stream<BuyerModel> getUserdata(String uid) {
    return _buyerAuthRepo.getUserdata(uid);
  }

  // ######%^&*()
  void editBuyerProf({
    required BuildContext context,
    required File? profileImage,
    required Uint8List? profileWebImage,
    required String name,
    required String address,
    required int phoneNumber,
  }) async {
    state = true;
    BuyerModel buyerModel = _ref.read(buyerUserProvider)!;
    if (profileImage != null || profileWebImage != null) {
      final res = await _storageRepository.storeFile(
          path: "buyers/profileImage",
          id: buyerModel.by_id,
          file: profileImage);

      res.fold((l) {
        Fluttertoast.showToast(
          msg: "Error",
          backgroundColor: Pallete.redColor,
        );
      }, (r) {
        buyerModel = buyerModel.copyWith(by_pro: r);
      });
    }

    buyerModel = buyerModel.copyWith(
        by_name: name, by_address: address, by_phone: phoneNumber);
    final res = await _buyerAuthRepo.editBuyerPro(buyerModel);
    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Error",
        backgroundColor: Pallete.redColor,
      );
    }, (r) {
      _ref.read(buyerUserProvider.notifier).update((state) => buyerModel);
      Fluttertoast.showToast(
        msg: "Success",
        backgroundColor: Pallete.greenColor,
      );
    });

    state = false;
  }

  Stream<List<ProductModel>> getProduct() {
    return _buyerAuthRepo.getAllProduct();
  }

  Stream<List<String>> getUserCartDetails(String by_ID) {
    return _buyerAuthRepo.getUserCartDetails(by_ID);
  }

  Stream<ProductModel> getparticularProductdetailsBuyer(String prId) {
    return _buyerAuthRepo.getparticularProductdetailsBuyer(prId);
  }

  // ###########$%^&*()_(^^(%%(&*)))
  void buyerLogout() {
    _buyerAuthRepo.buyerLogout();
  }
}
