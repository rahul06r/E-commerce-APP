// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class BuyerModel {
  final String by_id;
  final String by_name;
  final String by_email;
  final String by_password;
  final String by_pro;
  final String by_type;
  final int by_phone;
  final List<dynamic> by_add_to_cart;
  final List<dynamic> by_bought;
  final List<dynamic> by_whithlist;
  final List<dynamic> by_review;
  final String by_address;
  BuyerModel({
    required this.by_id,
    required this.by_name,
    required this.by_email,
    required this.by_password,
    required this.by_pro,
    required this.by_type,
    required this.by_phone,
    required this.by_add_to_cart,
    required this.by_bought,
    required this.by_whithlist,
    required this.by_review,
    required this.by_address,
  });

  BuyerModel copyWith({
    String? by_id,
    String? by_name,
    String? by_email,
    String? by_password,
    String? by_pro,
    String? by_type,
    int? by_phone,
    List<dynamic>? by_add_to_cart,
    List<dynamic>? by_bought,
    List<dynamic>? by_whithlist,
    List<dynamic>? by_review,
    String? by_address,
  }) {
    return BuyerModel(
      by_id: by_id ?? this.by_id,
      by_name: by_name ?? this.by_name,
      by_email: by_email ?? this.by_email,
      by_password: by_password ?? this.by_password,
      by_pro: by_pro ?? this.by_pro,
      by_type: by_type ?? this.by_type,
      by_phone: by_phone ?? this.by_phone,
      by_add_to_cart: by_add_to_cart ?? this.by_add_to_cart,
      by_bought: by_bought ?? this.by_bought,
      by_whithlist: by_whithlist ?? this.by_whithlist,
      by_review: by_review ?? this.by_review,
      by_address: by_address ?? this.by_address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'by_id': by_id,
      'by_name': by_name,
      'by_email': by_email,
      'by_password': by_password,
      'by_pro': by_pro,
      'by_type': by_type,
      'by_phone': by_phone,
      'by_add_to_cart': by_add_to_cart,
      'by_bought': by_bought,
      'by_whithlist': by_whithlist,
      'by_review': by_review,
      'by_address': by_address,
    };
  }

  factory BuyerModel.fromMap(Map<String, dynamic> map) {
    return BuyerModel(
      by_id: map['by_id'] as String,
      by_name: map['by_name'] as String,
      by_email: map['by_email'] as String,
      by_password: map['by_password'] as String,
      by_pro: map['by_pro'] as String,
      by_type: map['by_type'] as String,
      by_phone: map['by_phone'] as int,
      by_add_to_cart:
          List<dynamic>.from((map['by_add_to_cart'] as List<dynamic>)),
      by_bought: List<dynamic>.from((map['by_bought'] as List<dynamic>)),
      by_whithlist: List<dynamic>.from((map['by_whithlist'] as List<dynamic>)),
      by_review: List<dynamic>.from((map['by_review'] as List<dynamic>)),
      by_address: map['by_address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyerModel.fromJson(String source) =>
      BuyerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BuyerModel(by_id: $by_id, by_name: $by_name, by_email: $by_email, by_password: $by_password, by_pro: $by_pro, by_type: $by_type, by_phone: $by_phone, by_add_to_cart: $by_add_to_cart, by_bought: $by_bought, by_whithlist: $by_whithlist, by_review: $by_review, by_address: $by_address)';
  }

  @override
  bool operator ==(covariant BuyerModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.by_id == by_id &&
        other.by_name == by_name &&
        other.by_email == by_email &&
        other.by_password == by_password &&
        other.by_pro == by_pro &&
        other.by_type == by_type &&
        other.by_phone == by_phone &&
        listEquals(other.by_add_to_cart, by_add_to_cart) &&
        listEquals(other.by_bought, by_bought) &&
        listEquals(other.by_whithlist, by_whithlist) &&
        listEquals(other.by_review, by_review) &&
        other.by_address == by_address;
  }

  @override
  int get hashCode {
    return by_id.hashCode ^
        by_name.hashCode ^
        by_email.hashCode ^
        by_password.hashCode ^
        by_pro.hashCode ^
        by_type.hashCode ^
        by_phone.hashCode ^
        by_add_to_cart.hashCode ^
        by_bought.hashCode ^
        by_whithlist.hashCode ^
        by_review.hashCode ^
        by_address.hashCode;
  }
}
