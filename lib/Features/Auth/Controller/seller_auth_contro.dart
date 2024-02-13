import 'dart:io';
import 'dart:typed_data';

import 'package:app_ecommerce/Core/Providers/storageProvider.dart';
import 'package:app_ecommerce/Features/Auth/Repository/seller_auth_repo.dart';
import 'package:app_ecommerce/Features/Homescreen/Screens/seller_home_screen.dart';
import 'package:app_ecommerce/Models/UserModel.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final sellerUserProvider = StateProvider<SellerModel?>((ref) => null);

final sellerauthControllerProvider =
    StateNotifierProvider<SellerAuthContro, bool>((ref) {
  return SellerAuthContro(
      sellerAuthRepo: ref.watch(sellerAuthRepoProvider),
      ref: ref,
      storageRepository: ref.watch(firebaseStorageProvider));
});

final sellerAuthStateChangedProvider = StreamProvider((ref) {
  final authController = ref.watch(sellerauthControllerProvider.notifier);

  return authController.authStateChnaged;
});

final sellerUserdataProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(sellerauthControllerProvider.notifier).getUserdata(uid);
});

class SellerAuthContro extends StateNotifier<bool> {
  final SellerAuthRepo _authRepo;
  final Ref _ref;
  final StorageRepository _storageRepository;
  SellerAuthContro({
    required SellerAuthRepo sellerAuthRepo,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _authRepo = sellerAuthRepo,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  Stream<User?> get authStateChnaged => _authRepo.authState;

  void signUpEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    state = true;

    final user = await _authRepo.sigupWithEmailAndPass(email, password, name);

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
              _ref.read(sellerUserProvider.notifier).update((state) => r),
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

  //
  //

  // LOgin

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;

    final user = await _authRepo.loginWithEmailAndPass(email, password);

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
        SellerModel sellerModel = await _authRepo.getUserdata(r.id).first;

        if (sellerModel != null) {
          _ref.read(sellerUserProvider.notifier).update((state) => sellerModel);
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

  //
  //
  // Edit profile
  //
  void editProfile({
    required BuildContext context,
    required File? profileImage,
    required Uint8List? profileWebImage,
    required String name,
    required String address,
    required String desc,
    required int phoneNumber,
    // mobile number update feature
  }) async {
    state = true;
    SellerModel sellerModel = _ref.read(sellerUserProvider)!;
    if (profileImage != null || profileWebImage != null) {
      final res = await _storageRepository.storeFile(
        path: "users/profile",
        id: sellerModel.id,
        file: profileImage,
        // webFile: profileWebImage,
      );

      res.fold((l) {
        Fluttertoast.showToast(
          msg: "Error",
          backgroundColor: Pallete.redColor,
        );
      }, (r) {
        sellerModel = sellerModel.copyWith(sel_pro: r);
      });
    }

    sellerModel = sellerModel.copyWith(
        name: name, address: address, description: desc, sl_phone: phoneNumber);

    final res = await _authRepo.editPro(sellerModel);

    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Error",
        backgroundColor: Pallete.redColor,
      );
    }, (r) {
      _ref.read(sellerUserProvider.notifier).update((state) => sellerModel);
      Fluttertoast.showToast(
        msg: "Success",
        backgroundColor: Pallete.greenColor,
      );
    });

    state = false;
  }
  //

  //

  //

  Stream<SellerModel> getUserdata(String uid) {
    return _authRepo.getUserdata(uid);
  }

  void sellerLogout() {
    _authRepo.sellerLogout();
  }
}
