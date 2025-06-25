import 'dart:convert';

class BaseResponseModel {
  final String? message;
  final String? error;
  BaseResponseModel({this.message, this.error});
  BaseResponseModel copyWith({String? message, String? error}) {
    return BaseResponseModel(
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {'message': message, 'error': error};
  }

  factory BaseResponseModel.fromMap(Map<String, dynamic> map) {
    return BaseResponseModel(message: map['message'], error: map['error']);
  }
  String toJson() => json.encode(toMap());
  factory BaseResponseModel.fromJson(String source) =>
      BaseResponseModel.fromMap(json.decode(source));
  @override
  String toString() => 'BaseResponseModel(message: $message, error: $error)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseResponseModel &&
        other.message == message &&
        other.error == error;
  }

  @override
  int get hashCode => message.hashCode ^ error.hashCode;
}
