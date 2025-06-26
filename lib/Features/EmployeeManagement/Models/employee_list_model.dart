import 'dart:convert';

class EmployeeListModel {
  int? id;
  String? fullName;
  String? gender;
  String? department;
  String? designation;
  bool? workStatus;
  String? mobNo;
  String? email;
  EmployeeListModel({
    this.id,
    this.fullName,
    this.gender,
    this.department,
    this.designation,
    this.workStatus,
    this.mobNo,
    this.email,
  });
  EmployeeListModel copyWith({
    int? id,
    String? fullName,
    String? gender,
    String? department,
    String? designation,
    bool? workStatus,
    String? mobNo,
    String? email,
  }) {
    return EmployeeListModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      workStatus: workStatus ?? this.workStatus,
      mobNo: mobNo ?? this.mobNo,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'gender': gender,
      'department': department,
      'designation': designation,
      'workStatus': workStatus,
      'mobNo': mobNo,
      'email': email,
    };
  }

  factory EmployeeListModel.fromMap(Map<String, dynamic> json) {
    return EmployeeListModel(
      id: json['id'],
      fullName: json['full_name'],
      gender: json['gender'],
      department: json['department'],
      designation: json['designation'],
      workStatus: json['work_status'],
      mobNo: json['mob_no'],
      email: json['email'],
    );
  }
  String toJson() => json.encode(toMap());
  factory EmployeeListModel.fromJson(String source) =>
      EmployeeListModel.fromMap(json.decode(source));
  @override
  String toString() {
    return 'EmployeeListModel(id: $id, fullName: $fullName, gender: $gender, department: $department, designation: $designation, workStatus: $workStatus, mobNo: $mobNo, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeListModel &&
        other.id == id &&
        other.fullName == fullName &&
        other.gender == gender &&
        other.department == department &&
        other.designation == designation &&
        other.workStatus == workStatus &&
        other.mobNo == mobNo &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        gender.hashCode ^
        department.hashCode ^
        designation.hashCode ^
        workStatus.hashCode ^
        mobNo.hashCode ^
        email.hashCode;
  }
}
