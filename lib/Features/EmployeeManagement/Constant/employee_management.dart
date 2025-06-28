import 'dart:io';

import 'package:act/Features/EmployeeManagement/Bloc/bloc/employee_bloc.dart';
import 'package:flutter/material.dart';

bool employeeDashboardvar = true;
bool employeeInformationvar = true;
bool leaveRequestvar = true;
File? pickedImage;
bool gosiApplicable = false;
List<Map<String, dynamic>> leaveData = [];
TextEditingController searchController = TextEditingController();
EmployeeBloc employeeBloc = EmployeeBloc();
