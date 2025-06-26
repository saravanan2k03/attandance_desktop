import 'package:flutter/material.dart';

class AddLeaveDialog extends StatefulWidget {
  final List<String> leaveTypes;
  final Function(String, int) onSubmit;

  const AddLeaveDialog({
    required this.leaveTypes,
    required this.onSubmit,
    super.key,
  });

  @override
  State<AddLeaveDialog> createState() => _AddLeaveDialogState();
}

class _AddLeaveDialogState extends State<AddLeaveDialog> {
  String? selectedLeaveType;
  final TextEditingController countController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Leave"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Leave Type"),
            items:
                widget.leaveTypes
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                selectedLeaveType = value;
              });
            },
          ),
          const SizedBox(height: 10),
          TextField(
            controller: countController,
            decoration: const InputDecoration(labelText: "Count"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedLeaveType != null &&
                countController.text.trim().isNotEmpty) {
              widget.onSubmit(
                selectedLeaveType!,
                int.tryParse(countController.text.trim()) ?? 0,
              );
              Navigator.pop(context);
            }
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
