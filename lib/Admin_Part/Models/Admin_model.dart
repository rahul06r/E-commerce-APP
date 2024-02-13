// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminModel {
  final String ad_id;
  final String ad_name;
  final String ad_pro;
  final String ad_role;
  final String ad_email;
  final String ad_password;
  AdminModel({
    required this.ad_id,
    required this.ad_name,
    required this.ad_pro,
    required this.ad_role,
    required this.ad_email,
    required this.ad_password,
  });

  AdminModel copyWith({
    String? ad_id,
    String? ad_name,
    String? ad_pro,
    String? ad_role,
    String? ad_email,
    String? ad_password,
  }) {
    return AdminModel(
      ad_id: ad_id ?? this.ad_id,
      ad_name: ad_name ?? this.ad_name,
      ad_pro: ad_pro ?? this.ad_pro,
      ad_role: ad_role ?? this.ad_role,
      ad_email: ad_email ?? this.ad_email,
      ad_password: ad_password ?? this.ad_password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ad_id': ad_id,
      'ad_name': ad_name,
      'ad_pro': ad_pro,
      'ad_role': ad_role,
      'ad_email': ad_email,
      'ad_password': ad_password,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      ad_id: map['ad_id'] as String,
      ad_name: map['ad_name'] as String,
      ad_pro: map['ad_pro'] as String,
      ad_role: map['ad_role'] as String,
      ad_email: map['ad_email'] as String,
      ad_password: map['ad_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminModel(ad_id: $ad_id, ad_name: $ad_name, ad_pro: $ad_pro, ad_role: $ad_role, ad_email: $ad_email, ad_password: $ad_password)';
  }

  @override
  bool operator ==(covariant AdminModel other) {
    if (identical(this, other)) return true;

    return other.ad_id == ad_id &&
        other.ad_name == ad_name &&
        other.ad_pro == ad_pro &&
        other.ad_role == ad_role &&
        other.ad_email == ad_email &&
        other.ad_password == ad_password;
  }

  @override
  int get hashCode {
    return ad_id.hashCode ^
        ad_name.hashCode ^
        ad_pro.hashCode ^
        ad_role.hashCode ^
        ad_email.hashCode ^
        ad_password.hashCode;
  }
}
