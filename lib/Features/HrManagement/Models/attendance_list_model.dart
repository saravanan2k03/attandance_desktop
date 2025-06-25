import 'dart:convert';

import 'package:flutter/foundation.dart';

class AttendanceListModel {
  List<Records>? records;
  AttendanceListModel({this.records});
  AttendanceListModel copyWith({List<Records>? records}) {
    return AttendanceListModel(records: records ?? this.records);
  }

  Map<String, dynamic> toMap() {
    return {'records': records?.map((x) => x.toMap()).toList()};
  }

  factory AttendanceListModel.fromMap(Map<String, dynamic> map) {
    return AttendanceListModel(
      records: List<Records>.from(
        map['records']?.map((x) => Records.fromMap(x)),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory AttendanceListModel.fromJson(String source) =>
      AttendanceListModel.fromMap(json.decode(source));
  @override
  String toString() => 'AttendanceListModel(records: $records)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttendanceListModel && listEquals(other.records, records);
  }

  @override
  int get hashCode => records.hashCode;
}

class Records {
  int? employeeId;
  String? employeeName;
  String? department;
  String? designation;
  String? workshift;
  String? date;
  String? checkIn;
  String? checkOut;
  String? presentOne;
  String? presentTwo;
  double? workHours;
  int? overtimeHours;
  bool? isOvertime;
  Records({
    this.employeeId,
    this.employeeName,
    this.department,
    this.designation,
    this.workshift,
    this.date,
    this.checkIn,
    this.checkOut,
    this.presentOne,
    this.presentTwo,
    this.workHours,
    this.overtimeHours,
    this.isOvertime,
  });
  Records copyWith({
    int? employeeId,
    String? employeeName,
    String? department,
    String? designation,
    String? workshift,
    String? date,
    String? checkIn,
    String? checkOut,
    String? presentOne,
    String? presentTwo,
    double? workHours,
    int? overtimeHours,
    bool? isOvertime,
  }) {
    return Records(
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      workshift: workshift ?? this.workshift,
      date: date ?? this.date,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      presentOne: presentOne ?? this.presentOne,
      presentTwo: presentTwo ?? this.presentTwo,
      workHours: workHours ?? this.workHours,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      isOvertime: isOvertime ?? this.isOvertime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'department': department,
      'designation': designation,
      'workshift': workshift,
      'date': date,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'presentOne': presentOne,
      'presentTwo': presentTwo,
      'workHours': workHours,
      'overtimeHours': overtimeHours,
      'isOvertime': isOvertime,
    };
  }

  factory Records.fromMap(Map<String, dynamic> json) {
    return Records(
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      department: json['department'],
      designation: json['designation'],
      workshift: json['workshift'],
      date: json['date'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      presentOne: json['present_one'],
      presentTwo: json['present_two'],
      workHours: json['work_hours'],
      overtimeHours: json['overtime_hours'],
      isOvertime: json['is_overtime'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Records.fromJson(String source) =>
      Records.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Records(employeeId: $employeeId, employeeName: $employeeName, department: $department, designation: $designation, workshift: $workshift, date: $date, checkIn: $checkIn, checkOut: $checkOut, presentOne: $presentOne, presentTwo: $presentTwo, workHours: $workHours, overtimeHours: $overtimeHours, isOvertime: $isOvertime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Records &&
        other.employeeId == employeeId &&
        other.employeeName == employeeName &&
        other.department == department &&
        other.designation == designation &&
        other.workshift == workshift &&
        other.date == date &&
        other.checkIn == checkIn &&
        other.checkOut == checkOut &&
        other.presentOne == presentOne &&
        other.presentTwo == presentTwo &&
        other.workHours == workHours &&
        other.overtimeHours == overtimeHours &&
        other.isOvertime == isOvertime;
  }

  @override
  int get hashCode {
    return employeeId.hashCode ^
        employeeName.hashCode ^
        department.hashCode ^
        designation.hashCode ^
        workshift.hashCode ^
        date.hashCode ^
        checkIn.hashCode ^
        checkOut.hashCode ^
        presentOne.hashCode ^
        presentTwo.hashCode ^
        workHours.hashCode ^
        overtimeHours.hashCode ^
        isOvertime.hashCode;
  }
}
