import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> showAddOrUpdateDesignationDialog({
  required BuildContext context,
  String? title,
  String? initialDesignation,
  int? id,
  required Function(String value, int? id) onSubmit,
}) async {
  final TextEditingController designationController = TextEditingController(
    text: initialDesignation ?? "",
  );

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title ?? ""),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: designationController,
                decoration: InputDecoration(
                  labelText: "$title Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (designationController.text.trim().isNotEmpty) {
                onSubmit(designationController.text.trim(), id);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$title name cannot be empty")),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}

Future<void> showDeleteConfirmation({
  required BuildContext context,
  required String name,
  required String title,
  required VoidCallback onConfirm,
}) async {
  await showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Delete $title"),
          content: Text("Are you sure you want to delete '$name'?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        ),
  );
}

Future<void> showAddOrUpdateWithDateDialog({
  required BuildContext context,
  String? title,
  String? initialValue,
  DateTime? initialDate,
  required Function(String value, DateTime selectedDate) onSubmit,
}) async {
  final TextEditingController textController = TextEditingController(
    text: initialValue ?? "",
  );
  DateTime selectedDate = initialDate ?? DateTime.now();
  final TextEditingController dateController = TextEditingController(
    text: DateFormat("yyyy-MM-dd").format(selectedDate),
  );

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title ?? "Add / Update"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: "$title Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Select Date",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                    dateController.text = DateFormat(
                      "yyyy-MM-dd",
                    ).format(selectedDate);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                onSubmit(textController.text.trim(), selectedDate);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$title name cannot be empty")),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}
