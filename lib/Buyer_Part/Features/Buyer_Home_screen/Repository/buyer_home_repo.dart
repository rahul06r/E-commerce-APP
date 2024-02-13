import 'package:app_ecommerce/Buyer_Part/Models/Buyer_Model.dart';
import 'package:app_ecommerce/Buyer_Part/Models/Buyer_Review.dart';
import 'package:app_ecommerce/Buyer_Part/Models/Order_Placing_model.dart';
import 'package:app_ecommerce/Core/Common/failure.dart';
import 'package:app_ecommerce/Core/Common/typeDef.dart';
import 'package:app_ecommerce/Core/Providers/firebaseProviders.dart';
import 'package:app_ecommerce/Models/ProductModel.dart';
import 'package:app_ecommerce/Models/QuestionAnwerModel.dart';
import 'package:app_ecommerce/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../Admin_Part/Models/Banner_model.dart';

final buyerHomeRepoProvider = Provider((ref) {
  return BuyerHomeRepo(firebaseFirestore: ref.read(firestoreProvider));
});

class BuyerHomeRepo {
  final FirebaseFirestore _firebaseFirestore;
  BuyerHomeRepo({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

// CollectionRef

// CollectionReference _product get=>_firebaseFirestore.collection("products");
  CollectionReference get _product => _firebaseFirestore.collection("products");
  CollectionReference get _buyers => _firebaseFirestore.collection("Buyer");
  CollectionReference get _banner => _firebaseFirestore.collection("Banners");
  CollectionReference get _review => _firebaseFirestore.collection("Reviews");
  CollectionReference get _orders => _firebaseFirestore.collection("Orders");
  CollectionReference get _seller => _firebaseFirestore.collection("users");
  CollectionReference get _questionAnswer =>
      _firebaseFirestore.collection("QuestionAnswer");

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
  Stream<ProductModel> getparticularProduct(String prID) {
    return _product.doc(prID).snapshots().map(
        (event) => ProductModel.fromMap(event.data() as Map<String, dynamic>));
  }

  //
  //

  Stream<List<ProductModel>> getAllProduct() {
    return _product.snapshots().map((event) => event.docs
        .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }

  // get category products
  Stream<List<ProductModel>> getCategoryProducts(String queryName) {
    return _product.where("pr_catogory", isEqualTo: queryName).snapshots().map(
          (event) => event.docs
              .map(
                  (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  FutureEither addcartProduct(BuyerModel buyerModel, String prId) async {
    try {
      if (buyerModel.by_add_to_cart.contains(prId)) {
        return right(_buyers.doc(buyerModel.by_id).update({
          "by_add_to_cart": FieldValue.arrayRemove([prId]),
        }));
      } else {
        return right(_buyers.doc(buyerModel.by_id).update({
          "by_add_to_cart": FieldValue.arrayUnion([prId]),
        }));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither addToCart(String prId, String byID) async {
    try {
      return right(
        _buyers.doc(byID).update({
          "by_add_to_cart": FieldValue.arrayUnion([prId]),
        }),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither deleteFromCart(String prId, String byID) async {
    try {
      return right(
        _buyers.doc(byID).update({
          "by_add_to_cart": FieldValue.arrayRemove([prId]),
        }),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Banners
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

  // Add question
  FutureVoid postQuestionBuyer(QuestionAnwerModel questionAnwerModel) async {
    try {
      return right(_questionAnswer
          .doc(questionAnwerModel.qID)
          .set(questionAnwerModel.toMap())
          .then((value) {
        _product.doc(questionAnwerModel.pr_ID).update({
          "pr_questions": FieldValue.arrayUnion([questionAnwerModel.qID]),
        });
      }));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<String>> getAllQuestionsId(String prID) {
    try {
      return _product.doc(prID).snapshots().map((event) {
        ProductModel productModel =
            ProductModel.fromMap(event.data() as Map<String, dynamic>);
        List<String> questionIds = [];
        for (var questionId in productModel.pr_questions) {
          questionIds.add(questionId);
        }
        return questionIds;
      });
    } catch (e) {
      rethrow;
    }
  }

  //
  Stream<QuestionAnwerModel> getParticularQuestionDeatils(String qID) {
    try {
      return _questionAnswer.doc(qID).snapshots().map((event) =>
          QuestionAnwerModel.fromMap(event.data() as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }

  //delete question
  FutureVoid deleteQuestion(String qID, String prID) async {
    try {
      return right(
        _product.doc(prID).update({
          "pr_questions": FieldValue.arrayRemove([qID]),
        }).then((value) {
          _questionAnswer.doc(qID).delete();
        }),
      );
      // return right(
      //   _questionAnswer.doc(qID).delete().then((value) {
      //     _product.doc(prID).update({
      //       "pr_questions": FieldValue.arrayRemove([qID]),
      //     });
      //   }),
      // );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // like the answer or question    disliked
  void likeQuestion(QuestionAnwerModel questionAnwerModel, String byID) async {
    if (questionAnwerModel.liked.contains(byID)) {
      _questionAnswer.doc(questionAnwerModel.qID).update({
        "liked": FieldValue.arrayRemove([byID]),
      });
    } else {
      _questionAnswer.doc(questionAnwerModel.qID).update({
        "liked": FieldValue.arrayUnion([byID]),
        "disliked": FieldValue.arrayRemove([byID]),
      });
    }
  }

  // dislike the answer or question
  void disLikeQuestion(
      QuestionAnwerModel questionAnwerModel, String byID) async {
    if (questionAnwerModel.disliked.contains(byID)) {
      _questionAnswer.doc(questionAnwerModel.qID).update({
        "disliked": FieldValue.arrayRemove([byID]),
      });
    } else {
      _questionAnswer.doc(questionAnwerModel.qID).update({
        "disliked": FieldValue.arrayUnion([byID]),
        "liked": FieldValue.arrayRemove([byID]),
      });
    }
  }

  // same products of the main product
  Stream<List<ProductModel>> sameProducts(String cat) {
    try {
      return _product
          .where("pr_catogory", isEqualTo: cat)
          // .where("pr_id", isNotEqualTo: prID)
          .snapshots()
          .map((event) => event.docs
              .map(
                  (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  //
  // get the Other  products of same seller

  Stream<List<ProductModel>> getSellerOtherProducts(String slID) {
    try {
      // use order by when time is added
      return _product.where("sl_id", isEqualTo: slID).snapshots().map((event) =>
          event.docs
              .map(
                  (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      rethrow;
    }
  }

  // ######################Rating
  FutureVoid addratings(BuyerReview buyerReview) async {
    try {
      return right(await _review
          .doc(buyerReview.revID)
          .set(buyerReview.toMap())
          .then((value) async {
        await _product.doc(buyerReview.prID).update({
          "review": FieldValue.arrayUnion([buyerReview.revID]),
        }).then((value) async {
          await _buyers.doc(buyerReview.byID).update({
            "by_review": FieldValue.arrayUnion([buyerReview.revID]),
          }).then((value) async {
            DocumentSnapshot productSnapshot =
                await _product.doc(buyerReview.prID).get();

            if (productSnapshot.exists) {
              ProductModel productModel = ProductModel.fromMap(
                  productSnapshot.data() as Map<String, dynamic>);
              double review = productModel.revRatings;
              double buyerReviewes = buyerReview.revratings;
              double total = double.parse(
                  ((review + buyerReviewes) / 2).toStringAsFixed(1));

              await _product.doc(buyerReview.prID).update({
                "revRatings": total,
              });
            } else {
              if (kDebugMode) {
                print("Product not found");
              }
            }
          });
        });
      }));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // FutureVoid addratings(BuyerReview buyerReview) async {
  //   try {
  //     return right(
  //       _review.doc(buyerReview.revID).set(buyerReview.toMap()).then((value) {
  //         _product.doc(buyerReview.prID).update({
  //           "review": FieldValue.arrayUnion([buyerReview.revID]),
  //         }).then((value) {
  //           _buyers.doc(buyerReview.byID).update({
  //             "by_review": FieldValue.arrayUnion([buyerReview.revID]),
  //           }).then((value) {
  //             // update the Average review count
  //             _product.doc(buyerReview.prID).snapshots().map((event) {
  //               ProductModel productModel =
  //                   ProductModel.fromMap(event.data() as Map<String, dynamic>);
  //               double review = productModel.revRatings;
  //               double buyerReviewes = buyerReview.revratings;
  //               double total = review + buyerReviewes / 2;
  //               if (kDebugMode) {
  //                 print(total);
  //               }
  //               _product.doc(buyerReview.prID).update({
  //                 "revRatings": total,
  //               });
  //             });
  //           });
  //         });
  //       }),
  //     );
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  FutureVoid deleteReview(String revID, String prID, String byID) async {
    try {
      return right(_product.doc(prID).update({
        "review": FieldValue.arrayRemove([revID])
      }).then((value) {
        _buyers.doc(byID).update({
          "by_review": FieldValue.arrayRemove([revID])
        }).then((value) {
          _review.doc(revID).delete();
        });
      })

          // _review.doc(revID).delete(),
          );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // get all the review ID

  Stream<List<String>> getAllReviewIDS(String prID) {
    try {
      return _product.doc(prID).snapshots().map((event) {
        ProductModel productModel =
            ProductModel.fromMap(event.data() as Map<String, dynamic>);
        List<String> reviewIDS = [];
        for (var reviewID in productModel.review) {
          reviewIDS.add(reviewID);
        }
        return reviewIDS;
      });
    } catch (e) {
      rethrow;
    }
  }

  // get paricular review deatils
  Stream<BuyerReview> getParticularReviewDetails(String revID) {
    return _review.doc(revID).snapshots().map(
        (event) => BuyerReview.fromMap(event.data() as Map<String, dynamic>));
  }

  // like a review
  void agreeReview(BuyerReview buyerReview) async {
    if (buyerReview.revAgree.contains(buyerReview.byID)) {
      _review.doc(buyerReview.revID).update({
        "revAgree": FieldValue.arrayRemove([buyerReview.byID]),
      });
    } else {
      _review.doc(buyerReview.revID).update({
        "revAgree": FieldValue.arrayUnion([buyerReview.byID]),
        "revDisAgree": FieldValue.arrayRemove([buyerReview.byID]),
      });
    }
  }

  void disAgreeReview(BuyerReview buyerReview) async {
    if (buyerReview.revDisAgree.contains(buyerReview.byID)) {
      _review.doc(buyerReview.revID).update({
        "revDisAgree": FieldValue.arrayRemove([buyerReview.byID]),
      });
    } else {
      _review.doc(buyerReview.revID).update({
        "revDisAgree": FieldValue.arrayUnion([buyerReview.byID]),
        "revAgree": FieldValue.arrayRemove([buyerReview.byID]),
      });
    }
  }

  //
  Stream<SellerModel> getSellerDetails(String slID) {
    return _seller.doc(slID).snapshots().map(
        (event) => SellerModel.fromMap(event.data() as Map<String, dynamic>));
  }

  // order fucntions here
  //

  FutureVoid oderNow(OrderPlacingModel orderPlacingModel) async {
    try {
      return right(_orders
          .doc(orderPlacingModel.orID)
          .set(orderPlacingModel.toMap())
          .then((value) {
        _buyers.doc(orderPlacingModel.byID).update({
          "by_bought": FieldValue.arrayUnion([orderPlacingModel.orID]),
        }).then((value) {
          _seller.doc(orderPlacingModel.slID).update({
            "total_product_sold":
                FieldValue.arrayUnion([orderPlacingModel.orID]),
            // pass a fucntion here
            "totalAmmount": "",
          });
        });
      }));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // get orders
  Stream<List<String>> getOrderIds(String byID) {
    try {
      return _buyers.doc(byID).snapshots().map((event) {
        BuyerModel buyerModel =
            BuyerModel.fromMap(event.data() as Map<String, dynamic>);
        List<String> ordIds = [];
        for (var orderId in buyerModel.by_bought) {
          ordIds.add(orderId);
        }
        return ordIds;
      });
    } catch (e) {
      rethrow;
    }
  }

  // particular Order details
  Stream<OrderPlacingModel> getParticularOrderDeatils(String orID) {
    return _orders.doc(orID).snapshots().map((event) =>
        OrderPlacingModel.fromMap(event.data() as Map<String, dynamic>));
  }

  //
  FutureVoid cancelOrder(String orID, String byID, String slID) async {
    try {
      return right(_buyers.doc(byID).update({
        "by_bought": FieldValue.arrayRemove([orID]),
      }).then((value) {
        _seller.doc(slID).update({
          "total_product_sold": FieldValue.arrayRemove([orID]),
          // pass a fucntion here
          "totalAmmount": "",
        });
      }).then((value) {
        _orders.doc(orID).delete();
      }));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
