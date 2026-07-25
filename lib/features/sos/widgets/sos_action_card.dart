import 'package:flutter/material.dart';
import '../models/sos_action.dart';

class SosActionCard extends StatelessWidget {
  final SosAction action;

  const SosActionCard({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: action.color.withValues(alpha: 0.2),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: action.onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),

          leading: CircleAvatar(
            radius: 26,
            backgroundColor: action.color.withValues(alpha: 0.15),
            child: Icon(action.icon, color: action.color, size: 28),
          ),

          title: Text(
            action.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              action.description,
              style: const TextStyle(fontSize: 14),
            ),
          ),

          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        ),
      ),
    );
  }
}
