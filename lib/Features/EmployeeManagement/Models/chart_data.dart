import 'dart:convert';
import 'package:flutter/material.dart';

class ChartData {
  String? code;
  String? title;
  double? value;
  Color? color;
  ChartData({this.code, this.title, this.value, this.color});

  ChartData copyWith({
    String? code,
    String? title,
    double? value,
    Color? color,
  }) {
    return ChartData(
      code: code ?? this.code,
      title: title ?? this.title,
      value: value ?? this.value,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'title': title,
      'value': value,
      'color': color,
    };
  }

  factory ChartData.fromMap(Map<String, dynamic> map) {
    return ChartData(
      code: map['code'] != null ? map['code'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      value: map['value'] != null ? map['value'] as double : null,
      color: map['color'] != null ? Color(map['color'] as dynamic) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartData.fromJson(String source) =>
      ChartData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChartData(code: $code, title: $title, value: $value, color: $color)';
  }

  @override
  bool operator ==(covariant ChartData other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.title == title &&
        other.value == value &&
        other.color == color;
  }

  @override
  int get hashCode {
    return code.hashCode ^ title.hashCode ^ value.hashCode ^ color.hashCode;
  }
}
