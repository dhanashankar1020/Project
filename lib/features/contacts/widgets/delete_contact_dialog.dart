import 'package:flutter/material.dart';

class DeleteContactDialog extends StatelessWidget {
  const DeleteContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Contact"),
      content: const Text(
        "Are you sure you want to delete this contact?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}