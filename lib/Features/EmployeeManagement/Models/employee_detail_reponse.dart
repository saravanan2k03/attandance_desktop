class EmployeeDetailResponse {
  final String message;
  final EmployeeData data;

  EmployeeDetailResponse({required this.message, required this.data});

  factory EmployeeDetailResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailResponse(
      message: json["message"],
      data: EmployeeData.fromJson(json["data"]),
    );
  }
}

class EmployeeData {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? fingerPrintCode;
  final int departmentId;
  final String departmentName;
  final int designationId;
  final String designationName;
  final String dateOfBirth;
  final String gender;
  final String nationality;
  final String iqamaNumber;
  final String mobNo;
  final String address;
  final String joiningDate;
  final bool workStatus;
  final double basicSalary;
  final bool gosiApplicable;
  final double gosiDeductionAmount;
  final String filename;
  final String? workshift;
  final double overTimeSalary;
  final String userType;
  final String? profilePic;
  final List<LeaveDetail> leaveDetails;

  EmployeeData({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.fingerPrintCode,
    required this.departmentId,
    required this.departmentName,
    required this.designationId,
    required this.designationName,
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.iqamaNumber,
    required this.mobNo,
    required this.address,
    required this.joiningDate,
    required this.workStatus,
    required this.basicSalary,
    required this.gosiApplicable,
    required this.gosiDeductionAmount,
    required this.filename,
    required this.workshift,
    required this.overTimeSalary,
    required this.userType,
    required this.profilePic,
    required this.leaveDetails,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      fingerPrintCode: json["finger_print_code"],
      departmentId: json["department_id"],
      departmentName: json["department_name"],
      designationId: json["designation_id"],
      designationName: json["designation_name"],
      dateOfBirth: json["date_of_birth"],
      gender: json["gender"],
      nationality: json["nationality"],
      iqamaNumber: json["iqama_number"],
      mobNo: json["mob_no"],
      address: json["address"],
      joiningDate: json["joining_date"],
      workStatus: json["work_status"],
      basicSalary: (json["basic_salary"] as num).toDouble(),
      gosiApplicable: json["gosi_applicable"],
      gosiDeductionAmount: (json["gosi_deduction_amount"] as num).toDouble(),
      filename: json["filename"],
      workshift: json["workshift"],
      overTimeSalary: (json["over_time_salary"] as num).toDouble(),
      userType: json["user_type"],
      profilePic: json["profile_pic"],
      leaveDetails:
          (json["leave_details"] as List)
              .map((e) => LeaveDetail.fromJson(e))
              .toList(),
    );
  }
}

class LeaveDetail {
  final String leaveType;
  final int leaveCount;

  LeaveDetail({required this.leaveType, required this.leaveCount});

  factory LeaveDetail.fromJson(Map<String, dynamic> json) {
    return LeaveDetail(
      leaveType: json["leave_type"],
      leaveCount: json["leave_count"],
    );
  }
}
