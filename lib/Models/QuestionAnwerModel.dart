// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuestionAnwerModel {
  final String qID;
  final String by_ID;
  final String sl_ID;
  final String pr_ID;
  final String by_question;
  final String sl_reply;
  final List<dynamic> liked;
  final List<dynamic> disliked;
  final DateTime questionedTime;
  QuestionAnwerModel({
    required this.qID,
    required this.by_ID,
    required this.sl_ID,
    required this.pr_ID,
    required this.by_question,
    required this.sl_reply,
    required this.liked,
    required this.disliked,
    required this.questionedTime,
  });

  QuestionAnwerModel copyWith({
    String? qID,
    String? by_ID,
    String? sl_ID,
    String? pr_ID,
    String? by_question,
    String? sl_reply,
    List<dynamic>? liked,
    List<dynamic>? disliked,
    DateTime? questionedTime,
  }) {
    return QuestionAnwerModel(
      qID: qID ?? this.qID,
      by_ID: by_ID ?? this.by_ID,
      sl_ID: sl_ID ?? this.sl_ID,
      pr_ID: pr_ID ?? this.pr_ID,
      by_question: by_question ?? this.by_question,
      sl_reply: sl_reply ?? this.sl_reply,
      liked: liked ?? this.liked,
      disliked: disliked ?? this.disliked,
      questionedTime: questionedTime ?? this.questionedTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qID': qID,
      'by_ID': by_ID,
      'sl_ID': sl_ID,
      'pr_ID': pr_ID,
      'by_question': by_question,
      'sl_reply': sl_reply,
      'liked': liked,
      'disliked': disliked,
      'questionedTime': questionedTime.millisecondsSinceEpoch,
    };
  }

  factory QuestionAnwerModel.fromMap(Map<String, dynamic> map) {
    return QuestionAnwerModel(
      qID: map['qID'] as String,
      by_ID: map['by_ID'] as String,
      sl_ID: map['sl_ID'] as String,
      pr_ID: map['pr_ID'] as String,
      by_question: map['by_question'] as String,
      sl_reply: map['sl_reply'] as String,
      liked: List<dynamic>.from((map['liked'] as List<dynamic>)),
      disliked: List<dynamic>.from((map['disliked'] as List<dynamic>)),
      questionedTime:
          DateTime.fromMillisecondsSinceEpoch(map['questionedTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionAnwerModel.fromJson(String source) =>
      QuestionAnwerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionAnwerModel(qID: $qID, by_ID: $by_ID, sl_ID: $sl_ID, pr_ID: $pr_ID, by_question: $by_question, sl_reply: $sl_reply, liked: $liked, disliked: $disliked, questionedTime: $questionedTime)';
  }

  @override
  bool operator ==(covariant QuestionAnwerModel other) {
    if (identical(this, other)) return true;

    return other.qID == qID &&
        other.by_ID == by_ID &&
        other.sl_ID == sl_ID &&
        other.pr_ID == pr_ID &&
        other.by_question == by_question &&
        other.sl_reply == sl_reply &&
        listEquals(other.liked, liked) &&
        listEquals(other.disliked, disliked) &&
        other.questionedTime == questionedTime;
  }

  @override
  int get hashCode {
    return qID.hashCode ^
        by_ID.hashCode ^
        sl_ID.hashCode ^
        pr_ID.hashCode ^
        by_question.hashCode ^
        sl_reply.hashCode ^
        liked.hashCode ^
        disliked.hashCode ^
        questionedTime.hashCode;
  }
}
