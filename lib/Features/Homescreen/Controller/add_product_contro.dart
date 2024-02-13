import 'dart:io';

import 'package:app_ecommerce/Buyer_Part/Models/Order_Placing_model.dart';
import 'package:app_ecommerce/Core/Providers/storageProvider.dart';
import 'package:app_ecommerce/Features/Auth/Controller/seller_auth_contro.dart';
import 'package:app_ecommerce/Features/Homescreen/Repository/add_product_repo.dart';
import 'package:app_ecommerce/Models/ProductModel.dart';
import 'package:app_ecommerce/Models/QuestionAnwerModel.dart';
import 'package:app_ecommerce/Models/UserModel.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

final addProductControProvider =
    StateNotifierProvider<AddProductContro, bool>((ref) {
  return AddProductContro(
      addProductRepo: ref.read(addProductProvider),
      storageRepository: ref.read(firebaseStorageProvider),
      ref: ref);
});

final getAllProductsProvider = StreamProvider.family((ref, String slid) {
  return ref.read(addProductControProvider.notifier).getProductSeller(slid);
});
final alreadyPresentedImagesProvider =
    StateProvider<List<dynamic>>((ref) => []);

final getParticularProductInfoProvider =
    StreamProvider.family((ref, String prID) {
  return ref
      .read(addProductControProvider.notifier)
      .getParticularProductInfo(prID);
});
final getAllQuestionsIdForSellerProvider =
    StreamProvider.family((ref, String prID) {
  return ref
      .read(addProductControProvider.notifier)
      .getAllQuestionsIdForSeller(prID);
});

final getParticularQuestionDeatilsForSellerProvider =
    StreamProvider.family((ref, String prID) {
  return ref
      .read(addProductControProvider.notifier)
      .getParticularQuestionDeatilsForSeller(prID);
});

final getAllOrdersIDSForSellerProvider = StreamProvider((ref) {
  return ref.read(addProductControProvider.notifier).getAllOrdersIDS();
});
final getPartcularOrderDetailsForSellerProvider =
    StreamProvider.family((ref, String prID) {
  return ref
      .read(addProductControProvider.notifier)
      .getPartcularOrderDetails(prID);
});

class AddProductContro extends StateNotifier<bool> {
  final Ref _ref;
  final AddProductRepo _addProductRepo;
  final StorageRepository _storageRepository;
  AddProductContro({
    required AddProductRepo addProductRepo,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _addProductRepo = addProductRepo,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  //

  //
  void addProducts({
    required List<File?> productImages,
    Uint8List? productWebImages,
    required BuildContext context,
    required String sellerId,
    required String productName,
    required String productDescription,
    required String productCategory,
    required double productAmt,
    required String brand,
  }) async {
    state = true;
    String prId = const Uuid().v1();
    SellerModel sellerModel = _ref.read(sellerUserProvider)!;
    // final existingProducts = _ref.watch(getAllProductsProvider);
    // print(existingProducts.value!.contains(productName));

//
    if (productImages.isNotEmpty) {
      final List<String> imageLink = await Future.wait(
        productImages.map((productImage) async {
          return await _storageRepository
              .storeFile(
                path: "productImage/products",
                id: const Uuid().v1(),
                file: productImage!,
              )
              .then((value) => value.fold((l) => l.message, (r) => r));
        }),
      );
      final ProductModel productModel = ProductModel(
        pr_id: prId,
        pr_name: productName,
        description: productDescription,
        sl_id: sellerId,
        sl_name: productName,
        sl_photo: sellerModel.sel_pro,
        pr_img: imageLink,
        pr_catogory: productCategory,
        review: [],
        pr_questions: [],
        pr_ammount: productAmt,
        discount_Ammount: 0.0,
        brand: brand,
        revRatings: 0.0,
      );
      final res = await _addProductRepo.addProduct(productModel);
      res.fold(
          (l) => {
                Fluttertoast.showToast(msg: "Product Failed"),
              },
          (r) => Fluttertoast.showToast(
                msg: "Success",
                backgroundColor: Pallete.greenColor,
                gravity: ToastGravity.CENTER,
              ));
    }

    //

    state = false;
  }

  Stream<List<String>> getProductSeller(String sl_id) {
    return _addProductRepo.getSellerProductId(sl_id);
  }

  //
  //
  Stream<ProductModel> getParticularProductInfo(String prID) {
    return _addProductRepo.getParticularProductInfo(prID);
  }

  // Delete Product #####******

  void deleteProduct(String prID, BuildContext context, String sl_ID) async {
    final res = await _addProductRepo.deleteProduct(prID, sl_ID);
    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Sorry,Cannot delete the product",
        backgroundColor: Pallete.redColor,
        gravity: ToastGravity.CENTER,
      );
    }, (r) {
      Fluttertoast.showToast(
          msg: "Product Deleted",
          backgroundColor: Pallete.greenColor,
          gravity: ToastGravity.CENTER);
      Navigator.pop(context);
    });
  }

  //Edit

  void editProduct(
    List<File?> productImages, {
    required BuildContext context,
    required String productName,
    required String productDescription,
    required double pr_disc,
    required double productAmt,
    required String pr_id,
  }) async {
    state = true;

    if (productImages.isNotEmpty) {
      final List<String> imageLink =
          await Future.wait(productImages.map((productImage) async {
        return await _storageRepository
            .storeFile(
                path: "productImage/products",
                id: const Uuid().v1(),
                file: productImage!)
            .then((value) => value.fold((l) => l.message, (r) => r));
      }));
      final res = await _addProductRepo.editProduct(
        pr_id,
        productName,
        productDescription,
        productAmt,
        pr_disc,
        imageLink,
      );
      state = false;

      res.fold(
        (l) {
          Fluttertoast.showToast(
            msg: "Cannot be updated",
            backgroundColor: Pallete.redColor,
            gravity: ToastGravity.CENTER,
          ).then((value) => Navigator.pop(context));
        },
        (r) {
          Fluttertoast.showToast(
            msg: "Successfully updated",
            backgroundColor: Pallete.greenColor,
            gravity: ToastGravity.CENTER,
          ).then((value) => Navigator.pop(context));
        },
      );
    } else {
      final List<String> imageLink = [];
      final res = await _addProductRepo.editProduct(
        pr_id,
        productName,
        productDescription,
        productAmt,
        pr_disc,
        imageLink,
      );
      state = false;

      res.fold(
        (l) {
          Fluttertoast.showToast(
            msg: "Cannot be updated",
            backgroundColor: Pallete.redColor,
            gravity: ToastGravity.CENTER,
          ).then((value) => Navigator.pop(context));
        },
        (r) {
          Fluttertoast.showToast(
            msg: "Successfully updated",
            backgroundColor: Pallete.greenColor,
            gravity: ToastGravity.CENTER,
          ).then((value) => Navigator.pop(context));
        },
      );
    }
  }

  void deleteProductImage({
    required BuildContext context,
    required String pr_id,
    required String pr_imgLink,
  }) async {
    state = true;

    final res = await _addProductRepo.deleteProductImage(pr_id, pr_imgLink);
    if (kDebugMode) {
      print("contorller ${pr_imgLink}");
    }
    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Cannot be Deleted",
        gravity: ToastGravity.CENTER,
      );
    }, (r) {
      Fluttertoast.showToast(
        msg: "Deleted",
        backgroundColor: Pallete.greenColor,
        gravity: ToastGravity.CENTER,
      );
    });
    //

    //

    state = false;
  }

  // Answer qeustion of the buyer
  void answerQuestionofBuyer({
    required String slAnwser,
    required String qID,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _addProductRepo.answerQuestionofBuyer(slAnwser, qID);

    state = false;
    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Cannot Post Answer Due to Some Network Problem",
        gravity: ToastGravity.CENTER,
        backgroundColor: Pallete.redColor,
        // textColor: Pallete.whiteColor,
      );
    }, (r) {
      Fluttertoast.showToast(
        msg: "Question Submitted",
        backgroundColor: Pallete.greenColor,
        gravity: ToastGravity.CENTER,
      ).then((value) {
        Navigator.pop(context);
      });
    });
  }

  //
  Stream<List<String>> getAllQuestionsIdForSeller(String prID) {
    return _addProductRepo.getAllQuestionsIdForSeller(prID);
  }

  // getting it
  Stream<QuestionAnwerModel> getParticularQuestionDeatilsForSeller(String qID) {
    return _addProductRepo.getParticularQuestionDeatilsForSeller(qID);
  }

  // delete answer
  void deleteAnswerOfTheQuestion(
      {required String qID, required BuildContext context}) async {
    state = true;
    final res = await _addProductRepo.deleteAnswerOfTheQuestion(qID);

    state = false;
    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Cannot Delete Answer Due to Some Network Problem",
        gravity: ToastGravity.CENTER,
        backgroundColor: Pallete.redColor,
        // textColor: Pallete.whiteColor,
      );
    }, (r) {
      Fluttertoast.showToast(
        msg: "Question Submitted",
        backgroundColor: Pallete.greenColor,
        gravity: ToastGravity.CENTER,
      ).then((value) {
        Navigator.pop(context);
      });
    });
  }

  // Get al the orderIDS
  Stream<List<String>> getAllOrdersIDS() {
    final seller = _ref.read(sellerUserProvider)!;
    return _addProductRepo.getAllOrdersIDS(seller.id);
  }

  Stream<OrderPlacingModel> getPartcularOrderDetails(String orID) {
    return _addProductRepo.getPartcularOrderDetails(orID);
  }
}

//
//
// final deleteImages = List<String>.from(
//     _ref.read(alreadyPresentedImagesProvider.notifier).state);
// for (var element in deleteImages) {
//   final res = await _addProductRepo.deleteProduct(pr_id, element);
//   res.fold((l) {
//     Fluttertoast.showToast(
//       msg: "Cannot be Deleted",
//     );
//   }, (r) {
//     Fluttertoast.showToast(
//       msg: "Deleted",
//       gravity: ToastGravity.CENTER,
//     );
//   });
// }
