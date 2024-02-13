import 'dart:io';

import 'package:app_ecommerce/Admin_Part/Features/Admin_Auth/Repository/admin_auth_repo.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Screens/adminHomeScreen.dart';
import 'package:app_ecommerce/Admin_Part/Models/Admin_model.dart';
import 'package:app_ecommerce/Core/Providers/storageProvider.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final admiUserProvider = StateProvider<AdminModel?>((ref) {
  return null;
});

final adminAuthControProvider =
    StateNotifierProvider<AdminAuthController, bool>((ref) {
  return AdminAuthController(
      adminAuthRepo: ref.read(adminAuthRepoProvider),
      ref: ref,
      storageRepository: ref.read(firebaseStorageProvider));
});

final adminAuthStateChangedProvider = StreamProvider((ref) {
  final authCOntroller = ref.watch(adminAuthControProvider.notifier);

  return authCOntroller.authStateChanged;
});

final adminUserDataProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(adminAuthControProvider.notifier).getUserdata(uid);
});

class AdminAuthController extends StateNotifier<bool> {
  final AdminAuthRepo _adminAuthRepo;
  final Ref _ref;
  final StorageRepository _storageRepository;
  AdminAuthController({
    required AdminAuthRepo adminAuthRepo,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _adminAuthRepo = adminAuthRepo,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);
  Stream<User?> get authStateChanged => _adminAuthRepo.authState;

  void signUpEmailandPassword({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    state = true;
    final user = await _adminAuthRepo.signUpEmailandPass(email, password, name);

    state = false;
    user.fold((l) {
      Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          msg: "Error in creation of account 😓",
          fontSize: 20,
          backgroundColor: Pallete.redColor);
    }, (r) {
      _ref.read(admiUserProvider.notifier).update((state) => r);
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
            builder: (context) => const AdminHomeScreen(),
          ),
          (route) => false,
        );
      });
    });
  }

  // login #######################?????????????

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final user = await _adminAuthRepo.loginWithEmaiandPassword(email, password);

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
        AdminModel adminModel = await _adminAuthRepo.getUserdata(r.ad_id).first;

        if (adminModel != null) {
          _ref.read(admiUserProvider.notifier).update((state) => adminModel);
        }
      }).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHomeScreen(),
          ),
          (route) => false,
        );
      });
    });
  }

  Stream<AdminModel> getUserdata(String uid) {
    return _adminAuthRepo.getUserdata(uid);
  }

  void adminLogOut() {
    _adminAuthRepo.adminLogOut();
  }

  void editAdminProfile({
    required BuildContext context,
    required File? profileImage,
    required Uint8List? profileWebImage,
    required String name,
  }) async {
    state = true;
    AdminModel adminModel = _ref.read(admiUserProvider)!;
    if (profileImage != null || profileWebImage != null) {
      final res = await _storageRepository.storeFile(
          path: "admin/profileImage", id: adminModel.ad_id, file: profileImage);

      res.fold((l) {
        Fluttertoast.showToast(
          msg: "Error",
          backgroundColor: Pallete.redColor,
        );
      }, (r) {
        adminModel = adminModel.copyWith(ad_pro: r);
      });
    }
    adminModel = adminModel.copyWith(
      ad_name: name,
    );
    final res = await _adminAuthRepo.editAdminProfile(adminModel);
    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Error",
        backgroundColor: Pallete.redColor,
      );
    }, (r) {
      _ref.read(admiUserProvider.notifier).update((state) => adminModel);
      Fluttertoast.showToast(
        msg: "Success",
        backgroundColor: Pallete.greenColor,
      );
    });

    state = false;
  }
}
