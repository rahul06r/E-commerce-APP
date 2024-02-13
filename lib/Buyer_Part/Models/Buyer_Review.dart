// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class BuyerReview {
  final String revID;
  final String prID;
  final String byID;
  final String mainReview;
  final String revDeatils;
  final List<dynamic> revImages;
  final double revratings;
  final String slID;
  final String byName;
  final List<dynamic> revAgree;
  final List<dynamic> revDisAgree;
  final DateTime revUploadDateTime;
  BuyerReview({
    required this.revID,
    required this.prID,
    required this.byID,
    required this.mainReview,
    required this.revDeatils,
    required this.revImages,
    required this.revratings,
    required this.slID,
    required this.byName,
    required this.revAgree,
    required this.revDisAgree,
    required this.revUploadDateTime,
  });

  BuyerReview copyWith({
    String? revID,
    String? prID,
    String? byID,
    String? mainReview,
    String? revDeatils,
    List<dynamic>? revImages,
    double? revratings,
    String? slID,
    String? byName,
    List<dynamic>? revAgree,
    List<dynamic>? revDisAgree,
    DateTime? revUploadDateTime,
  }) {
    return BuyerReview(
      revID: revID ?? this.revID,
      prID: prID ?? this.prID,
      byID: byID ?? this.byID,
      mainReview: mainReview ?? this.mainReview,
      revDeatils: revDeatils ?? this.revDeatils,
      revImages: revImages ?? this.revImages,
      revratings: revratings ?? this.revratings,
      slID: slID ?? this.slID,
      byName: byName ?? this.byName,
      revAgree: revAgree ?? this.revAgree,
      revDisAgree: revDisAgree ?? this.revDisAgree,
      revUploadDateTime: revUploadDateTime ?? this.revUploadDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'revID': revID,
      'prID': prID,
      'byID': byID,
      'mainReview': mainReview,
      'revDeatils': revDeatils,
      'revImages': revImages,
      'revratings': revratings,
      'slID': slID,
      'byName': byName,
      'revAgree': revAgree,
      'revDisAgree': revDisAgree,
      'revUploadDateTime': revUploadDateTime.millisecondsSinceEpoch,
    };
  }

  factory BuyerReview.fromMap(Map<String, dynamic> map) {
    return BuyerReview(
      revID: map['revID'] as String,
      prID: map['prID'] as String,
      byID: map['byID'] as String,
      mainReview: map['mainReview'] as String,
      revDeatils: map['revDeatils'] as String,
      revImages: List<dynamic>.from((map['revImages'] as List<dynamic>)),
      revratings: map['revratings'] as double,
      slID: map['slID'] as String,
      byName: map['byName'] as String,
      revAgree: List<dynamic>.from((map['revAgree'] as List<dynamic>)),
      revDisAgree: List<dynamic>.from((map['revDisAgree'] as List<dynamic>)),
      revUploadDateTime:
          DateTime.fromMillisecondsSinceEpoch(map['revUploadDateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyerReview.fromJson(String source) =>
      BuyerReview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BuyerReview(revID: $revID, prID: $prID, byID: $byID, mainReview: $mainReview, revDeatils: $revDeatils, revImages: $revImages, revratings: $revratings, slID: $slID, byName: $byName, revAgree: $revAgree, revDisAgree: $revDisAgree, revUploadDateTime: $revUploadDateTime)';
  }

  @override
  bool operator ==(covariant BuyerReview other) {
    if (identical(this, other)) return true;

    return other.revID == revID &&
        other.prID == prID &&
        other.byID == byID &&
        other.mainReview == mainReview &&
        other.revDeatils == revDeatils &&
        listEquals(other.revImages, revImages) &&
        other.revratings == revratings &&
        other.slID == slID &&
        other.byName == byName &&
        listEquals(other.revAgree, revAgree) &&
        listEquals(other.revDisAgree, revDisAgree) &&
        other.revUploadDateTime == revUploadDateTime;
  }

  @override
  int get hashCode {
    return revID.hashCode ^
        prID.hashCode ^
        byID.hashCode ^
        mainReview.hashCode ^
        revDeatils.hashCode ^
        revImages.hashCode ^
        revratings.hashCode ^
        slID.hashCode ^
        byName.hashCode ^
        revAgree.hashCode ^
        revDisAgree.hashCode ^
        revUploadDateTime.hashCode;
  }
}
