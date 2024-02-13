// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class SellerModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String description;
  final String address;
  final String totalAmmount;
  final List<dynamic> total_product_sold;
  final List<dynamic> total_product;
  final List<dynamic> comments;
  final List<dynamic> totalSellerRating;
  final List<dynamic> sellerRating;
  final bool isAccepted;
  final String tag;
  final bool requested;
  final String sel_pro;
  final int sl_phone;
  SellerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.description,
    required this.address,
    required this.totalAmmount,
    required this.total_product_sold,
    required this.total_product,
    required this.comments,
    required this.totalSellerRating,
    required this.sellerRating,
    required this.isAccepted,
    required this.tag,
    required this.requested,
    required this.sel_pro,
    required this.sl_phone,
  });

  SellerModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? description,
    String? address,
    String? totalAmmount,
    List<dynamic>? total_product_sold,
    List<dynamic>? total_product,
    List<dynamic>? comments,
    List<dynamic>? totalSellerRating,
    List<dynamic>? sellerRating,
    bool? isAccepted,
    String? tag,
    bool? requested,
    String? sel_pro,
    int? sl_phone,
  }) {
    return SellerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      description: description ?? this.description,
      address: address ?? this.address,
      totalAmmount: totalAmmount ?? this.totalAmmount,
      total_product_sold: total_product_sold ?? this.total_product_sold,
      total_product: total_product ?? this.total_product,
      comments: comments ?? this.comments,
      totalSellerRating: totalSellerRating ?? this.totalSellerRating,
      sellerRating: sellerRating ?? this.sellerRating,
      isAccepted: isAccepted ?? this.isAccepted,
      tag: tag ?? this.tag,
      requested: requested ?? this.requested,
      sel_pro: sel_pro ?? this.sel_pro,
      sl_phone: sl_phone ?? this.sl_phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'description': description,
      'address': address,
      'totalAmmount': totalAmmount,
      'total_product_sold': total_product_sold,
      'total_product': total_product,
      'comments': comments,
      'totalSellerRating': totalSellerRating,
      'sellerRating': sellerRating,
      'isAccepted': isAccepted,
      'tag': tag,
      'requested': requested,
      'sel_pro': sel_pro,
      'sl_phone': sl_phone,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      totalAmmount: map['totalAmmount'] as String,
      total_product_sold:
          List<dynamic>.from((map['total_product_sold'] as List<dynamic>)),
      total_product:
          List<dynamic>.from((map['total_product'] as List<dynamic>)),
      comments: List<dynamic>.from((map['comments'] as List<dynamic>)),
      totalSellerRating:
          List<dynamic>.from((map['totalSellerRating'] as List<dynamic>)),
      sellerRating: List<dynamic>.from((map['sellerRating'] as List<dynamic>)),
      isAccepted: map['isAccepted'] as bool,
      tag: map['tag'] as String,
      requested: map['requested'] as bool,
      sel_pro: map['sel_pro'] as String,
      sl_phone: map['sl_phone'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SellerModel(id: $id, name: $name, email: $email, password: $password, description: $description, address: $address, totalAmmount: $totalAmmount, total_product_sold: $total_product_sold, total_product: $total_product, comments: $comments, totalSellerRating: $totalSellerRating, sellerRating: $sellerRating, isAccepted: $isAccepted, tag: $tag, requested: $requested, sel_pro: $sel_pro, sl_phone: $sl_phone)';
  }

  @override
  bool operator ==(covariant SellerModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.description == description &&
        other.address == address &&
        other.totalAmmount == totalAmmount &&
        listEquals(other.total_product_sold, total_product_sold) &&
        listEquals(other.total_product, total_product) &&
        listEquals(other.comments, comments) &&
        listEquals(other.totalSellerRating, totalSellerRating) &&
        listEquals(other.sellerRating, sellerRating) &&
        other.isAccepted == isAccepted &&
        other.tag == tag &&
        other.requested == requested &&
        other.sel_pro == sel_pro &&
        other.sl_phone == sl_phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        description.hashCode ^
        address.hashCode ^
        totalAmmount.hashCode ^
        total_product_sold.hashCode ^
        total_product.hashCode ^
        comments.hashCode ^
        totalSellerRating.hashCode ^
        sellerRating.hashCode ^
        isAccepted.hashCode ^
        tag.hashCode ^
        requested.hashCode ^
        sel_pro.hashCode ^
        sl_phone.hashCode;
  }
}
