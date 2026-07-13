import 'package:flutter/material.dart';
import '../models/contact_model.dart';

class EditContactDialog extends StatefulWidget {
  final ContactModel contact;

  const EditContactDialog({
    super.key,
    required this.contact,
  });

  @override
  State<EditContactDialog> createState() => _EditContactDialogState();
}

class _EditContactDialogState extends State<EditContactDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _relationshipController;

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.contact.name);

    _phoneController =
        TextEditingController(text: widget.contact.phoneNumber);

    _relationshipController =
        TextEditingController(text: widget.contact.relationship);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Contact"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _relationshipController,
              decoration: const InputDecoration(
                labelText: "Relationship",
                prefixIcon: Icon(Icons.people),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Update feature coming next"),
              ),
            );

            Navigator.pop(context);
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}