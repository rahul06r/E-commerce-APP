import 'dart:convert';

class OrderPlacingModel {
  final String orID;
  final String byID;
  final String slID;
  final String prID;
  final int or_Quantity;
  final double total_ammount;
  final double or_price;
  final String byName;
  final String byAddress;
  final String slName;
  final String slAddress;
  final String byNumber;
  final String prImageOne;
  final String prName;

  OrderPlacingModel({
    required this.orID,
    required this.byID,
    required this.slID,
    required this.prID,
    required this.or_Quantity,
    required this.total_ammount,
    required this.or_price,
    required this.byName,
    required this.byAddress,
    required this.slName,
    required this.slAddress,
    required this.byNumber,
    required this.prImageOne,
    required this.prName,
  });

  OrderPlacingModel copyWith({
    String? orID,
    String? byID,
    String? slID,
    String? prID,
    int? or_Quantity,
    double? total_ammount,
    double? or_price,
    String? byName,
    String? byAddress,
    String? slName,
    String? slAddress,
    String? byNumber,
    String? prImageOne,
    String? prName,
  }) {
    return OrderPlacingModel(
      orID: orID ?? this.orID,
      byID: byID ?? this.byID,
      slID: slID ?? this.slID,
      prID: prID ?? this.prID,
      or_Quantity: or_Quantity ?? this.or_Quantity,
      total_ammount: total_ammount ?? this.total_ammount,
      or_price: or_price ?? this.or_price,
      byName: byName ?? this.byName,
      byAddress: byAddress ?? this.byAddress,
      slName: slName ?? this.slName,
      slAddress: slAddress ?? this.slAddress,
      byNumber: byNumber ?? this.byNumber,
      prImageOne: prImageOne ?? this.prImageOne,
      prName: prName ?? this.prName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orID': orID,
      'byID': byID,
      'slID': slID,
      'prID': prID,
      'or_Quantity': or_Quantity,
      'total_ammount': total_ammount,
      'or_price': or_price,
      'byName': byName,
      'byAddress': byAddress,
      'slName': slName,
      'slAddress': slAddress,
      'byNumber': byNumber,
      'prImageOne': prImageOne,
      'prName': prName,
    };
  }

  factory OrderPlacingModel.fromMap(Map<String, dynamic> map) {
    return OrderPlacingModel(
      orID: map['orID'] as String,
      byID: map['byID'] as String,
      slID: map['slID'] as String,
      prID: map['prID'] as String,
      or_Quantity: map['or_Quantity'] as int,
      total_ammount: map['total_ammount'] as double,
      or_price: map['or_price'] as double,
      byName: map['byName'] as String,
      byAddress: map['byAddress'] as String,
      slName: map['slName'] as String,
      slAddress: map['slAddress'] as String,
      byNumber: map['byNumber'] as String,
      prImageOne: map['prImageOne'] as String,
      prName: map['prName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderPlacingModel.fromJson(String source) =>
      OrderPlacingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderPlacingModel(orID: $orID, byID: $byID, slID: $slID, prID: $prID, or_Quantity: $or_Quantity, total_ammount: $total_ammount, or_price: $or_price, byName: $byName, byAddress: $byAddress, slName: $slName, slAddress: $slAddress, byNumber: $byNumber, prImageOne: $prImageOne, prName: $prName)';
  }

  @override
  bool operator ==(covariant OrderPlacingModel other) {
    if (identical(this, other)) return true;

    return other.orID == orID &&
        other.byID == byID &&
        other.slID == slID &&
        other.prID == prID &&
        other.or_Quantity == or_Quantity &&
        other.total_ammount == total_ammount &&
        other.or_price == or_price &&
        other.byName == byName &&
        other.byAddress == byAddress &&
        other.slName == slName &&
        other.slAddress == slAddress &&
        other.byNumber == byNumber &&
        other.prImageOne == prImageOne &&
        other.prName == prName;
  }

  @override
  int get hashCode {
    return orID.hashCode ^
        byID.hashCode ^
        slID.hashCode ^
        prID.hashCode ^
        or_Quantity.hashCode ^
        total_ammount.hashCode ^
        or_price.hashCode ^
        byName.hashCode ^
        byAddress.hashCode ^
        slName.hashCode ^
        slAddress.hashCode ^
        byNumber.hashCode ^
        prImageOne.hashCode ^
        prName.hashCode;
  }
}
