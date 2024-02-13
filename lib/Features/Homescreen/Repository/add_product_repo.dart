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

final addProductProvider = Provider((ref) {
  return AddProductRepo(firebaseFirestore: ref.read(firestoreProvider));
});

class AddProductRepo {
  final FirebaseFirestore _firebaseFirestore;
  AddProductRepo({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

//
//
//
  CollectionReference get _products =>
      _firebaseFirestore.collection("products");
  CollectionReference get _questionAnswer =>
      _firebaseFirestore.collection("QuestionAnswer");
  CollectionReference get _seller => _firebaseFirestore.collection("users");
  CollectionReference get _orders => _firebaseFirestore.collection("Orders");
//
  FutureVoid addProduct(ProductModel productModel) async {
    try {
      return right(
        _products
            .doc(productModel.pr_id)
            .set(
              productModel.toMap(),
            )
            .then((value) {
          _seller.doc(productModel.sl_id).update({
            "total_product": FieldValue.arrayUnion(
              [productModel.pr_id],
            ),
          });
        }),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Stream<Future<List<ProductModel>>> getAllProducts(String byId) {
  //   try {
  //     return _seller.doc(byId).snapshots().map((event) async {
  //       SellerModel sellerModel =
  //           SellerModel.fromMap(event.data() as Map<String, dynamic>);
  //       List<ProductModel> cart = [];

  //       for (var productId in sellerModel.total_product) {
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
  Stream<List<String>> getSellerProductId(String slID) {
    try {
      return _seller.doc(slID).snapshots().map((event) {
        SellerModel sellerModel =
            SellerModel.fromMap(event.data() as Map<String, dynamic>);
        List<String> partIDs = [];
        for (var partID in sellerModel.total_product) {
          partIDs.add(partID);
        }
        return partIDs;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<ProductModel> getParticularProductInfo(String prId) {
    return _products.doc(prId).snapshots().map(
        (event) => ProductModel.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureVoid deleteProduct(String prID, String sl_ID) async {
    try {
      return right(
        _products.doc(prID).delete().then((value) {
          // delete the images
        }).then((value) {
          _seller.doc(sl_ID).update({
            "total_product": FieldValue.arrayRemove([prID]),
          });
        }),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //Edit
  FutureVoid editProduct(
    String pr_id,
    String pr_name,
    String pr_desc,
    double pr_amt,
    double discount_ammount,
    List<String> productImages,
  ) async {
    try {
      if (kDebugMode) {
        print(productImages);
      }
      return right(
        _products.doc(pr_id).update({
          "pr_name": pr_name,
          "description": pr_desc,
          "pr_ammount": pr_amt,
          "discount_Ammount": discount_ammount,
          "pr_img": FieldValue.arrayUnion(
            productImages,
          ),
        }),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //
//  Delete features
  FutureVoid deleteProductImage(
    String pr_id,
    String productImages,
  ) async {
    try {
      if (kDebugMode) {
        print("Repposiorty part: ${productImages}");
      }
      return right(
        _products.doc(pr_id).update({
          "pr_img": FieldValue.arrayRemove([productImages]),
        }),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //
  //Answer question of the seller!

  FutureVoid answerQuestionofBuyer(String slAnwser, String qID) async {
    try {
      return right(
        _questionAnswer.doc(qID).update({
          "sl_reply": slAnwser,
        }),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // get all the product question iDS
  Stream<List<String>> getAllQuestionsIdForSeller(String prID) {
    try {
      return _products.doc(prID).snapshots().map((event) {
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

  // details of the question posted
  Stream<QuestionAnwerModel> getParticularQuestionDeatilsForSeller(String qID) {
    try {
      return _questionAnswer.doc(qID).snapshots().map((event) =>
          QuestionAnwerModel.fromMap(event.data() as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }

  FutureVoid deleteAnswerOfTheQuestion(String qID) async {
    try {
      return right(
        _questionAnswer.doc(qID).update({
          "sl_reply": "",
        }),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  // Get all the orders

  Stream<List<String>> getAllOrdersIDS(String slID) {
    try {
      return _seller.doc(slID).snapshots().map((event) {
        SellerModel sellerModel =
            SellerModel.fromMap(event.data() as Map<String, dynamic>);

        List<String> orderIDS = [];
        for (var orderID in sellerModel.total_product_sold) {
          orderIDS.add(orderID);
        }
        return orderIDS;
      });
    } catch (e) {
      rethrow;
    }
  }

  // get partcular order details
  Stream<OrderPlacingModel> getPartcularOrderDetails(String orID) {
    return _orders.doc(orID).snapshots().map((event) =>
        OrderPlacingModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
