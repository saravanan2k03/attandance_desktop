import 'package:flutter/material.dart';

class LeaveStatusDialog extends StatefulWidget {
  final int leaveId;
  final Future<void> Function({required int leaveId, required String action})
  onSubmit;

  const LeaveStatusDialog({
    super.key,
    required this.leaveId,
    required this.onSubmit,
  });

  @override
  State<LeaveStatusDialog> createState() => _LeaveStatusDialogState();
}

class _LeaveStatusDialogState extends State<LeaveStatusDialog> {
  String? selectedAction; // "approve" or "reject"
  bool _isLoading = false;

  Future<void> _handleSubmit() async {
    if (selectedAction == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an action."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.onSubmit(leaveId: widget.leaveId, action: selectedAction!);

      if (mounted) {
        Navigator.of(context).pop(); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Leave ${selectedAction!}ed successfully"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Leave Action"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Choose an action for this leave request:"),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedAction,
            items: const [
              DropdownMenuItem(value: "approve", child: Text("Approve")),
              DropdownMenuItem(value: "reject", child: Text("Reject")),
            ],
            onChanged: (value) => setState(() => selectedAction = value),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Action",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
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
                  : const Text("Submit"),
        ),
      ],
    );
  }
}
