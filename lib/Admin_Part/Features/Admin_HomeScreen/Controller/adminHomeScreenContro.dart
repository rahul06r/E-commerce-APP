import 'dart:io';

import 'package:app_ecommerce/Admin_Part/Features/Admin_Auth/Controller/admin_auth_contro.dart';
import 'package:app_ecommerce/Admin_Part/Features/Admin_HomeScreen/Repository/admin_homeScreenrepo.dart';
import 'package:app_ecommerce/Admin_Part/Models/Admin_model.dart';
import 'package:app_ecommerce/Admin_Part/Models/Banner_model.dart';
import 'package:app_ecommerce/Models/ProductModel.dart';
import 'package:app_ecommerce/Models/Seller_Acceptance_model.dart';
import 'package:app_ecommerce/Models/UserModel.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../../../Core/Providers/storageProvider.dart';

final adminHomeScreenControProvider =
    StateNotifierProvider<AdminHomeScreenController, bool>((ref) {
  return AdminHomeScreenController(
      adminHomeScreenRepository: ref.read(adminHomeScreenRepoProvider),
      storageRepository: ref.read(firebaseStorageProvider),
      ref: ref);
});

// seller account
final getParticularSellerDetailsAccountProvider =
    StreamProvider.family((ref, String slID) {
  return ref
      .read(adminHomeScreenControProvider.notifier)
      .getParticularSellerDetailsAccount(slID);
});

//
final getAllNumberSellerRequestProvider = StreamProvider((ref) {
  return ref
      .read(adminHomeScreenControProvider.notifier)
      .getAllNumberOfSellerAccpet();
});

final getAllBannerProvider = StreamProvider((ref) {
  return ref.read(adminHomeScreenControProvider.notifier).getAllBanner();
});

final searchProductsProvider = StreamProvider.family((ref, String prname) {
  return ref
      .read(adminHomeScreenControProvider.notifier)
      .searchProducts(prname);
});
final searchSellerProvider = StreamProvider.family((ref, String slname) {
  return ref.read(adminHomeScreenControProvider.notifier).searchSeller(slname);
});

class AdminHomeScreenController extends StateNotifier<bool> {
  final AdminHomeScreenRepository _adminHomeScreenRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  AdminHomeScreenController({
    required AdminHomeScreenRepository adminHomeScreenRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _adminHomeScreenRepository = adminHomeScreenRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

//
//
//getSellerAccount
  Stream<SellerAcceptanceModel> getParticularSellerDetailsAccount(String slID) {
    return _adminHomeScreenRepository.getParticularSellerRequestAccount(slID);
  }

  Stream<List<ProductModel>> getAllProducts() {
    return _adminHomeScreenRepository.getAllNumberProducts();
  }

  Stream<List<SellerAcceptanceModel>> getAllNumberOfSellerAccpet() {
    return _adminHomeScreenRepository.getAllNumberOfSellerAccpet();
  }

  // Selleraccept feature here
  void sellerAcceptByAdmin(String slid, bool isAccpeted) async {
    state = true;
    final res =
        await _adminHomeScreenRepository.sellerAcceptByAdmin(slid, isAccpeted);

    state = false;

    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Error occured,Please try again later",
        gravity: ToastGravity.CENTER,
        backgroundColor: Pallete.redColor,
      );
    }, (r) {
      Fluttertoast.showToast(
        msg: "Accpeted",
        backgroundColor: Pallete.greenColor,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      ).whenComplete(
        () => Fluttertoast.showToast(
          msg: "A notification has been sent to seller about his status",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Pallete.balckColor,
        ),
      );
    });
  }

  void sellerRejectByAdmin(String slid, bool isAccpeted) async {
    state = true;
    final res =
        await _adminHomeScreenRepository.sellerRejectByAdmin(slid, isAccpeted);

    state = false;

    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Error occured,Please try again later",
        gravity: ToastGravity.CENTER,
        backgroundColor: Pallete.redColor,
      );
    }, (r) {
      Fluttertoast.showToast(
        msg: "Rejected",
        backgroundColor: Pallete.greenColor,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
      ).whenComplete(
        () => Fluttertoast.showToast(
          msg: "A notification has been sent to seller about his status",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Pallete.balckColor,
        ),
      );
    });
  }

  // Add banner images
  void addBanner({
    required List<File?> bannerImages,
    required BuildContext context,
  }) async {
    state = true;
    String banId = const Uuid().v1();
    AdminModel adminModel = _ref.read(admiUserProvider)!;

    if (bannerImages.isNotEmpty) {
      final List<String> bannerLink = await Future.wait(
        bannerImages.map((bannerImage) async {
          return await _storageRepository
              .storeFile(
                  path: "bannerImage/banners",
                  id: const Uuid().v1(),
                  file: bannerImage!)
              .then((value) => value.fold((l) => l.message, (r) => r));
        }),
      );

      //
      final BannerModel bannerModel = BannerModel(
        ban_id: const Uuid().v1(),
        ad_id: adminModel.ad_id,
        uploadTime: DateTime.now(),
        ban_images: bannerLink,
        showThis: false,
      );

      final res = await _adminHomeScreenRepository.addBannner(bannerModel);
      res.fold((l) {
        Fluttertoast.showToast(msg: "Banner add failed");
      }, (r) {
        Fluttertoast.showToast(
          msg: "Banner added Success",
          backgroundColor: Pallete.greenColor,
          gravity: ToastGravity.CENTER,
        );
      });
    }

    state = false;
  }
  // get banners

  Stream<List<BannerModel>> getAllBanner() {
    return _adminHomeScreenRepository.getAllBanner();
  }
  // delete banner

  void deleteBanner({
    required String bn_id,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _adminHomeScreenRepository.deleteBanner(bn_id);
    res.fold((l) {
      Fluttertoast.showToast(msg: "Banner Deletion failed");
    }, (r) {
      Fluttertoast.showToast(
        msg: "Banner Deletion Success",
        backgroundColor: Pallete.greenColor,
        gravity: ToastGravity.CENTER,
      );
    });

    state = false;
  }

  // Products search
  Stream<List<ProductModel>> searchProducts(String name) {
    return _adminHomeScreenRepository.searchProduct(name);
  }

  // Stream<List<SellerModel>> searchSeller(String name) {
  //   return _adminHomeScreenRepository.searchSeller(name);
  // }
  Stream<List<SellerAcceptanceModel>> searchSeller(String name) {
    return _adminHomeScreenRepository.searchSeller(name);
  }
}
