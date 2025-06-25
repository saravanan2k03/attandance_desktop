import 'dart:convert';

import 'package:flutter/foundation.dart';

class DesingantionListModel {
  List<Designations>? designations;
  DesingantionListModel({this.designations});
  DesingantionListModel copyWith({List<Designations>? designations}) {
    return DesingantionListModel(
      designations: designations ?? this.designations,
    );
  }

  Map<String, dynamic> toMap() {
    return {'designations': designations?.map((x) => x.toMap()).toList()};
  }

  factory DesingantionListModel.fromMap(Map<String, dynamic> map) {
    return DesingantionListModel(
      designations: List<Designations>.from(
        map['designations']?.map((x) => Designations.fromMap(x)),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory DesingantionListModel.fromJson(String source) =>
      DesingantionListModel.fromMap(json.decode(source));
  @override
  String toString() => 'DesingantionListModel(designations: $designations)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DesingantionListModel &&
        listEquals(other.designations, designations);
  }

  @override
  int get hashCode => designations.hashCode;
}

class Designations {
  int? id;
  String? designationName;

  Designations({this.id, this.designationName});
  Designations copyWith({int? id, String? designationName}) {
    return Designations(
      id: id ?? this.id,
      designationName: designationName ?? this.designationName,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'designation_name': designationName};
  }

  factory Designations.fromMap(Map<String, dynamic> map) {
    return Designations(
      id: map['id'],
      designationName: map['designation_name'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Designations.fromJson(String source) =>
      Designations.fromMap(json.decode(source));
  @override
  String toString() =>
      'Designations(id: $id, designation_name: $designationName)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Designations &&
        other.id == id &&
        other.designationName == designationName;
  }

  @override
  int get hashCode => id.hashCode ^ designationName.hashCode;
}
