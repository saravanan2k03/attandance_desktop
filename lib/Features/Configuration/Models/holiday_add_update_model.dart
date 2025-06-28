class HolidayResponseModel {
  final String message;
  final int? leaveId;
  final String? leaveName;
  final String? leaveDate;

  HolidayResponseModel({
    required this.message,
    this.leaveId,
    this.leaveName,
    this.leaveDate,
  });

  factory HolidayResponseModel.fromJson(Map<String, dynamic> json) {
    return HolidayResponseModel(
      message: json["message"] ?? "",
      leaveId: json["leave_id"],
      leaveName: json["leave_name"],
      leaveDate: json["leave_date"],
    );
  }
}
