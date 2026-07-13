import 'package:flutter/material.dart';

import '../data/contacts_data.dart';
import '../models/contact_model.dart';
import '../services/contacts_service.dart';
import '../widgets/contact_card.dart';
import '../widgets/emergency_service_card.dart';
import '../widgets/add_contact_dialog.dart';
import '../widgets/delete_contact_dialog.dart';
import '../../../services/phone_service.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ContactsService _contactsService = ContactsService();

  @override
  Widget build(BuildContext context) {
    final emergencyServices = ContactsData.emergencyServices;
    final List<ContactModel> contacts = _contactsService.getContacts();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Emergency Contacts",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

     floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.blue,
  child: const Icon(Icons.add, color: Colors.white),
  onPressed: () async {
  final newContact = await showDialog<ContactModel>(
    context: context,
    builder: (_) => const AddContactDialog(),
  );

  if (!mounted) return;

  if (newContact != null) {
    await _contactsService.addContact(newContact);

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Contact Added Successfully"),
      ),
    );
  }
},
),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "🚨 Emergency Services",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          ...emergencyServices.map(
            (service) => EmergencyServiceCard(
              name: service.name,
              phoneNumber: service.phoneNumber,
              icon: service.icon,
              color: service.color,
              onCall: () {
  PhoneService.makePhoneCall(service.phoneNumber);
},
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "👨 My Emergency Contacts",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          if (contacts.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "No Emergency Contacts Added",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

          ...contacts.map(
            (contact) => ContactCard(
              contact: contact,

              onCall: () {
  PhoneService.makePhoneCall(contact.phoneNumber);
},
              onEdit: () async {
  final updatedContact = await showDialog<ContactModel>(
    context: context,
    builder: (_) => AddContactDialog(contact: contact),
  );

  if (!mounted) return;

  if (updatedContact != null) {
    await _contactsService.updateContact(updatedContact);

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Contact Updated Successfully"),
      ),
    );
  }
},

             onDelete: () async {
  final shouldDelete = await showDialog<bool>(
    context: context,
    builder: (_) => const DeleteContactDialog(),
  );

  if (!context.mounted) return;

  if (shouldDelete == true) {
    await _contactsService.removeContact(contact.id);

if (!mounted) return;

setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Contact Deleted Successfully"),
      ),
    );
  }
},

              onPrimary: () async {
  await _contactsService.togglePrimary(contact.id);

  if (!mounted) return;

  setState(() {});
},
            ),
          ),
        ],
      ),
    );
  }
  @override
void initState() {
  super.initState();
  _loadContacts();
}

Future<void> _loadContacts() async {
  await _contactsService.loadContacts();

  if (!mounted) return;

  setState(() {});
}
}