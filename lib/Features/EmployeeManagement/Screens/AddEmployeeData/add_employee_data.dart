import 'dart:io';

import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/employee_personal_details.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/employee_profile_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddEmployeeData extends StatefulWidget {
  const AddEmployeeData({super.key});

  @override
  State<AddEmployeeData> createState() => _AddEmployeeDataState();
}

class _AddEmployeeDataState extends State<AddEmployeeData> {
  // Employee Personal Details
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  final ValueNotifier<String?> genderController = ValueNotifier<String?>(null);
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController iqamaNumberController = TextEditingController();

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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.height,
                                const ProfileUpload(),
                                15.height,
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        EmployeePersonalDetails(
                                          dateOfBirthController:
                                              dateOfBirthController,
                                          emailIdController: emailIdController,
                                          firstNameController:
                                              firstNameController,
                                          genderController: genderController,
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
                                          basicSalaryController:
                                              basicSalaryController,
                                          departmentController:
                                              departmentController,
                                          designationController:
                                              departmentController,
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
                                          addressController: addressController,
                                        ),
                                        10.height,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
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
                                            10.width,
                                            Container(
                                              height: 17.sp,
                                              width: 30.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.amberAccent,
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
  const ProfileUpload({super.key});

  @override
  State<ProfileUpload> createState() => _ProfileUploadState();
}

class _ProfileUploadState extends State<ProfileUpload> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });

      print('Image Path: ${image.path}');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage:
                  _pickedImage != null ? FileImage(_pickedImage!) : null,
              child:
                  _pickedImage == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
            ),
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
