import 'dart:developer';
import 'dart:io';

import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Core/Utils/urls.dart';
import 'package:act/Features/EmployeeManagement/Bloc/bloc/employee_bloc.dart';
import 'package:act/Features/EmployeeManagement/Constant/employee_management.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_detail_reponse.dart';
import 'package:act/Features/EmployeeManagement/Repository/employee_repo.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/employee_personal_details.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/employee_profile_details.dart';
import 'package:act/Features/EmployeeManagement/employee_management.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddEmployeeData extends StatefulWidget {
  final int? employeeId;
  const AddEmployeeData({super.key, this.employeeId});

  @override
  State<AddEmployeeData> createState() => _AddEmployeeDataState();
}

class _AddEmployeeDataState extends State<AddEmployeeData> {
  // Employee Personal Details
  String? url;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  final ValueNotifier<String?> genderController = ValueNotifier<String?>(null);
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController iqamaNumberController = TextEditingController();
  final TextEditingController fingerprintcode = TextEditingController();

  // Employee Profile Details
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<String?> departmentController = ValueNotifier<String?>(
    null,
  );
  final ValueNotifier<String?> designationController = ValueNotifier<String?>(
    null,
  );
  final TextEditingController basicSalaryController = TextEditingController();
  final TextEditingController overTimeSalaryController =
      TextEditingController();
  final TextEditingController gosiDeductionController = TextEditingController();
  final ValueNotifier<String?> workShiftController = ValueNotifier<String?>(
    null,
  );
  final ValueNotifier<String?> userTypeController = ValueNotifier<String?>(
    null,
  );
  final TextEditingController addressController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  final EmployeeBloc employeeBloc = EmployeeBloc();
  @override
  void initState() {
    if (widget.employeeId != null) {
      employeeBloc.add(EmployeeDetail(employeeId: widget.employeeId!));
    }

    super.initState();
  }

  void clearEmployeeFormFields() {
    // Clear TextEditingControllers
    firstNameController.clear();
    lastNameController.clear();
    mobileNoController.clear();
    dateOfBirthController.clear();
    joiningDateController.clear();
    emailIdController.clear();
    nationalityController.clear();
    iqamaNumberController.clear();
    userNameController.clear();
    passwordController.clear();
    basicSalaryController.clear();
    overTimeSalaryController.clear();
    gosiDeductionController.clear();
    addressController.clear();
    leaveData = [];
    // Reset ValueNotifiers
    genderController.value = null;
    departmentController.value = null;
    designationController.value = null;
    workShiftController.value = null;
    userTypeController.value = null;

    // Reset any optional image/file variables if used
    url = null;
    pickedImage = null; // if you're using a picked image file
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNoController.dispose();
    dateOfBirthController.dispose();
    joiningDateController.dispose();
    emailIdController.dispose();
    nationalityController.dispose();
    iqamaNumberController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    basicSalaryController.dispose();
    overTimeSalaryController.dispose();
    gosiDeductionController.dispose();
    addressController.dispose();

    genderController.dispose();
    departmentController.dispose();
    designationController.dispose();
    workShiftController.dispose();
    userTypeController.dispose();

    super.dispose();
  }

  void setEmployeeFormFieldsFromModel(EmployeeData employee) {
    // Set all TextEditingController values
    firstNameController.text = employee.firstName;
    lastNameController.text = employee.lastName;
    mobileNoController.text = employee.mobNo;
    dateOfBirthController.text = employee.dateOfBirth;
    joiningDateController.text = employee.joiningDate;
    emailIdController.text = employee.email;
    nationalityController.text = employee.nationality;
    iqamaNumberController.text = employee.iqamaNumber;
    userNameController.text = employee.username;
    passwordController.clear(); // Keep password input blank for security
    basicSalaryController.text = employee.basicSalary.toString();
    overTimeSalaryController.text = employee.overTimeSalary.toString();
    gosiDeductionController.text = employee.gosiDeductionAmount.toString();
    addressController.text = employee.address;
    fingerprintcode.text = employee.fingerPrintCode ?? '';
    gosiApplicable = employee.gosiApplicable;
    // Set all ValueNotifier values
    genderController.value = employee.gender;
    departmentController.value = employee.departmentId.toString();
    designationController.value = employee.designationId.toString();
    workShiftController.value = employee.workshift;
    userTypeController.value = employee.userType;
    log("department:${employee.departmentName.toString()}");
    // Set optional image URL (for profile preview)
    url = employee.profilePic;

    // Set leave data
    leaveData =
        employee.leaveDetails
            .map(
              (e) => {"leave_type": e.leaveType, "leave_count": e.leaveCount},
            )
            .toList();
  }

  bool validateForm({String? employeeId}) {
    String errorMessage = '';

    if (firstNameController.text.trim().isEmpty) {
      errorMessage += 'First Name is required\n';
    }
    if (lastNameController.text.trim().isEmpty) {
      errorMessage += 'Last Name is required\n';
    }
    if (emailIdController.text.trim().isEmpty) {
      errorMessage += 'Email is required\n';
    }
    if (dateOfBirthController.text.trim().isEmpty) {
      errorMessage += 'Date of Birth is required\n';
    }
    if (genderController.value == null) errorMessage += 'Gender is required\n';
    if (nationalityController.text.trim().isEmpty) {
      errorMessage += 'Nationality is required\n';
    }
    if (iqamaNumberController.text.trim().isEmpty) {
      errorMessage += 'Iqama Number is required\n';
    }
    if (mobileNoController.text.trim().isEmpty) {
      errorMessage += 'Mobile Number is required\n';
    }
    if (joiningDateController.text.trim().isEmpty) {
      errorMessage += 'Joining Date is required\n';
    }
    if (basicSalaryController.text.trim().isEmpty) {
      errorMessage += 'Basic Salary is required\n';
    }
    if (departmentController.value == null) {
      errorMessage += 'Department is required\n';
    }
    if (designationController.value == null) {
      errorMessage += 'Designation is required\n';
    }
    if (addressController.text.trim().isEmpty) {
      errorMessage += 'Address is required\n';
    }
    if (fingerprintcode.text.trim().isEmpty) {
      errorMessage += 'Fingerprint Code is required\n';
    }

    // Only validate username and password for new employees
    if (employeeId == null) {
      if (userNameController.text.trim().isEmpty) {
        errorMessage += 'Username is required\n';
      }
      if (passwordController.text.trim().isEmpty) {
        errorMessage += 'Password is required\n';
      }
    }

    if (errorMessage.isNotEmpty) {
      log(errorMessage);
      return false;
    }
    return true;
  }

  Future<void> submitEmployeeForm({String? employeeId}) async {
    if (!validateForm(employeeId: employeeId)) return;

    final EmployeeRepo employeeRepo = EmployeeRepo();
    try {
      log("Designation${designationController.value.toString()}");
      final session = SessionManagerClass();
      var licencekey = await session.getlicence();
      final response = await employeeRepo.addOrUpdateEmployee(
        licenseKey: licencekey,
        email: emailIdController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        dateOfBirth: dateOfBirthController.text.trim(),
        gender: genderController.value ?? '',
        nationality: nationalityController.text.trim(),
        iqamaNumber: iqamaNumberController.text.trim(),
        mobNo: mobileNoController.text.trim(),
        joiningDate: joiningDateController.text.trim(),
        workStatus: 'true',
        workshift: workShiftController.value ?? "Morning",
        basicSalary: basicSalaryController.text.trim(),
        gosiApplicable: gosiApplicable,
        departmentId: departmentController.value ?? '',
        designationId: designationController.value ?? '',
        leaveDetails: leaveData,
        filename: 'default.pdf',
        address: addressController.text.trim(),
        fingerPrintCode: fingerprintcode.text.trim(),

        // Optional
        username: employeeId == null ? userNameController.text.trim() : null,
        password: employeeId == null ? passwordController.text.trim() : null,
        employeeId: employeeId,
        gosiDeductionAmount:
            gosiDeductionController.text.trim().isNotEmpty
                ? gosiDeductionController.text.trim()
                : null,
        overTimeSalary:
            overTimeSalaryController.text.trim().isNotEmpty
                ? overTimeSalaryController.text.trim()
                : null,
        profilePic: pickedImage != null ? XFile(pickedImage!.path) : null,
      );

      // Handle success
      if (response.message == "Employee and leave details added successfully" ||
          response.message ==
              "Employee and leave details updated successfully") {
        toasterService.displaySuccessMotionToast(
          content: Text("Employee and leave details updated successfully"),
          // ignore: use_build_context_synchronously
          context: context,
        );
        clearEmployeeFormFields();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EmployeeManagement()),
        );
      } else {
        toasterService.displayWarningMotionToast(context, "Fail!");
      }
    } catch (e) {
      toasterService.displayErrorMotionToast(
        context: context,
        content: Text(e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomDrawer(employeeManagement: true, addEmployee: true),
          ),
          Expanded(
            flex: 12,
            child: Column(
              children: [
                CustomAppbar(),
                Expanded(
                  child: Container(
                    color: cardsColors,
                    child: Column(
                      children: [
                        SizedBox(
                          width: calcSize(context).longestSide,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppText.small(
                                    "Employee Management",
                                    fontSize: 18,
                                  ),
                                  07.sp.width,
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  07.sp.width,
                                  AppText.small("Add Employee", fontSize: 18),
                                ],
                              ),
                              AppText.medium("Add Employee", fontSize: 18),
                              07.sp.width,
                            ],
                          ),
                        ),
                        15.height,
                        Expanded(
                          child: Container(
                            height: calcSize(context).longestSide,
                            width: calcSize(context).longestSide,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: BlocConsumer<EmployeeBloc, EmployeeState>(
                              bloc: employeeBloc,
                              listener: (context, state) {
                                if (state is EmployeeDetailErrorState) {
                                  toasterService.displayErrorMotionToast(
                                    context: context,
                                    content: Text(state.e),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is EmployeeDetailLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state is EmployeeDetailDataState) {
                                  setEmployeeFormFieldsFromModel(
                                    state.modelData.data,
                                  );
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.height,
                                      ProfileUpload(url: url),
                                      15.height,
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              EmployeePersonalDetails(
                                                dateOfBirthController:
                                                    dateOfBirthController,
                                                emailIdController:
                                                    emailIdController,
                                                firstNameController:
                                                    firstNameController,
                                                genderController:
                                                    genderController,
                                                iqamaNumberController:
                                                    iqamaNumberController,
                                                joiningDateController:
                                                    joiningDateController,
                                                lastNameController:
                                                    lastNameController,
                                                mobileNoController:
                                                    mobileNoController,
                                                nationalityController:
                                                    nationalityController,
                                              ),
                                              10.height,
                                              EmployeeProfileDetails(
                                                fingerprintcode:
                                                    fingerprintcode,
                                                basicSalaryController:
                                                    basicSalaryController,
                                                departmentController:
                                                    departmentController,
                                                designationController:
                                                    designationController,
                                                gosiDeductionController:
                                                    gosiDeductionController,
                                                passwordController:
                                                    passwordController,
                                                userNameController:
                                                    userNameController,
                                                userTypeController:
                                                    userTypeController,
                                                workShiftController:
                                                    workShiftController,
                                                addressController:
                                                    addressController,
                                                overTimeSalaryController:
                                                    overTimeSalaryController,
                                              ),
                                              10.height,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        clearEmployeeFormFields();
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 17.sp,
                                                      width: 30.sp,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              07.sp,
                                                            ),
                                                      ),
                                                      child: Center(
                                                        child: AppText.small(
                                                          "Clear",
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  10.width,
                                                  InkWell(
                                                    onTap: () {
                                                      submitEmployeeForm(
                                                        employeeId:
                                                            state
                                                                .modelData
                                                                .data
                                                                .id
                                                                .toString(),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 17.sp,
                                                      width: 30.sp,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.amberAccent,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              07.sp,
                                                            ),
                                                      ),
                                                      child: Center(
                                                        child: AppText.small(
                                                          "Submit",
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.height,
                                      ProfileUpload(url: url),
                                      15.height,
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              EmployeePersonalDetails(
                                                dateOfBirthController:
                                                    dateOfBirthController,
                                                emailIdController:
                                                    emailIdController,
                                                firstNameController:
                                                    firstNameController,
                                                genderController:
                                                    genderController,
                                                iqamaNumberController:
                                                    iqamaNumberController,
                                                joiningDateController:
                                                    joiningDateController,
                                                lastNameController:
                                                    lastNameController,
                                                mobileNoController:
                                                    mobileNoController,
                                                nationalityController:
                                                    nationalityController,
                                              ),
                                              10.height,
                                              EmployeeProfileDetails(
                                                fingerprintcode:
                                                    fingerprintcode,
                                                basicSalaryController:
                                                    basicSalaryController,
                                                departmentController:
                                                    departmentController,
                                                designationController:
                                                    designationController,
                                                gosiDeductionController:
                                                    gosiDeductionController,
                                                passwordController:
                                                    passwordController,
                                                userNameController:
                                                    userNameController,
                                                userTypeController:
                                                    userTypeController,
                                                workShiftController:
                                                    workShiftController,
                                                addressController:
                                                    addressController,
                                                overTimeSalaryController:
                                                    overTimeSalaryController,
                                              ),
                                              10.height,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  const AddEmployeeData(),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 17.sp,
                                                      width: 30.sp,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              07.sp,
                                                            ),
                                                      ),
                                                      child: Center(
                                                        child: AppText.small(
                                                          "Clear",
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  10.width,
                                                  InkWell(
                                                    onTap: () {
                                                      submitEmployeeForm();
                                                    },
                                                    child: Container(
                                                      height: 17.sp,
                                                      width: 30.sp,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.amberAccent,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              07.sp,
                                                            ),
                                                      ),
                                                      child: Center(
                                                        child: AppText.small(
                                                          "Submit",
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ).withPadding(padding: EdgeInsets.all(10.sp)),
                          ),
                        ),
                      ],
                    ).withPadding(padding: EdgeInsets.all(10.sp)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileUpload extends StatefulWidget {
  final String? url;
  const ProfileUpload({super.key, this.url});

  @override
  State<ProfileUpload> createState() => _ProfileUploadState();
}

class _ProfileUploadState extends State<ProfileUpload> {
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });

      if (kDebugMode) {
        print('Image Path: ${image.path}');
      }
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Widget _buildAvatar() {
    if (pickedImage != null) {
      return CircleAvatar(radius: 70, backgroundImage: FileImage(pickedImage!));
    } else if (widget.url != null && widget.url!.isNotEmpty) {
      final fullUrl =
          "${ApiConstants.baseUrl.substring(0, ApiConstants.baseUrl.length - 4)}${widget.url}";
      return CircleAvatar(radius: 70, backgroundImage: NetworkImage(fullUrl));
    } else {
      return const CircleAvatar(
        radius: 70,
        child: Icon(Icons.person, size: 60),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            _buildAvatar(),
            Positioned(
              bottom: 2,
              right: 2,
              child: GestureDetector(
                onTap: _pickImage,
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                  child: Icon(Icons.camera_alt_rounded, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
