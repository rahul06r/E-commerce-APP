// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class ProductModel {
  final String pr_id;
  final String pr_name;
  final String description;
  final String sl_id;
  final String sl_name;
  final String sl_photo;
  final List<dynamic> pr_img;
  final String pr_catogory;
  final List<dynamic> review;
  final List<dynamic> pr_questions;
  final double pr_ammount;
  final double discount_Ammount;
  final String brand;
  final double revRatings;
  ProductModel({
    required this.pr_id,
    required this.pr_name,
    required this.description,
    required this.sl_id,
    required this.sl_name,
    required this.sl_photo,
    required this.pr_img,
    required this.pr_catogory,
    required this.review,
    required this.pr_questions,
    required this.pr_ammount,
    required this.discount_Ammount,
    required this.brand,
    required this.revRatings,
  });

  ProductModel copyWith({
    String? pr_id,
    String? pr_name,
    String? description,
    String? sl_id,
    String? sl_name,
    String? sl_photo,
    List<dynamic>? pr_img,
    String? pr_catogory,
    List<dynamic>? review,
    List<dynamic>? pr_questions,
    double? pr_ammount,
    double? discount_Ammount,
    String? brand,
    double? revRatings,
  }) {
    return ProductModel(
      pr_id: pr_id ?? this.pr_id,
      pr_name: pr_name ?? this.pr_name,
      description: description ?? this.description,
      sl_id: sl_id ?? this.sl_id,
      sl_name: sl_name ?? this.sl_name,
      sl_photo: sl_photo ?? this.sl_photo,
      pr_img: pr_img ?? this.pr_img,
      pr_catogory: pr_catogory ?? this.pr_catogory,
      review: review ?? this.review,
      pr_questions: pr_questions ?? this.pr_questions,
      pr_ammount: pr_ammount ?? this.pr_ammount,
      discount_Ammount: discount_Ammount ?? this.discount_Ammount,
      brand: brand ?? this.brand,
      revRatings: revRatings ?? this.revRatings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pr_id': pr_id,
      'pr_name': pr_name,
      'description': description,
      'sl_id': sl_id,
      'sl_name': sl_name,
      'sl_photo': sl_photo,
      'pr_img': pr_img,
      'pr_catogory': pr_catogory,
      'review': review,
      'pr_questions': pr_questions,
      'pr_ammount': pr_ammount,
      'discount_Ammount': discount_Ammount,
      'brand': brand,
      'revRatings': revRatings,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      pr_id: map['pr_id'] as String,
      pr_name: map['pr_name'] as String,
      description: map['description'] as String,
      sl_id: map['sl_id'] as String,
      sl_name: map['sl_name'] as String,
      sl_photo: map['sl_photo'] as String,
      pr_img: List<dynamic>.from((map['pr_img'] as List<dynamic>)),
      pr_catogory: map['pr_catogory'] as String,
      review: List<dynamic>.from((map['review'] as List<dynamic>)),
      pr_questions: List<dynamic>.from((map['pr_questions'] as List<dynamic>)),
      pr_ammount: map['pr_ammount'] as double,
      discount_Ammount: map['discount_Ammount'] as double,
      brand: map['brand'] as String,
      revRatings: map['revRatings'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(pr_id: $pr_id, pr_name: $pr_name, description: $description, sl_id: $sl_id, sl_name: $sl_name, sl_photo: $sl_photo, pr_img: $pr_img, pr_catogory: $pr_catogory, review: $review, pr_questions: $pr_questions, pr_ammount: $pr_ammount, discount_Ammount: $discount_Ammount, brand: $brand, revRatings: $revRatings)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.pr_id == pr_id &&
        other.pr_name == pr_name &&
        other.description == description &&
        other.sl_id == sl_id &&
        other.sl_name == sl_name &&
        other.sl_photo == sl_photo &&
        listEquals(other.pr_img, pr_img) &&
        other.pr_catogory == pr_catogory &&
        listEquals(other.review, review) &&
        listEquals(other.pr_questions, pr_questions) &&
        other.pr_ammount == pr_ammount &&
        other.discount_Ammount == discount_Ammount &&
        other.brand == brand &&
        other.revRatings == revRatings;
  }

  @override
  int get hashCode {
    return pr_id.hashCode ^
        pr_name.hashCode ^
        description.hashCode ^
        sl_id.hashCode ^
        sl_name.hashCode ^
        sl_photo.hashCode ^
        pr_img.hashCode ^
        pr_catogory.hashCode ^
        review.hashCode ^
        pr_questions.hashCode ^
        pr_ammount.hashCode ^
        discount_Ammount.hashCode ^
        brand.hashCode ^
        revRatings.hashCode;
  }
}
