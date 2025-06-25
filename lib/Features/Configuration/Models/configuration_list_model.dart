import 'dart:convert';
import 'package:flutter/foundation.dart';

class ConfigurationListModel {
  List<Configurations>? configurations;
  ConfigurationListModel({this.configurations});
  ConfigurationListModel copyWith({List<Configurations>? configurations}) {
    return ConfigurationListModel(
      configurations: configurations ?? this.configurations,
    );
  }

  Map<String, dynamic> toMap() {
    return {'configurations': configurations?.map((x) => x.toMap()).toList()};
  }

  factory ConfigurationListModel.fromMap(Map<String, dynamic> map) {
    return ConfigurationListModel(
      configurations: List<Configurations>.from(
        map['configurations']?.map((x) => Configurations.fromMap(x)),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory ConfigurationListModel.fromJson(String source) =>
      ConfigurationListModel.fromMap(json.decode(source));
  @override
  String toString() =>
      'ConfigurationListModel(configurations: $configurations)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigurationListModel &&
        listEquals(other.configurations, configurations);
  }

  @override
  int get hashCode => configurations.hashCode;
}

class Configurations {
  int? id;
  String? workshift;
  String? punchInStartTime;
  String? punchInEndTime;
  String? punchInStartLateTime;
  String? punchInEndLateTime;
  String? punchOutStartTime;
  String? punchOutEndTime;
  String? overTimeWorkingEndTime;
  Configurations({
    this.id,
    this.workshift,
    this.punchInStartTime,
    this.punchInEndTime,
    this.punchInStartLateTime,
    this.punchInEndLateTime,
    this.punchOutStartTime,
    this.punchOutEndTime,
    this.overTimeWorkingEndTime,
  });
  Configurations copyWith({
    int? id,
    String? workshift,
    String? punchInStartTime,
    String? punchInEndTime,
    String? punchInStartLateTime,
    String? punchInEndLateTime,
    String? punchOutStartTime,
    String? punchOutEndTime,
    String? overTimeWorkingEndTime,
  }) {
    return Configurations(
      id: id ?? this.id,
      workshift: workshift ?? this.workshift,
      punchInStartTime: punchInStartTime ?? this.punchInStartTime,
      punchInEndTime: punchInEndTime ?? this.punchInEndTime,
      punchInStartLateTime: punchInStartLateTime ?? this.punchInStartLateTime,
      punchInEndLateTime: punchInEndLateTime ?? this.punchInEndLateTime,
      punchOutStartTime: punchOutStartTime ?? this.punchOutStartTime,
      punchOutEndTime: punchOutEndTime ?? this.punchOutEndTime,
      overTimeWorkingEndTime:
          overTimeWorkingEndTime ?? this.overTimeWorkingEndTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workshift': workshift,
      'punchInStartTime': punchInStartTime,
      'punchInEndTime': punchInEndTime,
      'punchInStartLateTime': punchInStartLateTime,
      'punchInEndLateTime': punchInEndLateTime,
      'punchOutStartTime': punchOutStartTime,
      'punchOutEndTime': punchOutEndTime,
      'overTimeWorkingEndTime': overTimeWorkingEndTime,
    };
  }

  factory Configurations.fromMap(Map<String, dynamic> json) {
    return Configurations(
      id: json['id'],
      workshift: json['workshift'],
      punchInStartTime: json['punch_in_start_time'],
      punchInEndTime: json['punch_in_end_time'],
      punchInStartLateTime: json['punch_in_start_late_time'],
      punchInEndLateTime: json['punch_in_end_late_time'],
      punchOutStartTime: json['punch_out_start_time'],
      punchOutEndTime: json['punch_out_end_time'],
      overTimeWorkingEndTime: json['over_time_working_end_time'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Configurations.fromJson(String source) =>
      Configurations.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Configurations(id: $id, workshift: $workshift, punchInStartTime: $punchInStartTime, punchInEndTime: $punchInEndTime, punchInStartLateTime: $punchInStartLateTime, punchInEndLateTime: $punchInEndLateTime, punchOutStartTime: $punchOutStartTime, punchOutEndTime: $punchOutEndTime, overTimeWorkingEndTime: $overTimeWorkingEndTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Configurations &&
        other.id == id &&
        other.workshift == workshift &&
        other.punchInStartTime == punchInStartTime &&
        other.punchInEndTime == punchInEndTime &&
        other.punchInStartLateTime == punchInStartLateTime &&
        other.punchInEndLateTime == punchInEndLateTime &&
        other.punchOutStartTime == punchOutStartTime &&
        other.punchOutEndTime == punchOutEndTime &&
        other.overTimeWorkingEndTime == overTimeWorkingEndTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        workshift.hashCode ^
        punchInStartTime.hashCode ^
        punchInEndTime.hashCode ^
        punchInStartLateTime.hashCode ^
        punchInEndLateTime.hashCode ^
        punchOutStartTime.hashCode ^
        punchOutEndTime.hashCode ^
        overTimeWorkingEndTime.hashCode;
  }
}
