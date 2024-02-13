// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

// SellerAcceptanceModel
class SellerAcceptanceModel {
  final String sl_id;
  final String sl_name;
  final String sl_email;
  final String sl_description;
  final int sl_phoneNo;
  final String sl_photo;
  final String sl_address;
  final List<dynamic> sl_tags;
  final bool accpet;
  SellerAcceptanceModel({
    required this.sl_id,
    required this.sl_name,
    required this.sl_email,
    required this.sl_description,
    required this.sl_phoneNo,
    required this.sl_photo,
    required this.sl_address,
    required this.sl_tags,
    required this.accpet,
  });

  SellerAcceptanceModel copyWith({
    String? sl_id,
    String? sl_name,
    String? sl_email,
    String? sl_description,
    int? sl_phoneNo,
    String? sl_photo,
    String? sl_address,
    List<dynamic>? sl_tags,
    bool? accpet,
  }) {
    return SellerAcceptanceModel(
      sl_id: sl_id ?? this.sl_id,
      sl_name: sl_name ?? this.sl_name,
      sl_email: sl_email ?? this.sl_email,
      sl_description: sl_description ?? this.sl_description,
      sl_phoneNo: sl_phoneNo ?? this.sl_phoneNo,
      sl_photo: sl_photo ?? this.sl_photo,
      sl_address: sl_address ?? this.sl_address,
      sl_tags: sl_tags ?? this.sl_tags,
      accpet: accpet ?? this.accpet,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sl_id': sl_id,
      'sl_name': sl_name,
      'sl_email': sl_email,
      'sl_description': sl_description,
      'sl_phoneNo': sl_phoneNo,
      'sl_photo': sl_photo,
      'sl_address': sl_address,
      'sl_tags': sl_tags,
      'accpet': accpet,
    };
  }

  factory SellerAcceptanceModel.fromMap(Map<String, dynamic> map) {
    return SellerAcceptanceModel(
      sl_id: map['sl_id'] as String,
      sl_name: map['sl_name'] as String,
      sl_email: map['sl_email'] as String,
      sl_description: map['sl_description'] as String,
      sl_phoneNo: map['sl_phoneNo'] as int,
      sl_photo: map['sl_photo'] as String,
      sl_address: map['sl_address'] as String,
      sl_tags: List<dynamic>.from((map['sl_tags'] as List<dynamic>)),
      accpet: map['accpet'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerAcceptanceModel.fromJson(String source) =>
      SellerAcceptanceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SellerAcceptanceModel(sl_id: $sl_id, sl_name: $sl_name, sl_email: $sl_email, sl_description: $sl_description, sl_phoneNo: $sl_phoneNo, sl_photo: $sl_photo, sl_address: $sl_address, sl_tags: $sl_tags, accpet: $accpet)';
  }

  @override
  bool operator ==(covariant SellerAcceptanceModel other) {
    if (identical(this, other)) return true;

    return other.sl_id == sl_id &&
        other.sl_name == sl_name &&
        other.sl_email == sl_email &&
        other.sl_description == sl_description &&
        other.sl_phoneNo == sl_phoneNo &&
        other.sl_photo == sl_photo &&
        other.sl_address == sl_address &&
        listEquals(other.sl_tags, sl_tags) &&
        other.accpet == accpet;
  }

  @override
  int get hashCode {
    return sl_id.hashCode ^
        sl_name.hashCode ^
        sl_email.hashCode ^
        sl_description.hashCode ^
        sl_phoneNo.hashCode ^
        sl_photo.hashCode ^
        sl_address.hashCode ^
        sl_tags.hashCode ^
        accpet.hashCode;
  }
}
