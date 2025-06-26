import 'dart:convert';

class SimpleEmployeeModel {
  final int id;
  final String fullName;
  final String gender;
  final String? department;
  final String? designation;
  final bool workStatus;
  final String? mobNo;
  final String? email;

  SimpleEmployeeModel({
    required this.id,
    required this.fullName,
    required this.gender,
    this.department,
    this.designation,
    required this.workStatus,
    this.mobNo,
    this.email,
  });

  factory SimpleEmployeeModel.fromJson(Map<String, dynamic> json) {
    return SimpleEmployeeModel(
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

  static List<SimpleEmployeeModel> listFromJson(String body) {
    final List<dynamic> jsonData = jsonDecode(body);
    return jsonData.map((e) => SimpleEmployeeModel.fromJson(e)).toList();
  }
}
