import 'dart:convert';

class LeaveDetailResponseModel {
  final String message;
  final int? leaveDetailId;

  LeaveDetailResponseModel({required this.message, this.leaveDetailId});

  factory LeaveDetailResponseModel.fromJson(String source) {
    final json = jsonDecode(source);
    return LeaveDetailResponseModel(
      message: json["message"],
      leaveDetailId: json["leave_detail_id"],
    );
  }
}
