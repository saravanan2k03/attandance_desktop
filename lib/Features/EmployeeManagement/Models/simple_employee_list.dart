import 'dart:convert';

class SimpleEmployeeModel {
  final int id;
  final String fullName;
  final String gender;
  final String? department;
  final String? designation;
  final String? workShift;
  final String? dateOfJoin;
  final bool workStatus;
  final String? mobNo;
  final String? email;

  SimpleEmployeeModel({
    required this.id,
    required this.fullName,
    required this.gender,
    this.department,
    this.designation,
    this.workShift,
    this.dateOfJoin,
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
      workShift: json['work_shift'],
      dateOfJoin: json['date_of_join'],
      workStatus: json['work_status'],
      mobNo: json['mob_no'],
      email: json['email'],
    );
  }

  static List<SimpleEmployeeModel> listFromJson(String body) {
    final List<dynamic> jsonData = jsonDecode(body);
    return jsonData.map((e) => SimpleEmployeeModel.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'EmployeeListModel(id: $id, fullName: $fullName, gender: $gender, department: $department, designation: $designation, workShift: $workShift, dateOfJoin: $dateOfJoin, workStatus: $workStatus, mobNo: $mobNo, email: $email)';
  }
}
