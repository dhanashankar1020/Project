import 'package:flutter/material.dart';

class EmergencyServiceCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final IconData icon;
  final Color color;
  final VoidCallback onCall;

  const EmergencyServiceCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.icon,
    required this.color,
    required this.onCall,
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
          backgroundColor: color.withOpacity(0.15),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(phoneNumber),
        trailing: IconButton(
          icon: const Icon(
            Icons.call,
            color: Colors.green,
          ),
          onPressed: onCall,
        ),
      ),
    );
  }
}