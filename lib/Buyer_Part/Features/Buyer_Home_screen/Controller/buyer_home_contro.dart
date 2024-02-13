import 'dart:io';

import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Auth/Controller/buyer_auth_contro.dart';
import 'package:app_ecommerce/Buyer_Part/Features/Buyer_Home_screen/Repository/buyer_home_repo.dart';
import 'package:app_ecommerce/Buyer_Part/Models/Buyer_Model.dart';
import 'package:app_ecommerce/Buyer_Part/Models/Buyer_Review.dart';
import 'package:app_ecommerce/Buyer_Part/Models/Order_Placing_model.dart';
import 'package:app_ecommerce/Models/ProductModel.dart';
import 'package:app_ecommerce/Models/QuestionAnwerModel.dart';
import 'package:app_ecommerce/Pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../../../Admin_Part/Models/Banner_model.dart';
import '../../../../Core/Providers/storageProvider.dart';
import '../../../../Models/UserModel.dart';

final buyerHomeControProvider =
    StateNotifierProvider<BuyerHomeController, bool>((ref) {
  return BuyerHomeController(
      buyerHomeRepo: ref.read(buyerHomeRepoProvider),
      ref: ref,
      storageRepository: ref.read(firebaseStorageProvider));
});

final searchProductsProvider = StreamProvider.family((ref, String name) {
  return ref.read(buyerHomeControProvider.notifier).searchProducts(name);
});

final getBuyerParticularProductProvider =
    StreamProvider.family((ref, String prID) {
  return ref.read(buyerHomeControProvider.notifier).getparticularProduct(prID);
});

// category products provider

final getCategoryProductsProvider =
    StreamProvider.family((ref, String queryName) {
  return ref
      .read(buyerHomeControProvider.notifier)
      .getCategoryProducts(queryName);
});
final getAllBannerProvider = StreamProvider((ref) {
  return ref.read(buyerHomeControProvider.notifier).getAllBanner();
});
final getAllQuestionIDProvider = StreamProvider.family((ref, String prID) {
  return ref.read(buyerHomeControProvider.notifier).getAllQuestionsId(prID);
});
final getParticularQuestionDeatilsProvider =
    StreamProvider.family((ref, String qID) {
  return ref
      .read(buyerHomeControProvider.notifier)
      .getParticularQuestionDeatils(qID);
});

final sameProductsProvider = StreamProvider.family((ref, String cat) {
  return ref.read(buyerHomeControProvider.notifier).sameProducts(cat);
});

final getSellerOtherProductsProvider =
    StreamProvider.family((ref, String slID) {
  return ref
      .read(buyerHomeControProvider.notifier)
      .getSellerOtherProducts(slID);
});
final getAllReviewIDSProvider = StreamProvider.family((ref, String prID) {
  return ref.read(buyerHomeControProvider.notifier).getAllReviewIDS(prID);
});
final getParticularReviewDetailsProvider =
    StreamProvider.family((ref, String revID) {
  return ref
      .read(buyerHomeControProvider.notifier)
      .getParticularReviewDetails(revID);
});

final getSellerDeatilsProvider = StreamProvider.family((ref, String slID) {
  return ref.read(buyerHomeControProvider.notifier).getSellerDetails(slID);
});
final getAllOrderIdsProvider = StreamProvider.family((ref, String byID) {
  return ref.read(buyerHomeControProvider.notifier).getOrderIds(byID);
});

final getParticularOrderDeatilsProvider =
    StreamProvider.family((ref, String orID) {
  return ref
      .read(buyerHomeControProvider.notifier)
      .getParticularOrderDeatils(orID);
});

//
// ##############Main####################
//
class BuyerHomeController extends StateNotifier<bool> {
  final BuyerHomeRepo _buyerHomeRepo;
  final StorageRepository _storageRepository;
  final Ref _ref;
  BuyerHomeController({
    required BuyerHomeRepo buyerHomeRepo,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _buyerHomeRepo = buyerHomeRepo,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  //@@@@@@@@@@@@@@@@@@@@@@^^^^^^^^^^^^^^^^^^^^^^

  // Search Feature@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  Stream<List<ProductModel>> searchProducts(String name) {
    return _buyerHomeRepo.searchProduct(name);
  }

  // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  Stream<ProductModel> getparticularProduct(String prID) {
    return _buyerHomeRepo.getparticularProduct(prID);
  }

  // Get all Product Feature@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  Stream<List<ProductModel>> getAllProduct() {
    return _buyerHomeRepo.getAllProduct();
  }

  void addcartProduct(BuyerModel buyerModel, String prID) async {
    final res = await _buyerHomeRepo.addcartProduct(buyerModel, prID);
    res.fold((l) {
      Fluttertoast.showToast(msg: "Cannot add to Cart");
    }, (r) {
      Fluttertoast.showToast(msg: "Done");
    });
  }

  void addToCart(String prId, String byID) async {
    final res = await _buyerHomeRepo.addToCart(prId, byID);
    res.fold((l) {
      Fluttertoast.showToast(msg: "Cannot add to Cart");
    }, (r) {
      Fluttertoast.showToast(msg: "Added Sucessfully");
    });
  }

  void deleteFromCart(String prId, String byID) async {
    final res = await _buyerHomeRepo.deleteFromCart(prId, byID);
    res.fold((l) {
      Fluttertoast.showToast(msg: "Cannot remove from Cart");
    }, (r) {
      Fluttertoast.showToast(msg: "Removed Sucessfully");
    });
  }

  //  get category products
  Stream<List<ProductModel>> getCategoryProducts(String queryName) {
    return _buyerHomeRepo.getCategoryProducts(queryName);
  }

  // Banners
  Stream<List<BannerModel>> getAllBanner() {
    return _buyerHomeRepo.getAllBanner();
  }
  // question answers part

  void postquestionBuyer({
    required BuildContext context,
    required String byId,
    required String slID,
    required String byQuestion,
    required String prId,
  }) async {
    state = true;
    //
    QuestionAnwerModel questionAnwerModel = QuestionAnwerModel(
        qID: const Uuid().v1(),
        by_ID: byId,
        sl_ID: slID,
        pr_ID: prId,
        by_question: byQuestion,
        sl_reply: "",
        liked: [],
        disliked: [],
        questionedTime: DateTime.now());
    final res = await _buyerHomeRepo.postQuestionBuyer(questionAnwerModel);
    state = false;
    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Cannot Post Due to Some Network Problem",
        gravity: ToastGravity.CENTER,
        backgroundColor: Pallete.redColor,
        // textColor: Pallete.whiteColor,
      );
    },
        (r) => {
              Fluttertoast.showToast(
                msg: "Question Submitted",
                backgroundColor: Pallete.greenColor,
                gravity: ToastGravity.CENTER,
              ).then((value) {
                Navigator.pop(context);
              })
            });

    //
  }

  // Product Question ID
  Stream<List<String>> getAllQuestionsId(String prID) {
    return _buyerHomeRepo.getAllQuestionsId(prID);
  }

  // getting it
  Stream<QuestionAnwerModel> getParticularQuestionDeatils(String qID) {
    return _buyerHomeRepo.getParticularQuestionDeatils(qID);
  }

  // delete question
  void deleteQuestion(
      {required String qID,
      required String prID,
      required BuildContext context}) async {
    state = true;
    final res = await _buyerHomeRepo.deleteQuestion(qID, prID);
    state = false;
    res.fold((l) {
      Fluttertoast.showToast(
        msg: "Cannot Deelete to Some Network Problem",
        gravity: ToastGravity.CENTER,
        backgroundColor: Pallete.redColor,
        // textColor: Pallete.whiteColor,
      );
    }, (r) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Question Deleted",
        backgroundColor: Pallete.greenColor,
        gravity: ToastGravity.CENTER,
      );
    });
  }
  // lIke the question

  void likeQuestion(QuestionAnwerModel questionAnwerModel, String byID) async {
    _buyerHomeRepo.likeQuestion(questionAnwerModel, byID);
  }

  // dislike question
  void disLikeQuestion(
      QuestionAnwerModel questionAnwerModel, String byID) async {
    _buyerHomeRepo.disLikeQuestion(questionAnwerModel, byID);
  }
  //

  // get similar product
  Stream<List<ProductModel>> sameProducts(String cat) {
    // final selectedImages =
    //     List<String>.from(_ref.watch(selectedProductIDProvider.notifier).state);
    // for (var element in selectedImages) {
    //   print("Id in FIRST ##########$element");
    // }
    // final prID = _ref.watch(selectedProductIDProvider.notifier).state.last;
    // print(prID);
    return _buyerHomeRepo.sameProducts(cat);
    // _ref.watch(selectedProductIDProvider.notifier).state.clear();
    // return res;
  }

  //
  //  get the Other  products of same seller
  Stream<List<ProductModel>> getSellerOtherProducts(String slID) {
    return _buyerHomeRepo.getSellerOtherProducts(slID);
  }

  // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  void addReview(
      {required BuildContext context,
      required List<File?> reviewImages,
      required String mainReview,
      required String revDeatils,
      required String prID,
      required String byID,
      required String slID,
      required String byName,
      required double revrating}) async {
    state = true;
    if (reviewImages.isNotEmpty) {
      final List<String> imageLink = await Future.wait(
        reviewImages.map((productImage) async {
          return await _storageRepository
              .storeFile(
                  path: "productReviewImage/reviews",
                  id: const Uuid().v1(),
                  file: productImage!)
              .then((value) => value.fold((l) => l.message, (r) => r));
        }),
      );
      final BuyerReview buyerReview = BuyerReview(
          revID: const Uuid().v1(),
          prID: prID,
          byID: byID,
          mainReview: mainReview,
          revDeatils: revDeatils,
          revImages: imageLink,
          revratings: revrating,
          slID: slID,
          byName: byName,
          revAgree: [],
          revDisAgree: [],
          revUploadDateTime: DateTime.now());
      final res = await _buyerHomeRepo.addratings(buyerReview);
      res.fold(
          (l) => Fluttertoast.showToast(
              msg: "Review Posting  Failed",
              backgroundColor: Pallete.redColor), (r) {
        Fluttertoast.showToast(
          msg: "Rating added successfully",
          backgroundColor: Pallete.greenColor,
          gravity: ToastGravity.CENTER,
        );
      });
    }
    state = false;
  }

  //
  Stream<List<String>> getAllReviewIDS(String prID) {
    return _buyerHomeRepo.getAllReviewIDS(prID);
  }

  //
  Stream<BuyerReview> getParticularReviewDetails(String revID) {
    return _buyerHomeRepo.getParticularReviewDetails(revID);
  }

  // agrre and disagree part
  void aggreeReview(BuyerReview buyerReview) async {
    _buyerHomeRepo.agreeReview(buyerReview);
  }

  void disAggreeReview(BuyerReview buyerReview) async {
    _buyerHomeRepo.disAgreeReview(buyerReview);
  }

  Stream<SellerModel> getSellerDetails(String slID) {
    return _buyerHomeRepo.getSellerDetails(slID);
  }
  // orders functions

  void orderNow(
      {required BuildContext context,
      required String byID,
      required String slID,
      required String prID,
      required int or_Quantity,
      required double total_ammount,
      required double or_price,
      required String prImage,
      required String prName}) async {
    state = true;
    final buyer = _ref.read(buyerUserProvider)!;
    final sellerName = _ref.watch(
        getSellerDeatilsProvider(slID).select((value) => value.value!.name));
    final sellerAddress = _ref.watch(
        getSellerDeatilsProvider(slID).select((value) => value.value!.address));
    // final prImage = _ref.watch(getBuyerParticularProductProvider(prID)
    //     .select((value) => value.value!.pr_img[0]));
    // final prName = _ref.watch(getBuyerParticularProductProvider(prID)
    //     .select((value) => value.value!.pr_name));
    //
    final OrderPlacingModel orderPlacingModel = OrderPlacingModel(
      orID: const Uuid().v1(),
      byID: byID,
      slID: slID,
      prID: prID,
      or_Quantity: or_Quantity,
      total_ammount: total_ammount,
      or_price: or_price,
      byName: buyer.by_name,
      byAddress: buyer.by_address,
      byNumber: buyer.by_phone.toString(),
      slName: sellerName,
      slAddress: sellerAddress,
      prImageOne: prImage,
      prName: prName,
    );

    final res = await _buyerHomeRepo.oderNow(orderPlacingModel);
    state = false;
    res.fold((l) {
      Fluttertoast.showToast(
          msg: "Order  Placing  Failed", backgroundColor: Pallete.redColor);
    }, (r) {
      Fluttertoast.showToast(
        msg: "Order Placed successfully",
        backgroundColor: Pallete.greenColor,
        gravity: ToastGravity.CENTER,
      ).then((value) => Navigator.pop(context));
    });
  }

  //
  Stream<List<String>> getOrderIds(String byID) {
    return _buyerHomeRepo.getOrderIds(byID);
  }

  Stream<OrderPlacingModel> getParticularOrderDeatils(String orID) {
    return _buyerHomeRepo.getParticularOrderDeatils(orID);
  }

  void cancelOrder(
      {required String orID,
      required String byID,
      required String slID}) async {
    state = true;
    final res = await _buyerHomeRepo.cancelOrder(orID, byID, slID);

    state = false;
    res.fold((l) {
      Fluttertoast.showToast(
          msg: "Order  Cancelling  Failed", backgroundColor: Pallete.redColor);
    }, (r) {
      Fluttertoast.showToast(
        msg: "Order Cancelled successfully",
        backgroundColor: Pallete.greenColor,
        gravity: ToastGravity.CENTER,
      );
    });
  }

  void deleteReview(
      {required String revID, required String byID, required String prID}) {
    _buyerHomeRepo.deleteReview(revID, prID, byID);
  }
}
