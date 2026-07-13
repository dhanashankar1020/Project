import 'package:flutter/material.dart';
import '../models/contact_model.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onCall;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPrimary;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onCall,
    required this.onEdit,
    required this.onDelete,
    required this.onPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: contact.color.withOpacity(0.15),
          child: Icon(
            contact.icon,
            color: contact.color,
          ),
        ),

        title: Row(
          children: [
            Expanded(
              child: Text(
                contact.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (contact.isPrimary)
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
          ],
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.phoneNumber),
            Text(
              contact.relationship,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),

        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case "call":
                onCall();
                break;

              case "primary":
                onPrimary();
                break;

              case "edit":
                onEdit();
                break;

              case "delete":
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: "call",
              child: Text("📞 Call"),
            ),
            const PopupMenuItem(
              value: "primary",
              child: Text("⭐ Set Primary"),
            ),
            const PopupMenuItem(
              value: "edit",
              child: Text("✏ Edit"),
            ),
            const PopupMenuItem(
              value: "delete",
              child: Text("🗑 Delete"),
            ),
          ],
        ),
      ),
    );
  }
}