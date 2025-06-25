import 'dart:convert';

import 'package:flutter/foundation.dart';

class LeaveTypeListModel {
  List<LeaveTypes>? leaveTypes;
  LeaveTypeListModel({this.leaveTypes});
  LeaveTypeListModel copyWith({List<LeaveTypes>? leaveTypes}) {
    return LeaveTypeListModel(leaveTypes: leaveTypes ?? this.leaveTypes);
  }

  Map<String, dynamic> toMap() {
    return {'leaveTypes': leaveTypes?.map((x) => x.toMap()).toList()};
  }

  factory LeaveTypeListModel.fromMap(Map<String, dynamic> map) {
    return LeaveTypeListModel(
      leaveTypes: List<LeaveTypes>.from(
        map['leave_types']?.map((x) => LeaveTypes.fromMap(x)),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory LeaveTypeListModel.fromJson(String source) =>
      LeaveTypeListModel.fromMap(json.decode(source));
  @override
  String toString() => 'LeaveTypeListModel(leaveTypes: $leaveTypes)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LeaveTypeListModel &&
        listEquals(other.leaveTypes, leaveTypes);
  }

  @override
  int get hashCode => leaveTypes.hashCode;
}

class LeaveTypes {
  int? id;
  String? leaveType;
  bool? isActive;
  LeaveTypes({this.id, this.leaveType, this.isActive});
  LeaveTypes copyWith({int? id, String? leaveType, bool? isActive}) {
    return LeaveTypes(
      id: id ?? this.id,
      leaveType: leaveType ?? this.leaveType,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'leaveType': leaveType, 'isActive': isActive};
  }

  factory LeaveTypes.fromMap(Map<String, dynamic> map) {
    return LeaveTypes(
      id: map['id'],
      leaveType: map['leave_type'],
      isActive: map['is_active'],
    );
  }
  String toJson() => json.encode(toMap());
  factory LeaveTypes.fromJson(String source) =>
      LeaveTypes.fromMap(json.decode(source));
  @override
  String toString() =>
      'LeaveTypes(id: $id, leaveType: $leaveType, isActive: $isActive)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LeaveTypes &&
        other.id == id &&
        other.leaveType == leaveType &&
        other.isActive == isActive;
  }

  @override
  int get hashCode => id.hashCode ^ leaveType.hashCode ^ isActive.hashCode;
}
