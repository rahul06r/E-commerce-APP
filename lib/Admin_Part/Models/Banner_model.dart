// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class BannerModel {
  final String ban_id;
  final String ad_id;
  final DateTime uploadTime;
  final List<dynamic> ban_images;
  final bool showThis;
  BannerModel({
    required this.ban_id,
    required this.ad_id,
    required this.uploadTime,
    required this.ban_images,
    required this.showThis,
  });

  BannerModel copyWith({
    String? ban_id,
    String? ad_id,
    DateTime? uploadTime,
    List<dynamic>? ban_images,
    bool? showThis,
  }) {
    return BannerModel(
      ban_id: ban_id ?? this.ban_id,
      ad_id: ad_id ?? this.ad_id,
      uploadTime: uploadTime ?? this.uploadTime,
      ban_images: ban_images ?? this.ban_images,
      showThis: showThis ?? this.showThis,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ban_id': ban_id,
      'ad_id': ad_id,
      'uploadTime': uploadTime.millisecondsSinceEpoch,
      'ban_images': ban_images,
      'showThis': showThis,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      ban_id: map['ban_id'] as String,
      ad_id: map['ad_id'] as String,
      uploadTime: DateTime.fromMillisecondsSinceEpoch(map['uploadTime'] as int),
      ban_images: List<dynamic>.from((map['ban_images'] as List<dynamic>)),
      showThis: map['showThis'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BannerModel(ban_id: $ban_id, ad_id: $ad_id, uploadTime: $uploadTime, ban_images: $ban_images, showThis: $showThis)';
  }

  @override
  bool operator ==(covariant BannerModel other) {
    if (identical(this, other)) return true;

    return other.ban_id == ban_id &&
        other.ad_id == ad_id &&
        other.uploadTime == uploadTime &&
        listEquals(other.ban_images, ban_images) &&
        other.showThis == showThis;
  }

  @override
  int get hashCode {
    return ban_id.hashCode ^
        ad_id.hashCode ^
        uploadTime.hashCode ^
        ban_images.hashCode ^
        showThis.hashCode;
  }
}
