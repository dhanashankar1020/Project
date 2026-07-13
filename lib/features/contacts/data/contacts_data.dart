import 'package:flutter/material.dart';

class EmergencyService {
  final String name;
  final String phoneNumber;
  final IconData icon;
  final Color color;

  const EmergencyService({
    required this.name,
    required this.phoneNumber,
    required this.icon,
    required this.color,
  });
}

class ContactsData {
  static const List<EmergencyService> emergencyServices = [
    EmergencyService(
      name: "Police",
      phoneNumber: "100",
      icon: Icons.local_police,
      color: Colors.blue,
    ),
    EmergencyService(
      name: "Ambulance",
      phoneNumber: "108",
      icon: Icons.medical_services,
      color: Colors.red,
    ),
    EmergencyService(
      name: "Fire Station",
      phoneNumber: "101",
      icon: Icons.local_fire_department,
      color: Colors.orange,
    ),
    EmergencyService(
      name: "Disaster Helpline",
      phoneNumber: "1070",
      icon: Icons.support_agent,
      color: Colors.green,
    ),
  ];
}