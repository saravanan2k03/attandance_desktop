import 'dart:convert';

import 'package:flutter/foundation.dart';

class HolidayListModel {
  List<Leaves>? leaves;
  HolidayListModel({this.leaves});
  HolidayListModel copyWith({List<Leaves>? leaves}) {
    return HolidayListModel(leaves: leaves ?? this.leaves);
  }

  Map<String, dynamic> toMap() {
    return {'leaves': leaves?.map((x) => x.toMap()).toList()};
  }

  factory HolidayListModel.fromMap(Map<String, dynamic> map) {
    return HolidayListModel(
      leaves: List<Leaves>.from(map['leaves']?.map((x) => Leaves.fromMap(x))),
    );
  }
  String toJson() => json.encode(toMap());
  factory HolidayListModel.fromJson(String source) =>
      HolidayListModel.fromMap(json.decode(source));
  @override
  String toString() => 'HolidayListModel(leaves: $leaves)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HolidayListModel && listEquals(other.leaves, leaves);
  }

  @override
  int get hashCode => leaves.hashCode;
}

class Leaves {
  int? id;
  String? leaveName;
  String? leaveDate;
  bool? isActive;
  Leaves({this.id, this.leaveName, this.leaveDate, this.isActive});
  Leaves copyWith({
    int? id,
    String? leaveName,
    String? leaveDate,
    bool? isActive,
  }) {
    return Leaves(
      id: id ?? this.id,
      leaveName: leaveName ?? this.leaveName,
      leaveDate: leaveDate ?? this.leaveDate,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'leaveName': leaveName,
      'leaveDate': leaveDate,
      'isActive': isActive,
    };
  }

  factory Leaves.fromMap(Map<String, dynamic> map) {
    return Leaves(
      id: map['id'],
      leaveName: map['leave_name'],
      leaveDate: map['leave_date'],
      isActive: map['is_active'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Leaves.fromJson(String source) => Leaves.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Leaves(id: $id, leaveName: $leaveName, leaveDate: $leaveDate, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Leaves &&
        other.id == id &&
        other.leaveName == leaveName &&
        other.leaveDate == leaveDate &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        leaveName.hashCode ^
        leaveDate.hashCode ^
        isActive.hashCode;
  }
}
