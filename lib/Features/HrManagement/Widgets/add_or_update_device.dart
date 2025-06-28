import 'package:act/Features/EmployeeManagement/Models/base_response.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DeviceDialog extends StatefulWidget {
  final String licenseKey;
  final int? deviceId; // null for add, has value for update
  final String? initialDeviceName;
  final String? initialDeviceIp;
  final String? initialLastSyncInterval;
  final Future<BaseResponseModel> Function({
    required String licenseKey,
    int? deviceId,
    required String deviceName,
    required String deviceIp,
    String? lastSyncInterval,
  })
  onSubmit;

  const DeviceDialog({
    Key? key,
    required this.licenseKey,
    this.deviceId,
    this.initialDeviceName,
    this.initialDeviceIp,
    this.initialLastSyncInterval,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<DeviceDialog> createState() => _DeviceDialogState();
}

class _DeviceDialogState extends State<DeviceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _deviceNameController = TextEditingController();
  final _deviceIpController = TextEditingController();
  final _lastSyncIntervalController = TextEditingController();
  bool _isLoading = false;

  bool get isUpdateMode => widget.deviceId != null;

  @override
  void initState() {
    super.initState();
    // Pre-fill form for update mode
    if (isUpdateMode) {
      _deviceNameController.text = widget.initialDeviceName ?? '';
      _deviceIpController.text = widget.initialDeviceIp ?? '';
      _lastSyncIntervalController.text = widget.initialLastSyncInterval ?? '';
    }
  }

  @override
  void dispose() {
    _deviceNameController.dispose();
    _deviceIpController.dispose();
    _lastSyncIntervalController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await widget.onSubmit(
        licenseKey: widget.licenseKey,
        deviceId: widget.deviceId,
        deviceName: _deviceNameController.text.trim(),
        deviceIp: _deviceIpController.text.trim(),
        lastSyncInterval:
            _lastSyncIntervalController.text.trim().isEmpty
                ? null
                : _lastSyncIntervalController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pop(response);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isUpdateMode
                  ? 'Device updated successfully!'
                  : 'Device added successfully!',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _validateDeviceName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Device name is required';
    }
    if (value.trim().length < 2) {
      return 'Device name must be at least 2 characters';
    }
    return null;
  }

  String? _validateDeviceIp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Device IP is required';
    }

    // Basic IP validation
    final ipRegex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');
    if (!ipRegex.hasMatch(value.trim())) {
      return 'Please enter a valid IP address';
    }

    // Check if each octet is valid (0-255)
    final octets = value.trim().split('.');
    for (String octet in octets) {
      final num = int.tryParse(octet);
      if (num == null || num < 0 || num > 255) {
        return 'Please enter a valid IP address';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            isUpdateMode ? Icons.edit : Icons.add,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(isUpdateMode ? 'Update Device' : 'Add New Device'),
        ],
      ),
      content: SizedBox(
        width: 50.sp,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isUpdateMode) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Device ID: ${widget.deviceId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _deviceNameController,
                decoration: const InputDecoration(
                  labelText: 'Device Name *',
                  hintText: 'Enter device name',
                  prefixIcon: Icon(Icons.device_hub),
                  border: OutlineInputBorder(),
                ),
                validator: _validateDeviceName,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deviceIpController,
                decoration: const InputDecoration(
                  labelText: 'Device IP Address *',
                  hintText: 'e.g., 192.168.1.100',
                  prefixIcon: Icon(Icons.wifi),
                  border: OutlineInputBorder(),
                ),
                validator: _validateDeviceIp,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastSyncIntervalController,
                decoration: const InputDecoration(
                  labelText: 'Last Sync Interval (Optional)',
                  hintText: 'e.g., 30 minutes',
                  prefixIcon: Icon(Icons.sync),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _handleSubmit(),
              ),
              const SizedBox(height: 8),
              const Text(
                '* Required fields',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSubmit,
          child:
              _isLoading
                  ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : Text(isUpdateMode ? 'Update' : 'Add Device'),
        ),
      ],
    );
  }
}

// Helper methods to show the dialog
class DeviceDialogHelper {
  /// Show dialog to add a new device
  static Future<BaseResponseModel?> showAddDeviceDialog(
    BuildContext context, {
    required String licenseKey,
    required Future<BaseResponseModel> Function({
      required String licenseKey,
      int? deviceId,
      required String deviceName,
      required String deviceIp,
      String? lastSyncInterval,
    })
    onSubmit,
  }) async {
    return await showDialog<BaseResponseModel>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => DeviceDialog(licenseKey: licenseKey, onSubmit: onSubmit),
    );
  }

  /// Show dialog to update an existing device
  static Future<BaseResponseModel?> showUpdateDeviceDialog(
    BuildContext context, {
    required String licenseKey,
    required int deviceId,
    required String initialDeviceName,
    required String initialDeviceIp,
    String? initialLastSyncInterval,
    required Future<BaseResponseModel> Function({
      required String licenseKey,
      int? deviceId,
      required String deviceName,
      required String deviceIp,
      String? lastSyncInterval,
    })
    onSubmit,
  }) async {
    return await showDialog<BaseResponseModel>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => DeviceDialog(
            licenseKey: licenseKey,
            deviceId: deviceId,
            initialDeviceName: initialDeviceName,
            initialDeviceIp: initialDeviceIp,
            initialLastSyncInterval: initialLastSyncInterval,
            onSubmit: onSubmit,
          ),
    );
  }
}

// Usage example:
/*
// To add a new device:
final result = await DeviceDialogHelper.showAddDeviceDialog(
  context,
  licenseKey: 'your-license-key',
  onSubmit: yourApiService.addOrUpdateDevice,
);

// To update an existing device:
final result = await DeviceDialogHelper.showUpdateDeviceDialog(
  context,
  licenseKey: 'your-license-key',
  deviceId: 123,
  initialDeviceName: 'Current Device Name',
  initialDeviceIp: '192.168.1.100',
  initialLastSyncInterval: '30 minutes',
  onSubmit: yourApiService.addOrUpdateDevice,
);
*/
