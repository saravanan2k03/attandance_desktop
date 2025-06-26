import 'dart:convert';

import 'package:flutter/foundation.dart';

class DepartmentListModel {
  List<Departments>? departments;
  DepartmentListModel({this.departments});
  DepartmentListModel copyWith({List<Departments>? departments}) {
    return DepartmentListModel(departments: departments ?? this.departments);
  }

  Map<String, dynamic> toMap() {
    return {'departments': departments?.map((x) => x.toMap()).toList()};
  }

  factory DepartmentListModel.fromMap(Map<String, dynamic> map) {
    return DepartmentListModel(
      departments:
          map['departments'] != null
              ? List<Departments>.from(
                map['departments'].map((x) => Departments.fromMap(x)),
              )
              : [],
    );
  }
  String toJson() => json.encode(toMap());
  factory DepartmentListModel.fromJson(String source) =>
      DepartmentListModel.fromMap(json.decode(source));
  @override
  String toString() => 'DepartmentListModel(departments: $departments)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepartmentListModel &&
        listEquals(other.departments, departments);
  }

  @override
  int get hashCode => departments.hashCode;
}

class Departments {
  int? id;
  String? departmentName;
  bool? isActive;
  Departments({this.id, this.departmentName, this.isActive});
  Departments copyWith({int? id, String? departmentName, bool? isActive}) {
    return Departments(
      id: id ?? this.id,
      departmentName: departmentName ?? this.departmentName,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'departmentName': departmentName, 'isActive': isActive};
  }

  factory Departments.fromMap(Map<String, dynamic> json) {
    return Departments(
      id: json['id'],
      departmentName: json['department_name'],
      isActive: json['is_active'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Departments.fromJson(String source) =>
      Departments.fromMap(json.decode(source));
  @override
  String toString() =>
      'Departments(id: $id, departmentName: $departmentName, isActive: $isActive)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Departments &&
        other.id == id &&
        other.departmentName == departmentName &&
        other.isActive == isActive;
  }

  @override
  int get hashCode => id.hashCode ^ departmentName.hashCode ^ isActive.hashCode;
}
