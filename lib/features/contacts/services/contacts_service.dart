
import '../models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ContactsService {
  // Temporary contact list (Phase 2.1)
  static const String _storageKey = "emergency_contacts";
  final List<ContactModel> _contacts = [];

  List<ContactModel> getContacts() {
    return _contacts;
  }
  Future<void> saveContacts() async {
  final prefs = await SharedPreferences.getInstance();

  final contactsJson =
      _contacts.map((contact) => contact.toJson()).toList();

  await prefs.setStringList(_storageKey, contactsJson);
}

Future<void> loadContacts() async {
  final prefs = await SharedPreferences.getInstance();

  final contactsJson = prefs.getStringList(_storageKey);

  if (contactsJson != null) {
    _contacts
      ..clear()
      ..addAll(
        contactsJson.map(
          (json) => ContactModel.fromJson(json),
        ),
      );
  }
}

  Future<void> addContact(ContactModel contact) async {
  await loadContacts();

  _contacts.add(contact);

  await saveContacts();
}
  Future<void> updateContact(ContactModel updatedContact) async {
  await loadContacts();

  final index = _contacts.indexWhere((c) => c.id == updatedContact.id);

  if (index != -1) {
    _contacts[index] = updatedContact;
    await saveContacts();
  }
}

 Future<void> removeContact(String id) async {
  await loadContacts();

  _contacts.removeWhere((c) => c.id == id);

  await saveContacts();
}


  Future<void> togglePrimary(String id) async {
    final index = _contacts.indexWhere((contact) => contact.id == id);

    if (index != -1) {
      final contact = _contacts[index];

      _contacts[index] = contact.copyWith(
       isPrimary: !contact.isPrimary,

      );
    }
    await saveContacts();
  }
  Future<List<String>> getAllPhoneNumbers() async {
  final prefs = await SharedPreferences.getInstance();

  final contactsJson = prefs.getStringList(_storageKey);

  if (contactsJson == null || contactsJson.isEmpty) {
    return [];
  }

  final contacts = contactsJson
      .map((json) => ContactModel.fromJson(json))
      .toList();

  return contacts.map((contact) => contact.phoneNumber).toList();
}
}
