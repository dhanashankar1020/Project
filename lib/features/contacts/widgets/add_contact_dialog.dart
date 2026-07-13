import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import 'package:flutter/services.dart';
class AddContactDialog extends StatefulWidget {
  final ContactModel? contact;

  const AddContactDialog({
    super.key,
    this.contact,
  });

  @override
  State<AddContactDialog> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _relationshipController = TextEditingController();

  @override
  void dispose() {
    
    _nameController.dispose();
    _phoneController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }
  @override
void initState() {
  super.initState();

  if (widget.contact != null) {
    _nameController.text = widget.contact!.name;
    _phoneController.text = widget.contact!.phoneNumber;
    _relationshipController.text = widget.contact!.relationship;
  }
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
  widget.contact == null
      ? "Add Emergency Contact"
      : "Edit Emergency Contact",
),
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
              inputFormatters: [
               FilteringTextInputFormatter.digitsOnly,
               LengthLimitingTextInputFormatter(10),
            ],
               decoration: const InputDecoration(
               labelText: "Phone Number",
               prefixIcon: Icon(Icons.phone),
               hintText: "Enter mobile number",
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
    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _relationshipController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }
    if (_phoneController.text.length != 10) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Phone number must contain exactly 10 digits"),
    ),
  );
  return;
}

    final contact = ContactModel(
      id: widget.contact?.id ??
    DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      relationship: _relationshipController.text.trim(),
      icon: Icons.person,
      color: Colors.blue,
    );

    Navigator.pop(context, contact);
  },
  child: const Text("Save"),
)
      ],
    );
  }
}