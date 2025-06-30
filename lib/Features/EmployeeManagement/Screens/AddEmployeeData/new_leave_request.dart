import 'package:act/Core/Services/hive_services.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/Auth/Repository/auth_repo.dart';
import 'package:act/Features/EmployeeManagement/Models/employee_leave_detail_model.dart';
import 'package:act/Features/EmployeeManagement/Repository/employee_repo.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/my_leave_request_ui.dart';
import 'package:act/main.dart';
import 'package:flutter/material.dart';

class LeaveType {
  final int id;
  final String name;

  LeaveType({required this.id, required this.name});
}

class LeaveRequest {
  final String leaveType;
  final String startDate;
  final String endDate;
  final int days;
  final String status;
  final String remarks;

  LeaveRequest({
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.status,
    required this.remarks,
  });
}

// Main Screen with TabBar
class LeaveRequestScreen extends StatefulWidget {
  final int userId;

  const LeaveRequestScreen({super.key, required this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final session = SessionManagerClass();
  var licenseKey = "";
  @override
  void initState() {
    getlicence();
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  EmployeeLeaveDetailResponse? modelData;

  void getlicence() async {
    licenseKey = await session.getlicence();
  }

  final EmployeeRepo employeeRepo = EmployeeRepo();
  void submitLeave() async {
    try {
      final response = await employeeRepo
          .requestLeave(
            leaveType: "SICK",
            startDate: "2025-07-01",
            endDate: "2025-07-03",
            remarks: "Fever and rest",
            employeeId: 12, // optional
          )
          .whenComplete(() {});
    } catch (e) {
      print("❌ Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Leave Management',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            final AuthRepo authRepo = AuthRepo();
            final HiveServices hiveServices = HiveServices();
            authRepo.logoutapi().whenComplete(() {
              hiveServices.deleteallData().then((value) {
                MyApp.navigatorKey.currentState?.pushReplacementNamed('/login');
              });
            });
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue[600],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.blue[600],
          indicatorWeight: 3,
          tabs: [
            Tab(icon: Icon(Icons.add_circle_outline), text: 'Request Leave'),
            Tab(icon: Icon(Icons.list_alt), text: 'My Requests'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RequestLeaveForm(licenceKey: licenseKey, userId: widget.userId),
          MyLeaveRequests(
            employeeUserId: widget.userId,
            licenseKey: licenseKey,
          ),
        ],
      ),
    );
  }
}

// Request Leave Form
// Request Leave Form
class RequestLeaveForm extends StatefulWidget {
  final String licenceKey;
  final int userId;

  const RequestLeaveForm({
    super.key,
    required this.licenceKey,
    required this.userId,
  });

  @override
  _RequestLeaveFormState createState() => _RequestLeaveFormState();
}

class _RequestLeaveFormState extends State<RequestLeaveForm> {
  final _formKey = GlobalKey<FormState>();
  final _remarksController = TextEditingController();
  final EmployeeRepo _employeeRepo = EmployeeRepo();
  EmployeeLeaveDetailResponse? modelData;
  String licenseKey = "";
  LeaveType? selectedLeaveType;
  DateTime? startDate;
  DateTime? endDate;
  bool isLoading = false;
  bool isDataLoading = false;
  List<LeaveType> leaveTypes = [];

  @override
  void initState() {
    super.initState();
    licenseKey = widget.licenceKey;
    _loadLeaveData();
  }

  Future<void> _loadLeaveData() async {
    setState(() => isDataLoading = true);
    try {
      modelData = await _employeeRepo.getEmployeeLeaveDetailByUserIds(
        widget.userId,
      );
      setState(() {
        leaveTypes =
            modelData!.data.leaveDetails.map((detail) {
              return LeaveType(
                id: 0, // Replace with actual ID if available
                name: detail.leaveType,
              );
            }).toList();
      });
    } catch (e) {
      debugPrint('Error loading leave data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load leave data')),
      );
    } finally {
      setState(() => isDataLoading = false);
    }
  }

  int get calculatedDays {
    if (startDate != null && endDate != null) {
      return endDate!.difference(startDate!).inDays + 1;
    }
    return 0;
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[600]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(picked)) {
            endDate = null;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> _submitLeaveRequest() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedLeaveType == null || startDate == null || endDate == null) {
      _showErrorDialog('Please fill all required fields');
      return;
    }

    // Validate available leave days
    final leaveDetail = modelData!.data.leaveDetails.firstWhere(
      (detail) => detail.leaveType == selectedLeaveType!.name,
    );

    if (calculatedDays > leaveDetail.leaveCount) {
      _showErrorDialog(
        'You only have ${leaveDetail.leaveCount} days available for ${selectedLeaveType!.name}',
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await _employeeRepo.requestLeave(
        leaveType: selectedLeaveType!.name,
        startDate: _formatDateForApi(startDate!),
        endDate: _formatDateForApi(endDate!),
        remarks: _remarksController.text,
        employeeId: widget.userId,
      );

      if (response != null) {
        _showSuccessDialog('Leave request submitted successfully');
        _loadLeaveData();
        _resetForm();
      } else {
        _showErrorDialog('Failed to submit leave request');
      }
    } catch (e) {
      _showErrorDialog('Error: ${e.toString()}');
    } finally {
      setState(() => isLoading = false);
    }
  }

  String _formatDateForApi(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void _resetForm() {
    setState(() {
      selectedLeaveType = null;
      startDate = null;
      endDate = null;
      _remarksController.clear();
    });
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 12),
                Text('Success'),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red, size: 28),
                SizedBox(width: 12),
                Text('Error'),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child:
            isDataLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Leave Type'),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<LeaveType>(
                        decoration: InputDecoration(
                          hintText: 'Select leave type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        value: selectedLeaveType,
                        items:
                            leaveTypes.map((leaveType) {
                              final leaveDetail = modelData!.data.leaveDetails
                                  .firstWhere(
                                    (detail) =>
                                        detail.leaveType == leaveType.name,
                                  );

                              return DropdownMenuItem(
                                value: leaveType,
                                child: Row(
                                  children: [
                                    Text(leaveType.name),
                                    const SizedBox(width: 8),
                                    Text(
                                      '(${leaveDetail.leaveCount} days left)',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLeaveType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a leave type';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildSectionTitle('Duration'),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateField(
                            'Start Date',
                            startDate,
                            () => _selectDate(context, true),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDateField(
                            'End Date',
                            endDate,
                            () => _selectDate(context, false),
                          ),
                        ),
                      ],
                    ),

                    if (calculatedDays > 0) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.blue[600],
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Total Days: $calculatedDays',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[700],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    _buildSectionTitle('Remarks (Optional)'),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _remarksController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Add any additional information...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submitLeaveRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child:
                            isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text(
                                  'Submit Request',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  date != null
                      ? '${date.day}/${date.month}/${date.year}'
                      : 'Select date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: date != null ? Colors.black87 : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
