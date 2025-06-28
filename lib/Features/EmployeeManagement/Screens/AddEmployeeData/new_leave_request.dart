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
  const LeaveRequestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        children: [RequestLeaveForm(), MyLeaveRequests()],
      ),
    );
  }
}

// Request Leave Form
class RequestLeaveForm extends StatefulWidget {
  @override
  _RequestLeaveFormState createState() => _RequestLeaveFormState();
}

class _RequestLeaveFormState extends State<RequestLeaveForm> {
  final _formKey = GlobalKey<FormState>();
  final _remarksController = TextEditingController();

  // These would be passed as constructor parameters in real app
  final String licenseKey = "your_license_key";
  final String employeeId = "your_employee_id";

  LeaveType? selectedLeaveType;
  DateTime? startDate;
  DateTime? endDate;
  bool isLoading = false;

  // Mock data - replace with API call
  final List<LeaveType> leaveTypes = [
    LeaveType(id: 1, name: 'Annual Leave'),
    LeaveType(id: 2, name: 'Sick Leave'),
    LeaveType(id: 3, name: 'Personal Leave'),
    LeaveType(id: 4, name: 'Emergency Leave'),
  ];

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
      lastDate: DateTime.now().add(Duration(days: 365)),
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

    setState(() {
      isLoading = true;
    });

    // try {
    //   final response = await http.post(
    //     Uri.parse('YOUR_API_ENDPOINT/request-leave/'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: json.encode({
    //       'license_key': licenseKey,
    //       'employee_id': employeeId,
    //       'leave_type_id': selectedLeaveType!.id,
    //       'start_date': startDate!.toIso8601String().split('T')[0],
    //       'end_date': endDate!.toIso8601String().split('T')[0],
    //       'remarks': _remarksController.text,
    //     }),
    //   );

    //   final responseData = json.decode(response.body);

    //   if (response.statusCode == 201) {
    //     _showSuccessDialog(responseData['message']);
    //     _resetForm();
    //   } else {
    //     _showErrorDialog(responseData['message']);
    //   }
    // } catch (e) {
    //   _showErrorDialog('Network error. Please try again.');
    // } finally {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
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
            title: Row(
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
                child: Text('OK'),
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
            title: Row(
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
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leave Type Selection
            _buildSectionTitle('Leave Type'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                value: selectedLeaveType,
                items:
                    leaveTypes.map((leaveType) {
                      return DropdownMenuItem(
                        value: leaveType,
                        child: Text(leaveType.name),
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

            SizedBox(height: 24),

            // Date Selection
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
                SizedBox(width: 16),
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
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
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
                    SizedBox(width: 12),
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

            SizedBox(height: 24),

            // Remarks
            _buildSectionTitle('Remarks (Optional)'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
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
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),

            SizedBox(height: 32),

            // Submit Button
            Container(
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
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
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
      padding: EdgeInsets.only(bottom: 8),
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
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
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                SizedBox(width: 8),
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

// My Leave Requests Screen
class MyLeaveRequests extends StatefulWidget {
  @override
  _MyLeaveRequestsState createState() => _MyLeaveRequestsState();
}

class _MyLeaveRequestsState extends State<MyLeaveRequests> {
  List<LeaveRequest> leaveRequests = [
    // Mock data - replace with API call
    LeaveRequest(
      leaveType: 'Annual Leave',
      startDate: '2025-07-01',
      endDate: '2025-07-05',
      days: 5,
      status: 'Pending',
      remarks: 'Family vacation',
    ),
    LeaveRequest(
      leaveType: 'Sick Leave',
      startDate: '2025-06-15',
      endDate: '2025-06-16',
      days: 2,
      status: 'Approved',
      remarks: 'Medical appointment',
    ),
    LeaveRequest(
      leaveType: 'Personal Leave',
      startDate: '2025-05-20',
      endDate: '2025-05-20',
      days: 1,
      status: 'Rejected',
      remarks: 'Personal work',
    ),
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      case 'pending':
        return Icons.access_time;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Requests',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child:
                leaveRequests.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      itemCount: leaveRequests.length,
                      itemBuilder: (context, index) {
                        return _buildLeaveRequestCard(leaveRequests[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'No leave requests yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your submitted requests will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveRequestCard(LeaveRequest request) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.leaveType,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(request.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(request.status),
                      size: 16,
                      color: _getStatusColor(request.status),
                    ),
                    SizedBox(width: 4),
                    Text(
                      request.status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(request.status),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  Icons.calendar_today,
                  'Start Date',
                  _formatDate(request.startDate),
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  Icons.event,
                  'End Date',
                  _formatDate(request.endDate),
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  Icons.access_time,
                  'Days',
                  '${request.days}',
                ),
              ),
            ],
          ),
          if (request.remarks.isNotEmpty) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remarks',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    request.remarks,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day}/${date.month}/${date.year}';
  }
}
