import 'dart:convert';

class HolidayAddorUpdateModel {
  String? message;
  HolidayAddorUpdateModel({this.message});
  HolidayAddorUpdateModel copyWith({String? message}) {
    return HolidayAddorUpdateModel(message: message ?? this.message);
  }

  Map<String, dynamic> toMap() {
    return {'message': message};
  }

  factory HolidayAddorUpdateModel.fromMap(Map<String, dynamic> map) {
    return HolidayAddorUpdateModel(message: map['message']);
  }
  String toJson() => json.encode(toMap());
  factory HolidayAddorUpdateModel.fromJson(String source) =>
      HolidayAddorUpdateModel.fromMap(json.decode(source));
  @override
  String toString() => 'HolidayAddorUpdateModel(message: $message)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HolidayAddorUpdateModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
