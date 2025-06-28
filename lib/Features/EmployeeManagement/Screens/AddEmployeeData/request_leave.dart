import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _licenseKeyController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _leaveTypeIdController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  int _availableLeaveDays = 0;
  bool _isLoading = false;

  // Mock leave types - replace with actual API call to get leave types
  final Map<String, String> _leaveTypes = {
    '1': 'Annual Leave',
    '2': 'Sick Leave',
    '3': 'Maternity Leave',
    '4': 'Paternity Leave',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request Leave'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _licenseKeyController,
                decoration: InputDecoration(
                  labelText: 'License Key',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.vpn_key),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter license key';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _employeeIdController,
                decoration: InputDecoration(
                  labelText: 'Employee ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your employee ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Leave Type',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.list),
                ),
                value:
                    _leaveTypeIdController.text.isEmpty
                        ? null
                        : _leaveTypeIdController.text,
                items:
                    _leaveTypes.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _leaveTypeIdController.text = value!;
                    // Here you would typically fetch the available leave days for this type
                    _availableLeaveDays =
                        10; // Mock value - replace with actual API call
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a leave type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, isStartDate: true),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _startDate == null
                              ? 'Select start date'
                              : DateFormat('yyyy-MM-dd').format(_startDate!),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, isStartDate: false),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _endDate == null
                              ? 'Select end date'
                              : DateFormat('yyyy-MM-dd').format(_endDate!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              if (_startDate != null && _endDate != null)
                Text(
                  'Total Leave Days: ${_calculateLeaveDays()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 8),
              if (_availableLeaveDays > 0)
                Text(
                  'Available: $_availableLeaveDays days',
                  style: TextStyle(fontSize: 14, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 16),
              TextFormField(
                controller: _remarksController,
                decoration: InputDecoration(
                  labelText: 'Remarks (Optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 24),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: _submitLeaveRequest,
                    child: Text('Submit Leave Request'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context, {
    required bool isStartDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          // Reset end date if it's before start date
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  int _calculateLeaveDays() {
    if (_startDate == null || _endDate == null) return 0;
    return _endDate!.difference(_startDate!).inDays + 1;
  }

  Future<void> _submitLeaveRequest() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both start and end dates')),
      );
      return;
    }

    final leaveDays = _calculateLeaveDays();
    if (leaveDays > _availableLeaveDays) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Insufficient leave balance')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('YOUR_API_URL_HERE'), // Replace with your actual API URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "license_key": _licenseKeyController.text,
          "employee_id": _employeeIdController.text,
          "leave_type_id": _leaveTypeIdController.text,
          "start_date": DateFormat('yyyy-MM-dd').format(_startDate!),
          "end_date": DateFormat('yyyy-MM-dd').format(_endDate!),
          "remarks": _remarksController.text,
        }),
      );

      final responseData = json.decode(response.body);
      setState(() => _isLoading = false);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Leave request submitted successfully')),
        );
        // Clear the form
        _formKey.currentState!.reset();
        setState(() {
          _startDate = null;
          _endDate = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              responseData['message'] ?? 'Error submitting leave request',
            ),
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    _licenseKeyController.dispose();
    _employeeIdController.dispose();
    _leaveTypeIdController.dispose();
    _remarksController.dispose();
    super.dispose();
  }
}
