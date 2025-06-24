// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ModernAddEmployeeScreen extends StatefulWidget {
  final bool isUpdate;
  const ModernAddEmployeeScreen({super.key, this.isUpdate = false});

  @override
  State<ModernAddEmployeeScreen> createState() =>
      _ModernAddEmployeeScreenState();
}

class _ModernAddEmployeeScreenState extends State<ModernAddEmployeeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Sample leave data for table
  List<Map<String, dynamic>> leaveData = [
    {'id': 1, 'leave': 'Annual Leave', 'count': 21},
    {'id': 2, 'leave': 'Sick Leave', 'count': 12},
    {'id': 3, 'leave': 'Maternity Leave', 'count': 90},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildModernAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPersonalDetailsTab(),
                _buildProfessionalDetailsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.blue.shade700),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isUpdate ? 'Update Employee' : 'Add New Employee',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.isUpdate
                ? 'Modify employee information'
                : 'Create a new employee profile',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16),
          child: TextButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _showSuccessDialog();
              }
            },
            icon: Icon(Icons.save_rounded),
            label: Text(widget.isUpdate ? 'Update' : 'Save'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        tabs: [
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline),
                  SizedBox(width: 8),
                  Text('Personal Details'),
                ],
              ),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_outline),
                  SizedBox(width: 8),
                  Text('Professional Details'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildProfileUploadSection(),
            SizedBox(height: 30),
            _buildPersonalDetailsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProfessionalDetailsCard(),
          SizedBox(height: 20),
          _buildLeaveManagementCard(),
        ],
      ),
    );
  }

  Widget _buildProfileUploadSection() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade300, Colors.purple.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Upload Profile Photo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            'Click the camera icon to add photo',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.person_outline, color: Colors.blue.shade600),
              ),
              SizedBox(width: 12),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildModernTextField('First Name', Icons.person),
              _buildModernTextField('Last Name', Icons.person),
              _buildModernTextField('Mobile Number', Icons.phone),
              _buildModernTextField('Date of Birth', Icons.calendar_today),
              _buildModernDropdown('Gender', Icons.wc, [
                'Male',
                'Female',
                'Other',
              ]),
              _buildModernTextField('Email ID', Icons.email),
              _buildModernTextField('Nationality', Icons.flag),
              _buildModernTextField('Iqama Number', Icons.credit_card),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalDetailsCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.work_outline, color: Colors.purple.shade600),
              ),
              SizedBox(width: 12),
              Text(
                'Professional Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildModernTextField('Username', Icons.account_circle),
              _buildModernTextField('Password', Icons.lock, isPassword: true),
              _buildModernDropdown('Department', Icons.business, [
                'IT',
                'HR',
                'Finance',
                'Marketing',
              ]),
              _buildModernDropdown('Designation', Icons.work, [
                'Manager',
                'Developer',
                'Analyst',
                'Executive',
              ]),
              _buildModernTextField('Basic Salary', Icons.attach_money),
              _buildModernDropdown('Work Shift', Icons.schedule, [
                'Day',
                'Night',
                'Flexible',
              ]),
              _buildModernDropdown('User Type', Icons.person_pin, [
                'Admin',
                'Employee',
                'Manager',
              ]),
            ],
          ),
          SizedBox(height: 24),
          _buildGosiSection(),
          SizedBox(height: 24),
          _buildAddressSection(),
        ],
      ),
    );
  }

  Widget _buildGosiSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GOSI Applicable',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Applicable',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'Not Applicable',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 120,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.grey.shade50,
          ),
          child: TextField(
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              hintText: 'Enter complete address...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveManagementCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.event_available,
                      color: Colors.green.shade600,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Leave Management',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _showAddLeaveDialog,
                icon: Icon(Icons.add, size: 20),
                label: Text('Add Leave'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildModernTable(),
        ],
      ),
    );
  }

  Widget _buildModernTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Leave Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Days',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Actions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Table Rows
          ...leaveData.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> item = entry.value;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      item['id'].toString(),
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      item['leave'],
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['count'].toString(),
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _editLeave(index),
                          icon: Icon(Icons.edit, size: 18),
                          color: Colors.orange.shade600,
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          onPressed: () => _deleteLeave(index),
                          icon: Icon(Icons.delete, size: 18),
                          color: Colors.red.shade600,
                          tooltip: 'Delete',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildModernTextField(
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.blue.shade600),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildModernDropdown(String label, IconData icon, List<String> items) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.blue.shade600),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        items:
            items.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
        onChanged: (String? newValue) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  void _showAddLeaveDialog() {
    final TextEditingController leaveTypeController = TextEditingController();
    final TextEditingController daysController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.add_circle, color: Colors.green.shade600),
                SizedBox(width: 8),
                Text('Add Leave Type'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: leaveTypeController,
                  decoration: InputDecoration(
                    labelText: 'Leave Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: daysController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Days',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (leaveTypeController.text.isNotEmpty &&
                      daysController.text.isNotEmpty) {
                    setState(() {
                      leaveData.add({
                        'id': leaveData.length + 1,
                        'leave': leaveTypeController.text,
                        'count': int.parse(daysController.text),
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  void _editLeave(int index) {
    final TextEditingController leaveTypeController = TextEditingController(
      text: leaveData[index]['leave'],
    );
    final TextEditingController daysController = TextEditingController(
      text: leaveData[index]['count'].toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.edit, color: Colors.orange.shade600),
                SizedBox(width: 8),
                Text('Edit Leave Type'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: leaveTypeController,
                  decoration: InputDecoration(
                    labelText: 'Leave Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: daysController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Days',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (leaveTypeController.text.isNotEmpty &&
                      daysController.text.isNotEmpty) {
                    setState(() {
                      leaveData[index] = {
                        'id': leaveData[index]['id'],
                        'leave': leaveTypeController.text,
                        'count': int.parse(daysController.text),
                      };
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Update', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  void _deleteLeave(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.red.shade600),
                SizedBox(width: 8),
                Text('Delete Leave Type'),
              ],
            ),
            content: Text('Are you sure you want to delete this leave type?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    leaveData.removeAt(index);
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green.shade600,
                    size: 48,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  widget.isUpdate ? 'Employee Updated!' : 'Employee Added!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.isUpdate
                      ? 'Employee information has been successfully updated.'
                      : 'New employee has been added to the system.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
